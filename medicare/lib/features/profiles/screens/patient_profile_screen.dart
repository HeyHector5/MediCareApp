import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicare/core/providers/firebase_providers.dart';
import 'package:medicare/core/theme/app_colors.dart';
import 'package:medicare/core/theme/app_spacing.dart';
import 'package:medicare/core/widgets/widgets.dart';
import 'package:medicare/models/models.dart';

import '../providers/profile_providers.dart';

// Profile avatar size from branding.md section 7; AppAvatar has no named size for it.
const double _avatarSize = 96;

const _saveTimeout = Duration(seconds: 10);

final _phonePattern = RegExp(r'^\d{3}-\d{3}-\d{4}$');

class PatientProfileScreen extends ConsumerStatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  ConsumerState<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends ConsumerState<PatientProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();

  String? _loadedUserId;
  DateTime? _birthDate;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // Fill the form once per user so live updates don't overwrite unsaved edits.
    ref.listenManual(currentUserProvider, (_, next) {
      final user = next.value;
      if (user != null && user.id != _loadedUserId) _fillForm(user);
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _fillForm(AppUser user) {
    _loadedUserId = user.id;
    _nameController.text = user.name;
    _phoneController.text = user.phone;
    _setBirthDate(user.birthDate);
  }

  void _setBirthDate(DateTime? date) {
    _birthDate = date;
    _birthDateController.text = date == null ? '' : _formatDate(date);
  }

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 30),
      firstDate: DateTime(1900),
      lastDate: now,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      helpText: 'Elige tu fecha de nacimiento',
      cancelText: 'Volver',
      confirmText: 'Elegir fecha',
    );
    if (picked != null) setState(() => _setBirthDate(picked));
  }

  Future<void> _save(AppUser user) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    try {
      await ref
          .read(profileRepositoryProvider)
          .updateProfile(
            user.copyWith(
              name: _nameController.text.trim(),
              phone: _phoneController.text.trim(),
              birthDate: _birthDate,
            ),
          )
          .timeout(_saveTimeout);
      if (mounted) showAppSnackBar(context, 'Tus cambios se guardaron.');
    } on TimeoutException {
      // Firestore keeps the write queued offline and syncs it on reconnect.
      if (mounted) {
        showAppSnackBar(
          context,
          'Guardamos tus cambios. Se enviarán cuando vuelvas a tener conexión.',
        );
      }
    } catch (_) {
      if (mounted) {
        showAppSnackBar(
          context,
          'No pudimos guardar tus cambios. Revisa tu internet e inténtalo de nuevo.',
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _confirmSignOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const _SignOutDialog(),
    );
    if (confirmed != true || !mounted) return;

    try {
      await ref.read(firebaseAuthProvider).signOut();
    } catch (_) {
      if (mounted) {
        showAppSnackBar(context, 'No pudimos cerrar tu sesión. Inténtalo de nuevo.');
      }
    }
  }

  void _retry() => ref.invalidate(currentUserProvider);

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: userAsync.when(
          loading: () => const LoadingView(),
          error: (_, _) => ErrorState(onRetry: _retry),
          data: (user) => user == null
              ? ErrorState(
                  title: 'No encontramos tu perfil',
                  message: 'Inicia sesión de nuevo para ver tus datos.',
                  onRetry: _retry,
                )
              : _buildForm(user),
        ),
      ),
    );
  }

  Widget _buildForm(AppUser user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ProfileHeader(user: user),
            const SizedBox(height: AppSpacing.lg),
            AppTextField(
              label: 'Nombre completo',
              controller: _nameController,
              enabled: !_saving,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: _validateName,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Teléfono',
              controller: _phoneController,
              hint: '809-555-1234',
              enabled: !_saving,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              validator: _validatePhone,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Fecha de nacimiento',
              controller: _birthDateController,
              hint: 'dd/mm/aaaa',
              prefixIcon: Icons.calendar_month_rounded,
              enabled: !_saving,
              readOnly: true,
              onTap: _pickBirthDate,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Guardar cambios',
              isLoading: _saving,
              onPressed: () => _save(user),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Cerrar sesión',
              variant: AppButtonVariant.destructive,
              onPressed: _saving ? null : _confirmSignOut,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        AppAvatar(name: user.name, size: _avatarSize),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name, style: textTheme.titleMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                user.email,
                style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignOutDialog extends StatelessWidget {
  const _SignOutDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      title: const Text('¿Seguro que quieres cerrar sesión?'),
      content: const Text('Tendrás que volver a entrar para ver tus citas.'),
      actions: [
        AppButton(
          label: 'Volver',
          variant: AppButtonVariant.text,
          expand: false,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppButton(
          label: 'Cerrar sesión',
          variant: AppButtonVariant.destructive,
          expand: false,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}

String? _validateName(String? value) {
  if (value == null || value.trim().isEmpty) return 'Escribe tu nombre completo.';
  return null;
}

String? _validatePhone(String? value) {
  if (value == null || !_phonePattern.hasMatch(value.trim())) {
    return 'Escribe tu teléfono con el formato 809-555-1234.';
  }
  return null;
}

// Temporary until lib/core/utils/formatters.dart exists.
String _formatDate(DateTime date) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  return '$day/$month/${date.year}';
}
