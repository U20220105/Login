using System;

namespace Entidades
{
    /// <summary>
    /// Clase que representa la entidad Habitación del sistema
    /// </summary>
    public class Habitacion
    {
        public int HabitacionId { get; set; }
        public string Numero { get; set; }
        public string Tipo { get; set; } // Simple, Doble, Suite, Premium
        public int Capacidad { get; set; }
        public decimal PrecioPorNoche { get; set; }
        public string Estado { get; set; } // Disponible, Ocupada, Mantenimiento, Reservada
        public string Descripcion { get; set; }
        public bool Activa { get; set; }

        // Constructor vacío
        public Habitacion()
        {
            Activa = true;
            Estado = "Disponible";
        }
    }
}
