# Diagrama de Arquitectura N Capas - Sistema de Reservas de Hotel

```
┌─────────────────────────────────────────────────────────────────────┐
│                     CAPA DE PRESENTACIÓN (Web)                      │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────────┐ │
│  │  Index.aspx  │  │Principal.aspx│  │ RecuperarPassword.aspx  │ │
│  │   (Login)    │  │ (Dashboard)  │  │   (Recovery)            │ │
│  └──────┬───────┘  └──────┬───────┘  └──────────┬───────────────┘ │
│         │                 │                      │                 │
│         └─────────────────┴──────────────────────┘                 │
│                           │                                         │
└───────────────────────────┼─────────────────────────────────────────┘
                            │
                   Session Management
                   Validation Controls
                            │
┌───────────────────────────┼─────────────────────────────────────────┐
│              CAPA DE LÓGICA DE NEGOCIO (Negocio)                   │
│                           │                                         │
│  ┌────────────────────────▼────────────────────────┐               │
│  │         UsuarioNegocio.cs                       │               │
│  ├─────────────────────────────────────────────────┤               │
│  │ • ValidarCredenciales()                         │               │
│  │ • ActualizarUltimoAcceso()                      │               │
│  │ • ObtenerPorNombreUsuario()                     │               │
│  │ • RegistrarUsuario()                            │               │
│  │ • ValidarDatosUsuario()                         │               │
│  │ • EncriptarPassword()                           │               │
│  └────────────────────┬────────────────────────────┘               │
│                       │                                             │
│           Reglas de Negocio y Validaciones                         │
└───────────────────────┼─────────────────────────────────────────────┘
                        │
┌───────────────────────┼─────────────────────────────────────────────┐
│             CAPA DE ACCESO A DATOS (Datos)                         │
│                       │                                             │
│  ┌────────────────────▼──────────────┐  ┌──────────────────────┐  │
│  │      Conexion.cs                  │  │  UsuarioDatos.cs     │  │
│  ├───────────────────────────────────┤  ├──────────────────────┤  │
│  │ • ObtenerConexion()               │  │ • ValidarUsuario()   │  │
│  │ • EjecutarConsulta()              │  │ • ActualizarAcceso() │  │
│  │ • EjecutarComando()               │  │ • ObtenerPorNombre() │  │
│  │ • EjecutarEscalar()               │  │ • InsertarUsuario()  │  │
│  │ • EjecutarProcedimiento()         │  │                      │  │
│  └───────────────────────────────────┘  └──────────────────────┘  │
│                       │                                             │
│              ADO.NET - SqlConnection                                │
└───────────────────────┼─────────────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────────────────┐
│                    BASE DE DATOS (SQL Server)                       │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐             │
│  │   Usuarios   │  │ Habitaciones │  │   Clientes   │             │
│  └──────────────┘  └──────────────┘  └──────────────┘             │
│  ┌──────────────┐  ┌──────────────┐                                │
│  │   Reservas   │  │    Pagos     │                                │
│  └──────────────┘  └──────────────┘                                │
│                                                                     │
│  Procedimientos Almacenados:                                        │
│  • sp_HabitacionesDisponibles                                       │
│  • sp_EstadisticasDia                                               │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│                    CAPA DE ENTIDADES (Entidades)                    │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐             │
│  │  Usuario.cs  │  │ Reserva.cs   │  │Habitacion.cs │             │
│  ├──────────────┤  ├──────────────┤  ├──────────────┤             │
│  │ • UsuarioId  │  │ • ReservaId  │  │• HabitacionId│             │
│  │ • NombreUsr  │  │ • ClienteId  │  │• Numero      │             │
│  │ • Password   │  │ • Fechas     │  │• Tipo        │             │
│  │ • Email      │  │ • Estado     │  │• Precio      │             │
│  │ • Rol        │  │ • Precio     │  │• Estado      │             │
│  └──────────────┘  └──────────────┘  └──────────────┘             │
│                                                                     │
│  POCOs - Plain Old CLR Objects (Modelos de Datos)                  │
└─────────────────────────────────────────────────────────────────────┘

═══════════════════════════════════════════════════════════════════════
                        FLUJO DE DATOS (Login)
═══════════════════════════════════════════════════════════════════════

1. Usuario ingresa credenciales en Index.aspx
         │
         ▼
2. btnIniciarSesion_Click() captura el evento
         │
         ▼
3. Llama a UsuarioNegocio.ValidarCredenciales()
         │
         ▼
4. UsuarioNegocio aplica validaciones de negocio
         │
         ▼
5. Llama a UsuarioDatos.ValidarUsuario()
         │
         ▼
6. UsuarioDatos ejecuta query SQL
         │
         ▼
7. SQL Server retorna los datos del usuario
         │
         ▼
8. UsuarioDatos construye objeto Usuario
         │
         ▼
9. UsuarioNegocio retorna Usuario a Presentación
         │
         ▼
10. Index.aspx crea sesión y redirige a Principal.aspx


═══════════════════════════════════════════════════════════════════════
                    VENTAJAS DE ESTA ARQUITECTURA
═══════════════════════════════════════════════════════════════════════

✓ Separación de Responsabilidades
  Cada capa tiene una función específica y bien definida

✓ Mantenibilidad
  Cambios en una capa no afectan a las demás

✓ Escalabilidad
  Fácil agregar nuevas funcionalidades

✓ Reutilización de Código
  La lógica de negocio puede usarse en múltiples interfaces

✓ Testabilidad
  Cada capa puede probarse independientemente

✓ Seguridad
  Separación clara entre datos, lógica y presentación

✓ Trabajo en Equipo
  Diferentes desarrolladores pueden trabajar en diferentes capas
```
