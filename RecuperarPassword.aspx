<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecuperarPassword.aspx.cs" Inherits="Presentacion.RecuperarPassword" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Recuperar Contraseña - Sistema de Reservas</title>
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

        .recovery-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
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

        .recovery-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }

        .recovery-header h1 {
            font-size: 24px;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .recovery-header p {
            font-size: 14px;
            opacity: 0.9;
        }

        .recovery-body {
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
            margin-bottom: 10px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #f5f7fa;
            color: #667eea;
        }

        .btn-secondary:hover {
            background: #e1e8ed;
        }

        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .alert-info {
            background-color: #e3f2fd;
            border: 1px solid #90caf9;
            color: #1976d2;
        }

        .alert-success {
            background-color: #efe;
            border: 1px solid #cfc;
            color: #3c3;
        }

        .info-box {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .info-box p {
            color: #666;
            font-size: 14px;
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="recovery-container">
            <div class="recovery-header">
                <h1>🔐 Recuperar Contraseña</h1>
                <p>Ingrese su información para recuperar el acceso</p>
            </div>
            
            <div class="recovery-body">
                <asp:Panel ID="pnlMensaje" runat="server" Visible="false">
                    <div class="alert alert-info">
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                    </div>
                </asp:Panel>

                <div class="info-box">
                    <p><strong>Información importante:</strong></p>
                    <p>• Ingrese su nombre de usuario o email registrado</p>
                    <p>• Recibirá instrucciones para restablecer su contraseña</p>
                    <p>• Si no recibe el correo, contacte al administrador</p>
                </div>

                <div class="form-group">
                    <label for="txtUsuarioEmail">Usuario o Email</label>
                    <asp:TextBox 
                        ID="txtUsuarioEmail" 
                        runat="server" 
                        CssClass="form-control" 
                        placeholder="Ingrese su usuario o email"
                        MaxLength="100">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator 
                        ID="rfvUsuarioEmail" 
                        runat="server" 
                        ControlToValidate="txtUsuarioEmail"
                        ErrorMessage="Este campo es requerido" 
                        ForeColor="Red"
                        Display="Dynamic"
                        Font-Size="12px">
                    </asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <asp:Button 
                        ID="btnRecuperar" 
                        runat="server" 
                        Text="Recuperar Contraseña" 
                        CssClass="btn btn-primary"
                        OnClick="btnRecuperar_Click" />
                    
                    <asp:Button 
                        ID="btnVolver" 
                        runat="server" 
                        Text="Volver al Login" 
                        CssClass="btn btn-secondary"
                        CausesValidation="false"
                        OnClick="btnVolver_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
