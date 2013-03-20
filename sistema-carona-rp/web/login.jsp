<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>

<%@page import="controller.UsuarioController"%>
<%@page import="model.entity.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.TipoVeiculo"%>
<%@page import="controller.TipoVeiculoController"%>
<%@page import="controller.VeiculoController"%>
<%@page import="model.entity.Veiculo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %> 
<%@ page import="javax.servlet.http.*" %> 
<!DOCTYPE html>

<%

    Usuario usuario = null;
    
    if (request.getMethod().equalsIgnoreCase("post")) {

        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        usuario = new UsuarioController().fazerLogin(login, senha);
        
        session.setAttribute("usuario", usuario);
        response.sendRedirect("index.jsp");
        
    } else if (request.getMethod().equalsIgnoreCase("get")) {
        
        session.setAttribute("usuario", null);
        
    }
%>

<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap-responsive.css">
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/jquery-1.8.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">

        <title class="span12 well">Sistema de Caronas Unipampa</title>
    </head>
    <body>
        
        <div class="navbar nav">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="/sistema-carona-rp/index.jsp">Sistema Caronas</a>

                    <div class="nav-collapse collapse">
                        <ul class="nav">
                            <li class="divider-vertical"></li>
                            <li class="active"><a href="/sistema-carona-rp/index.jsp"><i class="icon-home"></i> Home</a></li>
                            <%
                                if (usuario != null) {
                                    if (usuario.getTipoUsuario().getId() == 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="usuario/listaUsuarios.jsp"><i class="icon-user"></i> Usuarios</a></li>

                            <%           }
                                if (usuario.getTipoUsuario().getId() == 2 || usuario.getTipoUsuario().getId() == 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="veiculo/listaVeiculos.jsp"><i class="icon-tags"></i> Veiculos</a></li>
                            <%           }
                                if (usuario.getTipoUsuario().getId() == 2 || usuario.getTipoUsuario().getId() == 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="viagem/listaSolicitacoes.jsp"><i class="icon-calendar"></i> Reservas</a></li>
                            <%           }
                                if (usuario.getTipoUsuario().getId() == 5 || usuario.getTipoUsuario().getId() == 4) {
                            %>      
                            <li class="divider-vertical"></li>
                            <li><a href="viagem/formularioViagem.jsp"><i class="icon-road"></i> Relatorio Viagem</a></li>
                            <%           }
                                if (usuario.getTipoUsuario().getId() >= 1 && usuario.getTipoUsuario().getId() <= 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="viagem/solicitar.jsp"><i class="icon-envelope"></i> Solicitação</a></li>
                            <%           }
                                    }
                            %>
                        </ul>
                        <%
                            if (usuario != null) {
                        %>
                        <div class="pull-right">
                            <ul class="nav pull-right">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <i class="icon-user"></i> Bem vindo, <%= usuario.getNome()%> <span class="caret"></span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a href="/sistema-carona-rp/login.jsp"><i class="icon-off"></i> Logout</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <%
                            } else {
                        %>
                        <div class="pull-right">
                            <ul class="nav pull-right">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="/sistema-carona-rp/login.jsp">
                                        <i class="icon-user"></i> Login
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <h2 style="color: green;text-align: center" class="span12 well">Sistema de Caronas - Unipampa</h2>

        <div class="offset5 span5">

            <form action="login.jsp" method="post">

                <div class="control-group">
                    <label class="control-label" for="inputLogin">Login</label>
                    <div class="controls">
                        <input type="text"  id="login" name="login" placeholder="Login" title="Insira o seu Login de Usuário">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputSenha">Senha</label>
                    <div class="controls">
                        <input type="password"  id="senha" name="senha" placeholder="Senha" title="Insira a sua Senha">
                    </div>
                </div>

                <input type="submit" class="btn btn-success btn" value="Acessar" />

            </form>

        </div>

        <div class="span12 well">
            <hr>
            <footer style="text-align: center">
                <p>
                    &copy; 2013 <b>IbirapuiTech Corporation</b> - Todos os direitos reservados.
                </p>
                <em>
                    Desenvolvido como trabalho para a disciplina de Resolução de Problemas VI.
                </em>
            </footer>
        </div>
    </body>
</html>
