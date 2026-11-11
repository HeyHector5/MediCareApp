# MediCare App — Branding y reglas de diseño

> Este archivo es la guía de diseño obligatoria del proyecto MediCare App.
> Todo el código, las pantallas y los textos deben cumplir estas reglas **sin excepciones**.
> Si algo no está definido aquí, no inventarlo: usa el valor más cercano de esta guía y avisa al usuario de que falta una regla.
>
> Todo lo que es código o base de datos va en **inglés** (clases, variables, funciones, colecciones, campos y valores guardados en Firestore). Solo los textos que ve el usuario van en **español**. Los nombres de colecciones, campos y valores están en `docs/data-model.md`: usarlos exactamente así.

---

## 1. Identidad de marca

- **Nombre:** MediCare (una sola palabra, M y C mayúsculas). Nunca "Medicare", "MEDICARE" ni "Medi Care".
- **Qué es:** app para que los pacientes reserven, cancelen y consulten citas médicas.
- **Lema:** Tu salud, a tiempo.
- **Personalidad:** confiable, cercana, clara, tranquila.

### Tono de voz

- Háblale al usuario de **tú**, en español neutro.
- Frases cortas (máximo 2 líneas en móvil) y en voz activa.
- Los errores dicen qué pasó y qué hacer, sin culpar al usuario.
- Nunca muestres tecnicismos en textos visibles ("Firestore", "token", "null", "exception").
- Los botones dicen la acción concreta: "Reservar cita", no "Aceptar" ni "OK".
- Escribe con ortografía y tildes correctas: "Contraseña", "Próxima", "Médico".

| Sí | No |
| --- | --- |
| Tu cita quedó reservada para el lunes 9 de noviembre a las 10:30 a. m. | Operación realizada exitosamente. |
| No pudimos conectarnos. Revisa tu internet e inténtalo de nuevo. | Error: FirebaseException [unavailable]. |
| ¿Seguro que quieres cancelar esta cita? | ¿Desea usted proceder con la cancelación? |

---

## 2. Logotipo

- **Isotipo:** cruz médica de esquinas redondeadas con un check blanco en el centro.
- **Texto:** "Medi" en Poppins Bold color `#0E7C86` + "Care" en Poppins Regular color `#1E3A5F`.
- **Versiones:** horizontal (login, registro, bienvenida), isotipo solo (ícono de la app, splash), monocromo blanco (sobre fondo primario).
- **Tamaño mínimo:** isotipo 24 px; versión horizontal 120 px de ancho.
- **Prohibido:** cambiar colores, deformar, rotar, añadir sombras, bordes o degradados.

---

## 3. Colores

Usa **solo** estos colores y **siempre** a través de `AppColors`.

### Marca

| Nombre | HEX | Constante | Uso |
| --- | --- | --- | --- |
| Primario | `#0E7C86` | `AppColors.primary` | Botones principales, enlaces, ítem activo del menú, íconos de acción. |
| Primario oscuro | `#0A5C63` | `AppColors.primaryDark` | Botón presionado, texto sobre Primario claro. |
| Primario claro | `#E6F4F5` | `AppColors.primaryLight` | Fondo de chips, tarjeta seleccionada, fondo de íconos. |
| Azul marino | `#1E3A5F` | `AppColors.secondary` | Títulos grandes y encabezados. |

### Neutros

| Nombre | HEX | Constante | Uso |
| --- | --- | --- | --- |
| Fondo | `#F7F9FA` | `AppColors.background` | Fondo de todas las pantallas. |
| Superficie | `#FFFFFF` | `AppColors.surface` | Tarjetas, campos, diálogos, menú inferior. |
| Borde | `#DDE3E7` | `AppColors.border` | Bordes y divisores. |
| Texto principal | `#1A2B33` | `AppColors.textPrimary` | Texto normal. |
| Texto secundario | `#5B6B73` | `AppColors.textSecondary` | Subtítulos, fechas, ayudas. |
| Deshabilitado | `#A7B4BA` | `AppColors.disabled` | Elementos inactivos. Nunca para texto que deba leerse. |

### Estados

| Nombre | HEX | Constante | Fondo suave | Uso |
| --- | --- | --- | --- | --- |
| Éxito | `#2E7D32` | `AppColors.success` | `#E8F5E9` | Cita completada, guardado correcto. |
| Advertencia | `#9A5B00` | `AppColors.warning` | `#FFF4E0` | Cita hoy o mañana, datos incompletos. |
| Error | `#D32F2F` | `AppColors.error` | `#FDECEC` | Errores, cita cancelada, acciones destructivas. |
| Información | `#0277BD` | `AppColors.info` | `#E3F2FD` | Cita programada, avisos neutros. |

### Reglas de color

- **Prohibido** `Color(0xFF...)` o `Colors.xxx` fuera de `lib/core/theme/app_colors.dart` (excepción: `Colors.white` y `Colors.transparent`).
- El primario es para acciones, no para fondos de pantalla completa.
- Texto sobre primario o sobre un color de estado fuerte: blanco.
- Texto sobre un fondo suave de estado: el color fuerte de ese estado.
- Solo modo claro.

---

## 4. Tipografía

Dos fuentes, cargadas con `google_fonts`: **Poppins** (títulos) e **Inter** (todo lo demás). Ninguna otra.

| Estilo Flutter | Fuente | Tamaño / interlineado | Peso | Uso |
| --- | --- | --- | --- | --- |
| `headlineLarge` | Poppins | 28 / 36 | 600 | Saludo de inicio, bienvenida. Máximo uno por pantalla. |
| `headlineSmall` | Poppins | 22 / 30 | 600 | Título principal de la pantalla. |
| `titleLarge` | Poppins | 18 / 26 | 600 | Título del AppBar, encabezados de sección. |
| `titleMedium` | Inter | 16 / 24 | 600 | Nombre del médico, título de tarjeta. |
| `bodyLarge` | Inter | 16 / 24 | 400 | Texto principal, contenido de campos. |
| `bodyMedium` | Inter | 14 / 20 | 400 | Descripciones, detalles. |
| `bodySmall` | Inter | 12 / 16 | 400 | Fechas, ayudas, pies de tarjeta. |
| `labelLarge` | Inter | 14 / 20 | 600 | Texto de botones. |
| `labelSmall` | Inter | 12 / 16 | 500 | Chips de estado, etiquetas del menú inferior. |

- Usa siempre `Theme.of(context).textTheme.<estilo>`. **Prohibido** `TextStyle(fontSize: ...)` en pantallas.
- Para cambiar el color: `.copyWith(color: AppColors.xxx)`.
- Sin texto en mayúsculas sostenidas (salvo siglas). Texto alineado a la izquierda; solo se centran estados vacíos y la bienvenida.
- Tamaño mínimo: 12.

---

## 5. Espaciado, bordes y sombras

### Espaciado (múltiplos de 4)

| Constante | Valor | Uso |
| --- | --- | --- |
| `AppSpacing.xs` | 4 | Entre ícono y texto. |
| `AppSpacing.sm` | 8 | Entre elementos de una tarjeta. |
| `AppSpacing.md` | 16 | Margen lateral de pantallas, entre tarjetas, padding de tarjetas. |
| `AppSpacing.lg` | 24 | Entre secciones. |
| `AppSpacing.xl` | 32 | Antes del botón principal de un formulario. |
| `AppSpacing.xxl` | 48 | Espacio superior en bienvenida, login y estados vacíos. |

**Prohibido** usar números sueltos como `EdgeInsets.all(13)`.

### Radios

| Constante | Valor | Elementos |
| --- | --- | --- |
| `AppRadius.sm` | 8 | Chips de horario. |
| `AppRadius.md` | 12 | Botones y campos. |
| `AppRadius.lg` | 16 | Tarjetas. |
| `AppRadius.xl` | 24 | Diálogos y bottom sheets (solo esquinas superiores). |
| `AppRadius.full` | 999 | Chips de estado, avatares. |

### Sombras

- Tarjetas: **sin sombra**, fondo `surface` + borde 1 px `border`.
- Solo diálogos, bottom sheets y botón flotante llevan elevación (3).
- Menú inferior: divisor superior 1 px `border`, sin sombra.

### Estructura de pantalla

- Margen lateral de 16.
- Contenido dentro de `SafeArea`, con scroll si puede superar la altura.
- En formularios, el botón principal va al final y de ancho completo.

---

## 6. Componentes

Todos viven en `lib/core/widgets/`. **Usa siempre el widget común; nunca crees una versión propia.** Si falta un componente, avisa al usuario en vez de crearlo dentro de una carpeta de funcionalidad.

### Botones — `AppButton`

| Tipo | Apariencia | Uso |
| --- | --- | --- |
| Primario | Fondo `primary`, texto blanco | Acción principal. **Uno solo por pantalla.** |
| Secundario | Fondo blanco, borde y texto `primary` | Acción alternativa. |
| Texto | Sin fondo ni borde, texto `primary` | Acciones menores ("¿Olvidaste tu contraseña?"). |
| Destructivo | Fondo blanco, borde y texto `error` | Cancelar cita, cerrar sesión. |

- Altura 48, radio 12, texto `labelLarge`.
- Ancho completo en formularios.
- Mientras carga: deshabilitado y con indicador de 20 px.

### Campos — `AppTextField`

- Fondo blanco, borde 1 px `border`, radio 12, altura mínima 48.
- Enfocado: borde 2 px `primary`. Error: borde 2 px `error` + mensaje debajo en `bodySmall` color `error`.
- Etiqueta siempre visible encima del campo (no solo placeholder).
- Contraseña con botón de mostrar/ocultar.
- Validar al salir del campo o al enviar, no mientras se escribe.

### Tarjetas — `AppCard`

- Fondo `surface`, borde 1 px `border`, radio 16, padding 16, sin sombra.
- **Tarjeta de médico:** avatar de 56 a la izquierda; a la derecha nombre (`titleMedium`), especialidad (`bodyMedium`, `textSecondary`) y próximo horario libre (`bodySmall`).
- **Tarjeta de cita:** fecha y hora (`titleMedium`) con `StatusChip` a la derecha; debajo médico y especialidad (`bodyMedium`).
- La tarjeta completa es tocable; no agregues botón "Ver más".

### Estados de cita — `StatusChip`

En Firestore el estado se guarda en inglés (campo `status`, ver `data-model.md`). En pantalla se muestra en español con este chip:

| Valor en Firestore | Texto visible | Color texto | Fondo |
| --- | --- | --- | --- |
| `scheduled` | Programada | `#0277BD` | `#E3F2FD` |
| `completed` | Completada | `#2E7D32` | `#E8F5E9` |
| `cancelled` | Cancelada | `#D32F2F` | `#FDECEC` |
| `scheduled` y faltan menos de 24 h | Hoy / Mañana | `#9A5B00` | `#FFF4E0` |

"Hoy" y "Mañana" no se guardan: se calculan con `startAt`. No inventes estados nuevos.

Radio completo, padding horizontal 12, texto `labelSmall`.

### Navegación

- **Menú inferior del paciente** (`NavigationBar`), 4 pestañas en este orden: Inicio, Mis citas, Mensajes, Perfil.
- **Menú inferior del médico**, 4 pestañas en este orden: Agenda, Pacientes, Mensajes, Perfil.
- En ambos: activo `primary` con indicador `primaryLight`, inactivo `textSecondary`.
- **AppBar:** fondo `background`, sin sombra, título `titleLarge` a la izquierda, flecha de regreso en pantallas internas.
- **No** muestran el menú inferior: login, registro, reservar cita, cita confirmada, videollamada, chat, registro de la consulta y disponibilidad del médico. Son pantallas de una tarea con su propio botón o campo abajo.

### Diálogos y avisos

- **Confirmación** (acciones irreversibles): título en pregunta, una línea de explicación, botón Texto "Volver" a la izquierda y botón Destructivo a la derecha.
- **SnackBar** (`showAppSnackBar()`): abajo, 4 s, fondo `textPrimary`, texto blanco.
- **Bottom sheet** para elegir fecha, horario o filtros; radio 24 arriba.

---

## 7. Íconos e imágenes

- Solo **Material Icons Rounded** (`Icons.xxx_rounded`). No mezclar estilos ni librerías.
- Tamaño 24 (20 en botones y campos, 48 en estados vacíos). Color `textSecondary`; `primary` si está activo o es acción.

| Concepto | Ícono |
| --- | --- |
| Inicio | `Icons.home_rounded` |
| Citas | `Icons.calendar_month_rounded` |
| Mensajes / chat | `Icons.chat_bubble_rounded` |
| Perfil | `Icons.person_rounded` |
| Especialidad / médico | `Icons.medical_services_rounded` |
| Hora | `Icons.schedule_rounded` |
| Videollamada | `Icons.videocam_rounded` |
| Historial | `Icons.history_rounded` |
| Pacientes (médico) | `Icons.group_rounded` |
| Disponibilidad (médico) | `Icons.event_available_rounded` |
| Notificaciones | `Icons.notifications_rounded` |
| Búsqueda | `Icons.search_rounded` |
| Error | `Icons.error_outline_rounded` |

- Avatares siempre circulares: 40 (listas y chat), 56 (tarjeta de médico), 96 (perfil).
- Sin foto: iniciales en blanco sobre fondo `primary`.

---

## 8. Estados de pantalla

Toda pantalla que carga datos debe manejar estos estados. Nunca una pantalla en blanco ni un error rojo de Flutter.

| Estado | Cómo se ve | Widget |
| --- | --- | --- |
| Cargando | `CircularProgressIndicator` color `primary`, centrado. | `LoadingView` |
| Vacío | Ícono 48 `textSecondary`, título `titleMedium`, una línea de explicación y, si aplica, botón Primario. Centrado. | `EmptyState` |
| Error | Igual que vacío, con `Icons.error_outline_rounded` en `error` y botón "Reintentar". | `ErrorState` |
| Éxito tras acción | SnackBar corto. | `showAppSnackBar()` |

Textos de vacío:

- Mis citas: "No tienes citas próximas" / "Reserva una cita con el especialista que necesites." / botón "Reservar cita".
- Historial: "Aún no tienes consultas" / "Aquí verás las citas que ya completaste."
- Mensajes: "No tienes conversaciones" / "Podrás escribirle a tu médico después de reservar una cita."

### Formato de datos

Siempre con las funciones de `lib/core/utils/formatters.dart` (paquete `intl`, locale `es`).

| Dato | Ejemplo |
| --- | --- |
| Fecha larga | lunes, 9 de noviembre de 2026 |
| Fecha corta | lun, 9 nov |
| Hora | 10:30 a. m. |
| Teléfono | 809-555-1234 |
| Médico | Dra. María Pérez / Dr. Juan Gómez |

---

## 9. Accesibilidad

- Contraste mínimo 4.5:1; no inventes combinaciones de color nuevas.
- Área táctil mínima 48 × 48.
- El estado nunca se comunica solo con color (los chips llevan texto).
- La pantalla debe funcionar con el texto del sistema al 130 %; no uses alturas fijas en contenedores con texto.
- Botones con solo ícono: `tooltip` o `Semantics(label: ...)`.

---

## 10. Archivos del tema en Flutter

Estos archivos son los únicos donde se definen colores, fuentes y medidas:

| Archivo | Contenido |
| --- | --- |
| `lib/core/theme/app_colors.dart` | `AppColors` |
| `lib/core/theme/app_spacing.dart` | `AppSpacing` y `AppRadius` |
| `lib/core/theme/app_theme.dart` | `ThemeData` completo |
| `lib/core/widgets/` | `AppButton`, `AppTextField`, `AppCard`, `StatusChip`, `LoadingView`, `EmptyState`, `ErrorState`, `showAppSnackBar()` |
| `lib/core/utils/formatters.dart` | Fechas, horas, teléfonos, nombres |

### `app_colors.dart`

```dart
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF0E7C86);
  static const primaryDark = Color(0xFF0A5C63);
  static const primaryLight = Color(0xFFE6F4F5);
  static const secondary = Color(0xFF1E3A5F);

  static const background = Color(0xFFF7F9FA);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFDDE3E7);
  static const textPrimary = Color(0xFF1A2B33);
  static const textSecondary = Color(0xFF5B6B73);
  static const disabled = Color(0xFFA7B4BA);

  static const success = Color(0xFF2E7D32);
  static const successLight = Color(0xFFE8F5E9);
  static const warning = Color(0xFF9A5B00);
  static const warningLight = Color(0xFFFFF4E0);
  static const error = Color(0xFFD32F2F);
  static const errorLight = Color(0xFFFDECEC);
  static const info = Color(0xFF0277BD);
  static const infoLight = Color(0xFFE3F2FD);
}
```

### `app_spacing.dart`

```dart
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  AppRadius._();

  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 999;
}
```

### `app_theme.dart`

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final inter = GoogleFonts.interTextTheme();
    final poppins = GoogleFonts.poppins(
      color: AppColors.secondary,
      fontWeight: FontWeight.w600,
    );

    final textTheme = inter
        .copyWith(
          headlineLarge: poppins.copyWith(fontSize: 28, height: 36 / 28),
          headlineSmall: poppins.copyWith(fontSize: 22, height: 30 / 22),
          titleLarge: poppins.copyWith(fontSize: 18, height: 26 / 18),
          titleMedium: inter.titleMedium?.copyWith(
              fontSize: 16, height: 24 / 16, fontWeight: FontWeight.w600),
          bodyLarge: inter.bodyLarge?.copyWith(fontSize: 16, height: 24 / 16),
          bodyMedium: inter.bodyMedium?.copyWith(fontSize: 14, height: 20 / 14),
          bodySmall: inter.bodySmall?.copyWith(
              fontSize: 12, height: 16 / 12, color: AppColors.textSecondary),
          labelLarge: inter.labelLarge?.copyWith(
              fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w600),
          labelSmall: inter.labelSmall?.copyWith(
              fontSize: 12, height: 16 / 12, fontWeight: FontWeight.w500),
        )
        .apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.secondary,
        );

    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.disabled,
          minimumSize: const Size.fromHeight(48),
          elevation: 0,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          minimumSize: const Size.fromHeight(48),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: border(AppColors.border),
        enabledBorder: border(AppColors.border),
        focusedBorder: border(AppColors.primary, 2),
        errorBorder: border(AppColors.error, 2),
        focusedErrorBorder: border(AppColors.error, 2),
        errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.error),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryLight,
        elevation: 0,
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelSmall),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : AppColors.textSecondary,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
```

---

## 11. Checklist a verificar antes de entregar código

- [ ] No hay `Color(...)`, `Colors.xxx`, `TextStyle(...)` ni medidas sueltas fuera de `lib/core/`.
- [ ] Botones, campos, tarjetas y chips usan los widgets comunes.
- [ ] Un solo botón Primario por pantalla.
- [ ] Margen lateral de 16 y espacios de la escala (4, 8, 16, 24, 32, 48).
- [ ] Íconos Material Rounded según la tabla de la sección 7.
- [ ] La pantalla maneja carga, vacío y error.
- [ ] Los textos están en español, de tú, cortos, sin tecnicismos y sin faltas de ortografía.
- [ ] Fechas y horas con `formatters.dart`.
- [ ] Estados de cita con `StatusChip`, leyendo los valores en inglés de Firestore (`scheduled`, `completed`, `cancelled`).
- [ ] Código, colecciones, campos y valores en inglés, con los nombres exactos de `data-model.md`. Textos visibles en español.
- [ ] Los nombres de colecciones salen de constantes, nunca escritos a mano en cada pantalla.
- [ ] Botones con solo ícono tienen `tooltip` o `Semantics`.