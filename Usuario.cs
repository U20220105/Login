using System;

namespace Entidades
{
    /// <summary>
    /// Clase que representa la entidad Usuario del sistema
    /// </summary>
    public class Usuario
    {
        // Propiedades de la entidad
        public int UsuarioId { get; set; }
        public string NombreUsuario { get; set; }
        public string Password { get; set; }
        public string NombreCompleto { get; set; }
        public string Email { get; set; }
        public string Rol { get; set; }
        public bool Activo { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime? UltimoAcceso { get; set; }

        // Constructor vacío
        public Usuario()
        {
            Activo = true;
            FechaCreacion = DateTime.Now;
        }

        // Constructor con parámetros
        public Usuario(string nombreUsuario, string password, string nombreCompleto, string email, string rol)
        {
            NombreUsuario = nombreUsuario;
            Password = password;
            NombreCompleto = nombreCompleto;
            Email = email;
            Rol = rol;
            Activo = true;
            FechaCreacion = DateTime.Now;
        }
    }
}
