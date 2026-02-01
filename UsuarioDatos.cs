using System;
using System.Data;
using System.Data.SqlClient;
using Entidades;

namespace Datos
{
    /// <summary>
    /// Clase de acceso a datos para la entidad Usuario
    /// </summary>
    public class UsuarioDatos
    {
        private Conexion conexion;

        public UsuarioDatos()
        {
            conexion = new Conexion();
        }

        /// <summary>
        /// Valida las credenciales de un usuario
        /// </summary>
        public Usuario ValidarUsuario(string nombreUsuario, string password)
        {
            Usuario usuario = null;

            try
            {
                string query = @"SELECT UsuarioId, NombreUsuario, NombreCompleto, Email, Rol, 
                                Activo, FechaCreacion, UltimoAcceso 
                                FROM Usuarios 
                                WHERE NombreUsuario = @NombreUsuario 
                                AND Password = @Password 
                                AND Activo = 1";

                SqlParameter[] parametros = new SqlParameter[]
                {
                    new SqlParameter("@NombreUsuario", nombreUsuario),
                    new SqlParameter("@Password", password) // En producción, usar hash
                };

                DataTable dt = conexion.EjecutarConsulta(query, parametros);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    usuario = new Usuario
                    {
                        UsuarioId = Convert.ToInt32(row["UsuarioId"]),
                        NombreUsuario = row["NombreUsuario"].ToString(),
                        NombreCompleto = row["NombreCompleto"].ToString(),
                        Email = row["Email"].ToString(),
                        Rol = row["Rol"].ToString(),
                        Activo = Convert.ToBoolean(row["Activo"]),
                        FechaCreacion = Convert.ToDateTime(row["FechaCreacion"]),
                        UltimoAcceso = row["UltimoAcceso"] != DBNull.Value 
                            ? Convert.ToDateTime(row["UltimoAcceso"]) 
                            : (DateTime?)null
                    };
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al validar usuario: " + ex.Message);
            }

            return usuario;
        }

        /// <summary>
        /// Actualiza la fecha del último acceso del usuario
        /// </summary>
        public bool ActualizarUltimoAcceso(int usuarioId)
        {
            try
            {
                string query = @"UPDATE Usuarios 
                                SET UltimoAcceso = @FechaAcceso 
                                WHERE UsuarioId = @UsuarioId";

                SqlParameter[] parametros = new SqlParameter[]
                {
                    new SqlParameter("@UsuarioId", usuarioId),
                    new SqlParameter("@FechaAcceso", DateTime.Now)
                };

                int filasAfectadas = conexion.EjecutarComando(query, parametros);
                return filasAfectadas > 0;
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
            Usuario usuario = null;

            try
            {
                string query = @"SELECT UsuarioId, NombreUsuario, NombreCompleto, Email, Rol, 
                                Activo, FechaCreacion, UltimoAcceso 
                                FROM Usuarios 
                                WHERE NombreUsuario = @NombreUsuario";

                SqlParameter[] parametros = new SqlParameter[]
                {
                    new SqlParameter("@NombreUsuario", nombreUsuario)
                };

                DataTable dt = conexion.EjecutarConsulta(query, parametros);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    usuario = new Usuario
                    {
                        UsuarioId = Convert.ToInt32(row["UsuarioId"]),
                        NombreUsuario = row["NombreUsuario"].ToString(),
                        NombreCompleto = row["NombreCompleto"].ToString(),
                        Email = row["Email"].ToString(),
                        Rol = row["Rol"].ToString(),
                        Activo = Convert.ToBoolean(row["Activo"])
                    };
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener usuario: " + ex.Message);
            }

            return usuario;
        }

        /// <summary>
        /// Inserta un nuevo usuario
        /// </summary>
        public int InsertarUsuario(Usuario usuario)
        {
            try
            {
                string query = @"INSERT INTO Usuarios (NombreUsuario, Password, NombreCompleto, 
                                Email, Rol, Activo, FechaCreacion) 
                                VALUES (@NombreUsuario, @Password, @NombreCompleto, 
                                @Email, @Rol, @Activo, @FechaCreacion);
                                SELECT CAST(SCOPE_IDENTITY() as int)";

                SqlParameter[] parametros = new SqlParameter[]
                {
                    new SqlParameter("@NombreUsuario", usuario.NombreUsuario),
                    new SqlParameter("@Password", usuario.Password),
                    new SqlParameter("@NombreCompleto", usuario.NombreCompleto),
                    new SqlParameter("@Email", usuario.Email),
                    new SqlParameter("@Rol", usuario.Rol),
                    new SqlParameter("@Activo", usuario.Activo),
                    new SqlParameter("@FechaCreacion", usuario.FechaCreacion)
                };

                object resultado = conexion.EjecutarEscalar(query, parametros);
                return Convert.ToInt32(resultado);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al insertar usuario: " + ex.Message);
            }
        }
    }
}
