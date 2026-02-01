<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Presentacion.Index" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Sistema de Reservas - Hotel</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }

        .login-header h1 {
            font-size: 28px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .login-header p {
            font-size: 14px;
            opacity: 0.9;
        }

        .login-body {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .forgot-password {
            text-align: center;
            margin-top: 20px;
        }

        .forgot-password a {
            color: #667eea;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .forgot-password a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-danger {
            background-color: #fee;
            border: 1px solid #fcc;
            color: #c33;
        }

        .alert-success {
            background-color: #efe;
            border: 1px solid #cfc;
            color: #3c3;
        }

        .input-icon {
            position: relative;
        }

        .input-icon::before {
            content: '';
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            width: 18px;
            height: 18px;
            opacity: 0.5;
        }

        @media (max-width: 480px) {
            .login-container {
                border-radius: 0;
            }
            
            .login-header {
                padding: 30px 20px;
            }
            
            .login-body {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <div class="login-header">
                <h1>🏨 Sistema de Reservas</h1>
                <p>Gestión de Habitaciones de Hotel</p>
            </div>
            
            <div class="login-body">
                <!-- Mensaje de notificación -->
                <asp:Panel ID="pnlMensaje" runat="server" Visible="false">
                    <div class="alert alert-danger">
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                    </div>
                </asp:Panel>

                <!-- Campo Usuario -->
                <div class="form-group">
                    <label for="txtUsuario">Usuario</label>
                    <asp:TextBox 
                        ID="txtUsuario" 
                        runat="server" 
                        CssClass="form-control" 
                        placeholder="Ingrese su usuario"
                        MaxLength="50">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator 
                        ID="rfvUsuario" 
                        runat="server" 
                        ControlToValidate="txtUsuario"
                        ErrorMessage="El usuario es requerido" 
                        ForeColor="Red"
                        Display="Dynamic"
                        Font-Size="12px">
                    </asp:RequiredFieldValidator>
                </div>

                <!-- Campo Contraseña -->
                <div class="form-group">
                    <label for="txtPassword">Contraseña</label>
                    <asp:TextBox 
                        ID="txtPassword" 
                        runat="server" 
                        TextMode="Password" 
                        CssClass="form-control" 
                        placeholder="Ingrese su contraseña"
                        MaxLength="100">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator 
                        ID="rfvPassword" 
                        runat="server" 
                        ControlToValidate="txtPassword"
                        ErrorMessage="La contraseña es requerida" 
                        ForeColor="Red"
                        Display="Dynamic"
                        Font-Size="12px">
                    </asp:RequiredFieldValidator>
                </div>

                <!-- Botón Iniciar Sesión -->
                <div class="form-group">
                    <asp:Button 
                        ID="btnIniciarSesion" 
                        runat="server" 
                        Text="Iniciar Sesión" 
                        CssClass="btn btn-primary"
                        OnClick="btnIniciarSesion_Click" />
                </div>

                <!-- Enlace Olvidé Contraseña -->
                <div class="forgot-password">
                    <asp:LinkButton 
                        ID="lnkOlvidePassword" 
                        runat="server" 
                        CausesValidation="false"
                        OnClick="lnkOlvidePassword_Click">
                        ¿Olvidó su contraseña?
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
