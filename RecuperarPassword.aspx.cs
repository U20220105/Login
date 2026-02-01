using System;
using System.Web.UI;
using Negocio;
using Entidades;

namespace Presentacion
{
    public partial class RecuperarPassword : System.Web.UI.Page
    {
        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUsuarioEmail.Focus();
            }
        }

        protected void btnRecuperar_Click(object sender, EventArgs e)
        {
            try
            {
                string usuarioEmail = txtUsuarioEmail.Text.Trim();

                if (string.IsNullOrWhiteSpace(usuarioEmail))
                {
                    MostrarMensaje("Por favor, ingrese su usuario o email.", "info");
                    return;
                }

                // Buscar el usuario por nombre de usuario
                Usuario usuario = usuarioNegocio.ObtenerPorNombreUsuario(usuarioEmail);

                if (usuario != null)
                {
                    // En una implementación real, aquí se enviaría un email con un token
                    // para restablecer la contraseña
                    
                    // Por ahora, solo mostramos un mensaje de éxito
                    MostrarMensaje(
                        "Se han enviado las instrucciones de recuperación a su correo electrónico registrado. " +
                        "Por favor, revise su bandeja de entrada y spam.", 
                        "success"
                    );

                    // NOTA PARA IMPLEMENTACIÓN REAL:
                    // 1. Generar un token único de recuperación
                    // 2. Guardar el token en la base de datos con fecha de expiración
                    // 3. Enviar email con link que contenga el token
                    // 4. Crear página para cambiar contraseña usando el token
                    
                    // Ejemplo de código para generar token:
                    // string token = Guid.NewGuid().ToString();
                    // DateTime expiracion = DateTime.Now.AddHours(24);
                    // guardarTokenRecuperacion(usuario.UsuarioId, token, expiracion);
                    // enviarEmailRecuperacion(usuario.Email, token);

                    // Limpiar el campo
                    txtUsuarioEmail.Text = string.Empty;
                }
                else
                {
                    // Por seguridad, mostrar el mismo mensaje aunque el usuario no exista
                    // Esto previene que se pueda verificar qué usuarios existen en el sistema
                    MostrarMensaje(
                        "Si el usuario existe, se han enviado las instrucciones de recuperación " +
                        "a su correo electrónico registrado.", 
                        "info"
                    );
                    
                    txtUsuarioEmail.Text = string.Empty;
                }
            }
            catch (Exception ex)
            {
                MostrarMensaje("Error al procesar la solicitud: " + ex.Message, "info");
                System.Diagnostics.Debug.WriteLine($"Error en recuperación: {ex.Message}");
            }
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("Index.aspx", false);
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            lblMensaje.Text = mensaje;
            pnlMensaje.Visible = true;
            
            if (tipo == "success")
            {
                pnlMensaje.CssClass = "alert alert-success";
            }
            else
            {
                pnlMensaje.CssClass = "alert alert-info";
            }
        }
    }
}
