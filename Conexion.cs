using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Datos
{
    /// <summary>
    /// Clase para gestionar la conexión a la base de datos
    /// </summary>
    public class Conexion
    {
        // Cadena de conexión desde Web.config
        private string cadenaConexion;

        public Conexion()
        {
            // Obtener la cadena de conexión del archivo de configuración
            cadenaConexion = ConfigurationManager.ConnectionStrings["HotelDB"].ConnectionString;
        }

        /// <summary>
        /// Obtiene una conexión a la base de datos
        /// </summary>
        /// <returns>Objeto SqlConnection</returns>
        public SqlConnection ObtenerConexion()
        {
            SqlConnection conexion = new SqlConnection(cadenaConexion);
            return conexion;
        }

        /// <summary>
        /// Ejecuta una consulta y retorna un DataTable
        /// </summary>
        public DataTable EjecutarConsulta(string query, SqlParameter[] parametros = null)
        {
            DataTable dt = new DataTable();
            
            try
            {
                using (SqlConnection conexion = ObtenerConexion())
                {
                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        // Agregar parámetros si existen
                        if (parametros != null)
                        {
                            cmd.Parameters.AddRange(parametros);
                        }

                        conexion.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al ejecutar consulta: " + ex.Message);
            }

            return dt;
        }

        /// <summary>
        /// Ejecuta un comando que no retorna datos (INSERT, UPDATE, DELETE)
        /// </summary>
        public int EjecutarComando(string query, SqlParameter[] parametros = null)
        {
            int filasAfectadas = 0;

            try
            {
                using (SqlConnection conexion = ObtenerConexion())
                {
                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        // Agregar parámetros si existen
                        if (parametros != null)
                        {
                            cmd.Parameters.AddRange(parametros);
                        }

                        conexion.Open();
                        filasAfectadas = cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al ejecutar comando: " + ex.Message);
            }

            return filasAfectadas;
        }

        /// <summary>
        /// Ejecuta una consulta que retorna un único valor
        /// </summary>
        public object EjecutarEscalar(string query, SqlParameter[] parametros = null)
        {
            object resultado = null;

            try
            {
                using (SqlConnection conexion = ObtenerConexion())
                {
                    using (SqlCommand cmd = new SqlCommand(query, conexion))
                    {
                        // Agregar parámetros si existen
                        if (parametros != null)
                        {
                            cmd.Parameters.AddRange(parametros);
                        }

                        conexion.Open();
                        resultado = cmd.ExecuteScalar();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al ejecutar escalar: " + ex.Message);
            }

            return resultado;
        }

        /// <summary>
        /// Ejecuta un procedimiento almacenado
        /// </summary>
        public DataTable EjecutarProcedimiento(string nombreProcedimiento, SqlParameter[] parametros = null)
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conexion = ObtenerConexion())
                {
                    using (SqlCommand cmd = new SqlCommand(nombreProcedimiento, conexion))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Agregar parámetros si existen
                        if (parametros != null)
                        {
                            cmd.Parameters.AddRange(parametros);
                        }

                        conexion.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al ejecutar procedimiento: " + ex.Message);
            }

            return dt;
        }
    }
}
