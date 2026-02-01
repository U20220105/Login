using System;
using System.Security.Cryptography;
using System.Text;
using Datos;
using Entidades;

namespace Negocio
{
    /// <summary>
    /// Clase de lógica de negocio para la entidad Usuario
    /// </summary>
    public class UsuarioNegocio
    {
        private UsuarioDatos usuarioDatos;

        public UsuarioNegocio()
        {
            usuarioDatos = new UsuarioDatos();
        }

        /// <summary>
        /// Valida las credenciales de un usuario
        /// </summary>
        /// <param name="nombreUsuario">Nombre de usuario</param>
        /// <param name="password">Contraseña en texto plano</param>
        /// <returns>Objeto Usuario si las credenciales son válidas, null en caso contrario</returns>
        public Usuario ValidarCredenciales(string nombreUsuario, string password)
        {
            try
            {
                // Validaciones de negocio
                if (string.IsNullOrWhiteSpace(nombreUsuario))
                {
                    throw new Exception("El nombre de usuario no puede estar vacío");
                }

                if (string.IsNullOrWhiteSpace(password))
                {
                    throw new Exception("La contraseña no puede estar vacía");
                }

                // Encriptar la contraseña antes de validar
                // NOTA: En este ejemplo usamos la contraseña en texto plano
                // En producción, deberías usar EncriptarPassword(password)
                string passwordEncriptado = password; // Cambiar a: EncriptarPassword(password);

                // Llamar a la capa de datos para validar
                Usuario usuario = usuarioDatos.ValidarUsuario(nombreUsuario, passwordEncriptado);

                // Validar que el usuario esté activo
                if (usuario != null && !usuario.Activo)
                {
                    throw new Exception("El usuario está inactivo. Contacte al administrador.");
                }

                return usuario;
            }
            catch (Exception ex)
            {
                throw new Exception("Error en la validación de credenciales: " + ex.Message);
            }
        }

        /// <summary>
        /// Actualiza la fecha del último acceso del usuario
        /// </summary>
        public bool ActualizarUltimoAcceso(int usuarioId)
        {
            try
            {
                if (usuarioId <= 0)
                {
                    throw new Exception("ID de usuario inválido");
                }

                return usuarioDatos.ActualizarUltimoAcceso(usuarioId);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar último acceso: " + ex.Message);
            }
        }

        /// <summary>
        /// Obtiene un usuario por su nombre de usuario
        /// </summary>
        public Usuario ObtenerPorNombreUsuario(string nombreUsuario)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(nombreUsuario))
                {
                    throw new Exception("El nombre de usuario no puede estar vacío");
                }

                return usuarioDatos.ObtenerPorNombreUsuario(nombreUsuario);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener usuario: " + ex.Message);
            }
        }

        /// <summary>
        /// Registra un nuevo usuario
        /// </summary>
        public int RegistrarUsuario(Usuario usuario)
        {
            try
            {
                // Validaciones de negocio
                ValidarDatosUsuario(usuario);

                // Verificar que el nombre de usuario no exista
                Usuario usuarioExistente = usuarioDatos.ObtenerPorNombreUsuario(usuario.NombreUsuario);
                if (usuarioExistente != null)
                {
                    throw new Exception("El nombre de usuario ya existe");
                }

                // Encriptar la contraseña
                usuario.Password = EncriptarPassword(usuario.Password);

                // Insertar el usuario
                return usuarioDatos.InsertarUsuario(usuario);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al registrar usuario: " + ex.Message);
            }
        }

        /// <summary>
        /// Valida los datos de un usuario
        /// </summary>
        private void ValidarDatosUsuario(Usuario usuario)
        {
            if (string.IsNullOrWhiteSpace(usuario.NombreUsuario))
            {
                throw new Exception("El nombre de usuario es requerido");
            }

            if (usuario.NombreUsuario.Length < 4)
            {
                throw new Exception("El nombre de usuario debe tener al menos 4 caracteres");
            }

            if (string.IsNullOrWhiteSpace(usuario.Password))
            {
                throw new Exception("La contraseña es requerida");
            }

            if (usuario.Password.Length < 6)
            {
                throw new Exception("La contraseña debe tener al menos 6 caracteres");
            }

            if (string.IsNullOrWhiteSpace(usuario.NombreCompleto))
            {
                throw new Exception("El nombre completo es requerido");
            }

            if (string.IsNullOrWhiteSpace(usuario.Email))
            {
                throw new Exception("El email es requerido");
            }

            if (!ValidarEmail(usuario.Email))
            {
                throw new Exception("El formato del email no es válido");
            }
        }

        /// <summary>
        /// Valida el formato de un email
        /// </summary>
        private bool ValidarEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Encripta una contraseña usando SHA256
        /// NOTA: En producción, usar algoritmos más seguros como bcrypt o PBKDF2
        /// </summary>
        private string EncriptarPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}
