using System;
using System.Web.UI;

namespace Presentacion
{
    public partial class Principal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verificar que el usuario esté autenticado
                if (Session["UsuarioId"] == null)
                {
                    // Si no hay sesión activa, redirigir al login
                    Response.Redirect("Index.aspx", false);
                    return;
                }

                // Cargar información del usuario
                CargarInformacionUsuario();
            }
        }

        private void CargarInformacionUsuario()
        {
            try
            {
                // Obtener datos de la sesión
                string nombreCompleto = Session["NombreCompleto"]?.ToString() ?? "Usuario";
                string nombreUsuario = Session["NombreUsuario"]?.ToString() ?? "";
                string rol = Session["Rol"]?.ToString() ?? "";

                // Mostrar nombre de usuario en la barra superior
                lblNombreUsuario.Text = nombreUsuario;

                // Mensaje de bienvenida personalizado
                lblBienvenida.Text = $"¡Bienvenido/a, {nombreCompleto}!";

                // Opcional: Mostrar información adicional según el rol
                if (rol.ToLower() == "administrador")
                {
                    // El administrador tiene acceso a todas las funciones
                }
                else if (rol.ToLower() == "recepcionista")
                {
                    // Recepcionista tiene acceso limitado
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al cargar información: {ex.Message}");
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            try
            {
                // Limpiar todas las variables de sesión
                Session.Clear();
                Session.Abandon();

                // Redirigir al login
                Response.Redirect("Index.aspx", false);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error al cerrar sesión: {ex.Message}");
            }
        }
    }
}
