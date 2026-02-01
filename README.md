# Sistema de Reservas de Hotel - Arquitectura N Capas

## 📋 Descripción del Proyecto

Sistema de gestión de reservas de habitaciones de hotel desarrollado en ASP.NET Web Forms con arquitectura N capas, que permite administrar usuarios, habitaciones, clientes y reservas de manera eficiente y segura.

## 🏗️ Arquitectura del Sistema

El proyecto está organizado en 4 capas principales siguiendo el patrón de arquitectura N capas:

### 1. **Capa de Presentación (Presentacion)**
   - Interfaz de usuario web
   - Páginas ASPX y código behind
   - Validación de datos en el cliente
   - Gestión de sesiones

### 2. **Capa de Lógica de Negocio (Negocio)**
   - Reglas de negocio
   - Validaciones
   - Lógica de procesamiento
   - Intermediario entre Presentación y Datos

### 3. **Capa de Acceso a Datos (Datos)**
   - Conexión a base de datos
   - Ejecución de consultas SQL
   - Procedimientos almacenados
   - Operaciones CRUD

### 4. **Capa de Entidades (Entidades)**
   - Clases de modelo
   - POCOs (Plain Old CLR Objects)
   - Propiedades de datos

## 📁 Estructura del Proyecto

```
SistemaReservasHotel/
│
├── Presentacion/              # Capa de Presentación (Web)
│   ├── Index.aspx            # Página de Login
│   ├── Index.aspx.cs         # Código behind del Login
│   ├── Principal.aspx        # Panel Principal
│   ├── Principal.aspx.cs     # Código behind del Panel
│   ├── RecuperarPassword.aspx     # Recuperación de contraseña
│   ├── RecuperarPassword.aspx.cs  # Código behind de recuperación
│   └── Web.config            # Configuración de la aplicación
│
├── Negocio/                  # Capa de Lógica de Negocio
│   └── UsuarioNegocio.cs     # Lógica de negocio de usuarios
│
├── Datos/                    # Capa de Acceso a Datos
│   ├── Conexion.cs           # Clase de conexión a BD
│   └── UsuarioDatos.cs       # Acceso a datos de usuarios
│
├── Entidades/                # Capa de Entidades
│   ├── Usuario.cs            # Entidad Usuario
│   ├── Reserva.cs            # Entidad Reserva
│   └── Habitacion.cs         # Entidad Habitación
│
└── Database/                 # Scripts de Base de Datos
    └── CreateDatabase.sql    # Script de creación de BD
```

## 🔧 Requisitos del Sistema

### Software Necesario:
- Visual Studio 2019 o superior
- .NET Framework 4.7.2 o superior
- SQL Server 2016 o superior (Express, Developer o Standard)
- IIS Express (incluido con Visual Studio)

### Navegadores Compatibles:
- Google Chrome (recomendado)
- Mozilla Firefox
- Microsoft Edge
- Safari

## 📦 Instalación y Configuración

### 1. Clonar o Descargar el Proyecto

```bash
git clone [URL_DEL_REPOSITORIO]
cd SistemaReservasHotel
```

### 2. Configurar la Base de Datos

**Opción A: SQL Server con SQL Server Management Studio**

1. Abrir SQL Server Management Studio (SSMS)
2. Conectarse a su instancia de SQL Server
3. Abrir el archivo `Database/CreateDatabase.sql`
4. Ejecutar el script completo (F5)
5. Verificar que la base de datos "HotelDB" se creó correctamente

**Opción B: SQL Server desde Visual Studio**

1. En Visual Studio, ir a View → SQL Server Object Explorer
2. Conectarse a la instancia local
3. Clic derecho en "Databases" → New Query
4. Copiar y pegar el contenido de `CreateDatabase.sql`
5. Ejecutar el script

### 3. Configurar la Cadena de Conexión

Editar el archivo `Presentacion/Web.config`:

**Para SQL Server con Windows Authentication:**
```xml
<connectionStrings>
    <add name="HotelDB" 
         connectionString="Data Source=localhost;Initial Catalog=HotelDB;Integrated Security=True" 
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

**Para SQL Server con SQL Authentication:**
```xml
<connectionStrings>
    <add name="HotelDB" 
         connectionString="Data Source=localhost;Initial Catalog=HotelDB;User ID=sa;Password=TuPassword" 
         providerName="System.Data.SqlClient" />
</connectionStrings>
```

**Notas:**
- Reemplazar `localhost` con el nombre de tu servidor SQL
- Si usas SQL Express: `Data Source=localhost\SQLEXPRESS`
- Para SQL Server remoto, usar la dirección IP o nombre del servidor

### 4. Crear la Solución en Visual Studio

1. Abrir Visual Studio
2. File → New → Project
3. Seleccionar "Blank Solution"
4. Nombre: `SistemaReservasHotel`

**Crear los Proyectos:**

**a) Proyecto de Presentación (Web)**
   - Add → New Project → ASP.NET Web Application (.NET Framework)
   - Nombre: `Presentacion`
   - Template: Empty
   - Copiar los archivos ASPX y Web.config

**b) Proyecto de Negocio**
   - Add → New Project → Class Library (.NET Framework)
   - Nombre: `Negocio`
   - Agregar referencia al proyecto `Entidades` y `Datos`
   - Copiar el archivo `UsuarioNegocio.cs`

**c) Proyecto de Datos**
   - Add → New Project → Class Library (.NET Framework)
   - Nombre: `Datos`
   - Agregar referencia a:
     - `System.Configuration`
     - `System.Data`
     - Proyecto `Entidades`
   - Copiar los archivos `Conexion.cs` y `UsuarioDatos.cs`

**d) Proyecto de Entidades**
   - Add → New Project → Class Library (.NET Framework)
   - Nombre: `Entidades`
   - Copiar los archivos de entidades

**e) Referencias del Proyecto Web**
   - En `Presentacion`, agregar referencias a:
     - `Negocio`
     - `Entidades`

### 5. Compilar y Ejecutar

1. Build → Build Solution (Ctrl+Shift+B)
2. Establecer `Presentacion` como proyecto de inicio (clic derecho → Set as StartUp Project)
3. Presionar F5 para ejecutar en modo debug
4. El navegador se abrirá automáticamente en la página de login

## 👥 Usuarios de Prueba

El script de base de datos crea los siguientes usuarios de prueba:

| Usuario    | Contraseña | Rol            |
|------------|------------|----------------|
| admin      | admin123   | Administrador  |
| recepcion  | recep123   | Recepcionista  |
| juan.perez | juan123    | Recepcionista  |

## ✅ Casos de Uso Implementados

### CASO 1: Inicio de Sesión Exitoso
- El usuario ingresa credenciales correctas
- El sistema valida contra la base de datos
- Se crea una sesión con la información del usuario
- Se registra el último acceso
- Redirige al panel principal

### CASO 2: Credenciales Incorrectas
- El usuario ingresa credenciales inválidas
- El sistema valida y detecta que no coinciden
- NO se permite el acceso al panel principal
- Se limpia el campo de contraseña

### CASO 3: Notificación al Usuario
- Se muestra un mensaje claro indicando el error
- El mensaje aparece en un panel de alerta visual
- El usuario puede intentar nuevamente

## 🔒 Características de Seguridad

1. **Validación de Sesión**: Todas las páginas protegidas verifican la existencia de sesión activa
2. **Limpieza de Campos**: La contraseña se limpia después de intentos fallidos
3. **Mensajes Genéricos**: No se especifica si el error es en usuario o contraseña
4. **Timeout de Sesión**: Las sesiones expiran después de 60 minutos de inactividad
5. **Encriptación de Contraseñas**: Preparado para usar SHA256 (comentado para pruebas)

## 🎨 Características de la Interfaz

- Diseño moderno y responsive
- Gradientes y animaciones suaves
- Compatible con dispositivos móviles
- Validación en tiempo real
- Mensajes de error claros y amigables

## 📊 Base de Datos

### Tablas Principales:
- **Usuarios**: Almacena información de usuarios del sistema
- **Habitaciones**: Catálogo de habitaciones del hotel
- **Clientes**: Información de clientes y huéspedes
- **Reservas**: Registro de reservas de habitaciones
- **Pagos**: Control de pagos de reservas

### Procedimientos Almacenados:
- `sp_HabitacionesDisponibles`: Consulta habitaciones disponibles por fechas
- `sp_EstadisticasDia`: Obtiene estadísticas del día actual

## 🚀 Próximas Funcionalidades

- [ ] Gestión completa de reservas (CRUD)
- [ ] Gestión de habitaciones
- [ ] Gestión de clientes
- [ ] Reportes y estadísticas
- [ ] Sistema de roles y permisos
- [ ] Exportación a PDF/Excel
- [ ] Notificaciones por email
- [ ] Dashboard con gráficos
- [ ] Check-in / Check-out
- [ ] Gestión de pagos

## 🐛 Solución de Problemas Comunes

### Error: "Cannot open database HotelDB"
**Solución**: Verificar que el script de creación de BD se ejecutó correctamente

### Error: "Login failed for user"
**Solución**: Verificar las credenciales en la cadena de conexión del Web.config

### Error: "Could not load file or assembly"
**Solución**: Verificar que todas las referencias entre proyectos estén correctamente configuradas

### La página no carga estilos
**Solución**: Verificar que el proyecto Web esté configurado como proyecto de inicio

## 📝 Notas Importantes

1. **Contraseñas en Texto Plano**: En esta versión de prueba, las contraseñas se almacenan en texto plano. Para producción, descomentar la función de encriptación en `UsuarioNegocio.cs`

2. **Cadena de Conexión**: Asegúrate de modificar la cadena de conexión según tu configuración de SQL Server

3. **Sesiones**: El sistema usa sesiones InProc. Para ambientes distribuidos, considerar usar SQL Server o StateServer

4. **Email**: La funcionalidad de recuperación de contraseña no envía emails reales. Implementar SMTP para producción

## 📞 Soporte y Contacto

Para reportar problemas o sugerencias:
- Crear un issue en el repositorio
- Contactar al equipo de desarrollo

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

---

**Versión**: 1.0.0  
**Fecha**: Enero 2026  
**Desarrollado con**: ASP.NET Web Forms, C#, SQL Server

¡Gracias por usar nuestro Sistema de Reservas de Hotel! 🏨
