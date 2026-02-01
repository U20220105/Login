using System;
using System.Web.UI;
using Negocio;
using Entidades;

namespace Presentacion
{
    public partial class Index : System.Web.UI.Page
    {
        // Instancia de la capa de negocio
        private UsuarioNegocio usuarioNegocio = new UsuarioNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Limpiar cualquier sesión existente al cargar la página
                Session.Clear();
                
                // Establecer el foco en el campo de usuario
                txtUsuario.Focus();
            }
        }

        protected void btnIniciarSesion_Click(object sender, EventArgs e)
        {
            try
            {
                // Validar que los campos no estén vacíos
                if (string.IsNullOrWhiteSpace(txtUsuario.Text) || 
                    string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    MostrarMensaje("Por favor, complete todos los campos.", false);
                    return;
                }

                // Obtener los valores ingresados
                string usuario = txtUsuario.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Validar las credenciales a través de la capa de negocio
                Usuario usuarioValidado = usuarioNegocio.ValidarCredenciales(usuario, password);

                if (usuarioValidado != null)
                {
                    // CASO 1: Credenciales correctas - Iniciar sesión exitosa
                    
                    // Guardar información del usuario en la sesión
                    Session["UsuarioId"] = usuarioValidado.UsuarioId;
                    Session["NombreUsuario"] = usuarioValidado.NombreUsuario;
                    Session["NombreCompleto"] = usuarioValidado.NombreCompleto;
                    Session["Rol"] = usuarioValidado.Rol;
                    Session["FechaLogin"] = DateTime.Now;

                    // Registrar el último acceso
                    usuarioNegocio.ActualizarUltimoAcceso(usuarioValidado.UsuarioId);

                    // Redirigir al panel principal
                    Response.Redirect("Principal.aspx", false);
                }
                else
                {
                    // CASO 2 y 3: Credenciales incorrectas - Mostrar notificación
                    MostrarMensaje("Usuario o contraseña incorrectos. Por favor, verifique sus credenciales.", false);
                    
                    // Limpiar el campo de contraseña por seguridad
                    txtPassword.Text = string.Empty;
                    txtPassword.Focus();
                }
            }
            catch (Exception ex)
            {
                // Manejo de errores
                MostrarMensaje("Error al iniciar sesión: " + ex.Message, false);
                
                // Registrar el error (en un entorno de producción, usar un sistema de logs)
                System.Diagnostics.Debug.WriteLine($"Error en Login: {ex.Message}");
            }
        }

        protected void lnkOlvidePassword_Click(object sender, EventArgs e)
        {
            // Redirigir a la página de recuperación de contraseña
            Response.Redirect("RecuperarPassword.aspx", false);
        }

        /// <summary>
        /// Método para mostrar mensajes al usuario
        /// </summary>
        /// <param name="mensaje">Texto del mensaje</param>
        /// <param name="esExito">Indica si es un mensaje de éxito o error</param>
        private void MostrarMensaje(string mensaje, bool esExito)
        {
            lblMensaje.Text = mensaje;
            pnlMensaje.Visible = true;
            
            // Cambiar el estilo según el tipo de mensaje
            if (esExito)
            {
                pnlMensaje.CssClass = "alert alert-success";
            }
            else
            {
                pnlMensaje.CssClass = "alert alert-danger";
            }
        }
    }
}
