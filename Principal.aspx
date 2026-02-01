<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="Presentacion.Principal" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Panel Principal - Sistema de Reservas</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
        }

        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h1 {
            font-size: 24px;
            font-weight: 600;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-info span {
            font-size: 14px;
        }

        .btn-logout {
            background: rgba(255,255,255,0.2);
            color: white;
            border: 1px solid rgba(255,255,255,0.3);
            padding: 8px 20px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 14px;
        }

        .btn-logout:hover {
            background: rgba(255,255,255,0.3);
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .welcome-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .welcome-card h2 {
            color: #333;
            margin-bottom: 10px;
        }

        .welcome-card p {
            color: #666;
            font-size: 16px;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .menu-item {
            background: white;
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.3);
        }

        .menu-item .icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .menu-item h3 {
            color: #333;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .menu-item p {
            color: #666;
            font-size: 14px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .stat-card .number {
            font-size: 36px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }

        .stat-card .label {
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Barra de navegación -->
        <div class="navbar">
            <h1>🏨 Sistema de Reservas de Hotel</h1>
            <div class="user-info">
                <span>👤 <asp:Label ID="lblNombreUsuario" runat="server"></asp:Label></span>
                <asp:LinkButton ID="btnCerrarSesion" runat="server" CssClass="btn-logout" OnClick="btnCerrarSesion_Click">
                    Cerrar Sesión
                </asp:LinkButton>
            </div>
        </div>

        <!-- Contenedor principal -->
        <div class="container">
            <!-- Tarjeta de bienvenida -->
            <div class="welcome-card">
                <h2><asp:Label ID="lblBienvenida" runat="server"></asp:Label></h2>
                <p>Gestione las reservas de habitaciones de manera eficiente</p>
            </div>

            <!-- Estadísticas rápidas -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="number">24</div>
                    <div class="label">Habitaciones Totales</div>
                </div>
                <div class="stat-card">
                    <div class="number">18</div>
                    <div class="label">Disponibles</div>
                </div>
                <div class="stat-card">
                    <div class="number">12</div>
                    <div class="label">Reservas Activas</div>
                </div>
                <div class="stat-card">
                    <div class="number">6</div>
                    <div class="label">Check-ins Hoy</div>
                </div>
            </div>

            <!-- Menú de opciones -->
            <div class="menu-grid">
                <a href="Reservas.aspx" class="menu-item">
                    <div class="icon">📅</div>
                    <h3>Gestión de Reservas</h3>
                    <p>Crear, modificar y consultar reservas de habitaciones</p>
                </a>

                <a href="Habitaciones.aspx" class="menu-item">
                    <div class="icon">🛏️</div>
                    <h3>Habitaciones</h3>
                    <p>Administrar habitaciones y su disponibilidad</p>
                </a>

                <a href="Clientes.aspx" class="menu-item">
                    <div class="icon">👥</div>
                    <h3>Clientes</h3>
                    <p>Gestionar información de clientes y huéspedes</p>
                </a>

                <a href="Reportes.aspx" class="menu-item">
                    <div class="icon">📊</div>
                    <h3>Reportes</h3>
                    <p>Visualizar estadísticas y generar reportes</p>
                </a>

                <a href="Configuracion.aspx" class="menu-item">
                    <div class="icon">⚙️</div>
                    <h3>Configuración</h3>
                    <p>Ajustes del sistema y preferencias</p>
                </a>

                <a href="Usuarios.aspx" class="menu-item">
                    <div class="icon">🔐</div>
                    <h3>Usuarios</h3>
                    <p>Administrar usuarios del sistema</p>
                </a>
            </div>
        </div>
    </form>
</body>
</html>
