using System;

namespace Entidades
{
    /// <summary>
    /// Clase que representa la entidad Reserva del sistema
    /// </summary>
    public class Reserva
    {
        public int ReservaId { get; set; }
        public int HabitacionId { get; set; }
        public int ClienteId { get; set; }
        public DateTime FechaEntrada { get; set; }
        public DateTime FechaSalida { get; set; }
        public int NumeroHuespedes { get; set; }
        public decimal PrecioTotal { get; set; }
        public string Estado { get; set; } // Pendiente, Confirmada, Cancelada, Completada
        public string Observaciones { get; set; }
        public DateTime FechaReserva { get; set; }
        public int UsuarioRegistro { get; set; }

        // Propiedades adicionales para consultas (no están en la BD)
        public string NumeroHabitacion { get; set; }
        public string TipoHabitacion { get; set; }
        public string NombreCliente { get; set; }

        // Constructor vacío
        public Reserva()
        {
            FechaReserva = DateTime.Now;
            Estado = "Pendiente";
            NumeroHuespedes = 1;
        }
    }
}
