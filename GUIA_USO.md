# Guía Rápida de Uso - Sistema de Reservas de Hotel

## 🚀 Inicio Rápido

### 1. Acceder al Sistema

1. Abrir el navegador web
2. Navegar a: `http://localhost:[PUERTO]/Index.aspx`
3. Se mostrará la pantalla de inicio de sesión

### 2. Iniciar Sesión

**Usuarios de Prueba:**
```
Usuario: admin
Contraseña: admin123
Rol: Administrador

Usuario: recepcion
Contraseña: recep123
Rol: Recepcionista
```

**Pasos:**
1. Ingresar el nombre de usuario
2. Ingresar la contraseña
3. Hacer clic en "Iniciar Sesión"

### 3. Panel Principal

Después de iniciar sesión exitosamente, verás:
- Barra superior con tu nombre de usuario
- Mensaje de bienvenida personalizado
- Estadísticas rápidas (habitaciones, reservas)
- Menú de opciones principales

## 📋 Funcionalidades Principales

### ✅ CASOS DE USO IMPLEMENTADOS

#### CASO 1: Inicio de Sesión Exitoso

**Flujo:**
```
1. Usuario ingresa credenciales correctas
   ├─ Usuario: "admin"
   └─ Contraseña: "admin123"
   
2. Sistema valida en base de datos
   ├─ Verifica que el usuario existe
   ├─ Verifica que la contraseña coincide
   └─ Verifica que el usuario está activo

3. Sistema crea sesión
   ├─ Guarda ID del usuario
   ├─ Guarda nombre completo
   ├─ Guarda rol
   └─ Registra fecha/hora de acceso

4. Sistema actualiza último acceso en BD

5. Redirección a Principal.aspx
   └─ Usuario tiene acceso completo al sistema
```

**Resultado Esperado:**
- ✓ Redirección exitosa al panel principal
- ✓ Mensaje de bienvenida personalizado
- ✓ Sesión activa
- ✓ Acceso a todas las funcionalidades

#### CASO 2: Credenciales Incorrectas

**Flujo:**
```
1. Usuario ingresa credenciales incorrectas
   ├─ Usuario: "usuario123" (no existe)
   └─ Contraseña: "password" (incorrecta)
   
2. Sistema valida en base de datos
   ├─ No encuentra coincidencia
   └─ Retorna NULL

3. Sistema NO crea sesión

4. Sistema NO permite acceso a Principal.aspx

5. Usuario permanece en Index.aspx
```

**Resultado Esperado:**
- ✓ Usuario permanece en página de login
- ✓ No se crea sesión
- ✓ No hay acceso al panel principal
- ✓ Campo de contraseña se limpia automáticamente

#### CASO 3: Notificación de Error

**Flujo:**
```
1. Usuario ingresa credenciales incorrectas

2. Sistema detecta error de validación

3. Sistema muestra notificación
   ├─ Panel de alerta visible
   ├─ Mensaje: "Usuario o contraseña incorrectos"
   ├─ Color rojo (alert-danger)
   └─ Icono de error

4. Usuario puede leer el mensaje claramente

5. Usuario puede intentar nuevamente
```

**Resultado Esperado:**
- ✓ Mensaje de error visible y claro
- ✓ Estilo visual llamativo (rojo)
- ✓ Texto descriptivo del problema
- ✓ Usuario sabe qué hacer a continuación

## 🔐 Seguridad

### Protección de Páginas

Todas las páginas después del login verifican la sesión:

```csharp
// En Principal.aspx.cs
if (Session["UsuarioId"] == null)
{
    Response.Redirect("Index.aspx", false);
    return;
}
```

**Esto significa:**
- No puedes acceder a Principal.aspx sin login
- Si intentas acceder directamente, te redirige al login
- La sesión expira después de 60 minutos de inactividad

### Validaciones Implementadas

1. **Campos Requeridos:**
   - Usuario no puede estar vacío
   - Contraseña no puede estar vacía

2. **Validación en Base de Datos:**
   - Usuario debe existir
   - Contraseña debe coincidir
   - Usuario debe estar activo

3. **Limpieza de Datos:**
   - Se eliminan espacios en blanco (Trim)
   - Se limpia el campo de contraseña después de error

## 🎯 Casos de Uso Detallados

### Escenario 1: Login Exitoso del Administrador

```
DADO que soy un usuario administrador registrado
CUANDO ingreso usuario "admin" y contraseña "admin123"
Y hago clic en "Iniciar Sesión"
ENTONCES debería ver el panel principal
Y debería ver un mensaje "¡Bienvenido/a, Administrador del Sistema!"
Y mi nombre de usuario "admin" debería aparecer en la barra superior
```

### Escenario 2: Login con Contraseña Incorrecta

```
DADO que soy un usuario registrado
CUANDO ingreso usuario "admin" (correcto)
Y ingreso contraseña "incorrecta123" (incorrecta)
Y hago clic en "Iniciar Sesión"
ENTONCES debería permanecer en la página de login
Y debería ver un mensaje "Usuario o contraseña incorrectos"
Y el campo de contraseña debería estar vacío
```

### Escenario 3: Login con Usuario Inexistente

```
DADO que no soy un usuario registrado
CUANDO ingreso usuario "usuarioNoExiste"
Y ingreso cualquier contraseña
Y hago clic en "Iniciar Sesión"
ENTONCES debería permanecer en la página de login
Y debería ver un mensaje "Usuario o contraseña incorrectos"
Y NO debería tener acceso al sistema
```

### Escenario 4: Intento de Acceso sin Login

```
DADO que no he iniciado sesión
CUANDO intento acceder directamente a "Principal.aspx"
ENTONCES debería ser redirigido automáticamente a "Index.aspx"
Y NO debería poder ver el panel principal
```

### Escenario 5: Recuperación de Contraseña

```
DADO que olvidé mi contraseña
CUANDO hago clic en "¿Olvidó su contraseña?"
ENTONCES debería ver la página de recuperación
CUANDO ingreso mi nombre de usuario o email
Y hago clic en "Recuperar Contraseña"
ENTONCES debería ver un mensaje de confirmación
(NOTA: En producción, recibiría un email con instrucciones)
```

## 📊 Validaciones y Mensajes

### Mensajes de Error

| Situación | Mensaje | Color |
|-----------|---------|-------|
| Credenciales incorrectas | "Usuario o contraseña incorrectos. Por favor, verifique sus credenciales." | Rojo |
| Campos vacíos | "Por favor, complete todos los campos." | Rojo |
| Error del sistema | "Error al iniciar sesión: [detalle]" | Rojo |
| Usuario inactivo | "El usuario está inactivo. Contacte al administrador." | Rojo |

### Mensajes de Éxito

| Situación | Mensaje | Color |
|-----------|---------|-------|
| Recuperación enviada | "Se han enviado las instrucciones de recuperación a su correo electrónico registrado." | Verde |

## 🔄 Ciclo de Vida de una Sesión

```
1. Usuario Ingresa Credenciales
   ↓
2. Sistema Valida
   ├─ ✓ Válido → Continúa
   └─ ✗ Inválido → Muestra error y termina
   ↓
3. Crea Sesión
   Session["UsuarioId"] = usuario.UsuarioId
   Session["NombreUsuario"] = usuario.NombreUsuario
   Session["NombreCompleto"] = usuario.NombreCompleto
   Session["Rol"] = usuario.Rol
   ↓
4. Usuario Navega por el Sistema
   - Cada página verifica Session["UsuarioId"]
   - Sesión activa por 60 minutos
   ↓
5. Usuario Cierra Sesión
   - Clic en "Cerrar Sesión"
   - Session.Clear() + Session.Abandon()
   - Redirección a Index.aspx
   ↓
6. Sesión Terminada
```

## 🛠️ Pruebas Recomendadas

### Checklist de Pruebas

- [ ] Login con credenciales correctas funciona
- [ ] Login con credenciales incorrectas muestra error
- [ ] Login con usuario vacío muestra validación
- [ ] Login con contraseña vacía muestra validación
- [ ] Acceso directo a Principal.aspx sin login redirige a Index
- [ ] Cerrar sesión funciona correctamente
- [ ] Mensaje de error se muestra correctamente
- [ ] Campo de contraseña se limpia después de error
- [ ] Link "Olvidé contraseña" funciona
- [ ] Sesión expira después de inactividad

### Datos de Prueba

**Usuarios Válidos:**
```
admin / admin123
recepcion / recep123
juan.perez / juan123
```

**Usuarios Inválidos (para probar errores):**
```
noexiste / cualquierpassword
admin / passwordincorrecta
usuario123 / pass123
```

## 📱 Responsive Design

El sistema funciona en:
- 💻 Computadoras de escritorio
- 📱 Tablets
- 📱 Smartphones

**Características Responsive:**
- Formularios se adaptan al tamaño de pantalla
- Botones táctiles optimizados
- Texto legible en todos los dispositivos
- Diseño vertical en móviles

## 🎨 Elementos Visuales

### Página de Login

- **Header**: Gradiente morado con icono de hotel 🏨
- **Formulario**: Fondo blanco, bordes redondeados
- **Inputs**: Bordes suaves, focus en color morado
- **Botón**: Gradiente morado, efecto hover
- **Alertas**: Rojo para errores, verde para éxito

### Panel Principal

- **Navbar**: Gradiente morado con nombre de usuario
- **Estadísticas**: Cards blancos con números grandes
- **Menú**: Grid de cards con iconos emoji
- **Hover**: Elevación y sombra en cards

## 💡 Consejos de Uso

1. **Mantén tu sesión activa**: El sistema cierra sesión después de 60 minutos de inactividad

2. **Usa credenciales fuertes**: En producción, cambia las contraseñas predeterminadas

3. **Cierra sesión**: Siempre usa el botón "Cerrar Sesión" en lugar de cerrar el navegador

4. **Verifica los mensajes**: Lee los mensajes de error para saber qué corregir

5. **Navegadores actualizados**: Usa las versiones más recientes para mejor experiencia

## ❓ Preguntas Frecuentes

**P: ¿Qué hago si olvidé mi contraseña?**
R: Usa el link "¿Olvidó su contraseña?" en la página de login

**P: ¿Por qué no puedo acceder aunque ingreso las credenciales correctas?**
R: Verifica que el usuario esté activo en la base de datos

**P: ¿Cuánto tiempo dura mi sesión?**
R: 60 minutos de inactividad. Si navegas activamente, se renueva automáticamente

**P: ¿Puedo tener múltiples sesiones abiertas?**
R: Sí, puedes abrir el sistema en múltiples pestañas o navegadores

---

**Última actualización**: Enero 2026
**Versión**: 1.0.0
