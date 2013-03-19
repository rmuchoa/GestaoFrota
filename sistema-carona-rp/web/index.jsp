<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>

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

    Usuario login = null;
    
    if (session.getAttribute("usuario") != null) {

        login = (Usuario) session.getAttribute("usuario");

    } else {

        response.sendRedirect("login.jsp");

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
                                if (login != null) {
                                    if (login.getTipoUsuario().getId() == 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="usuario/listaUsuarios.jsp"><i class="icon-user"></i> Usuarios</a></li>

                            <%           }
                                if (login.getTipoUsuario().getId() == 2 || login.getTipoUsuario().getId() == 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="veiculo/listaVeiculos.jsp"><i class="icon-tags"></i> Veiculos</a></li>
                            <%           }
                                if (login.getTipoUsuario().getId() == 2 || login.getTipoUsuario().getId() == 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="viagem/listaSolicitacoes.jsp"><i class="icon-calendar"></i> Reservas</a></li>
                            <%           }
                                if (login.getTipoUsuario().getId() == 5 || login.getTipoUsuario().getId() == 4) {
                            %>      
                            <li class="divider-vertical"></li>
                            <li><a href="viagem/formularioViagem.jsp"><i class="icon-road"></i> Relatorio Viagem</a></li>
                            <%           }
                                if (login.getTipoUsuario().getId() >= 1 && login.getTipoUsuario().getId() <= 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="viagem/solicitar.jsp"><i class="icon-envelope"></i> Solicitação</a></li>
                            <%           }
                                    }
                            %>
                        </ul>
                        <%
                            if (login != null) {
                        %>
                        <div class="pull-right">
                            <ul class="nav pull-right">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <i class="icon-user"></i> Bem vindo, <%= login.getNome()%> <span class="caret"></span>
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

        <div id="wrap">

            <div id="header">
                <h2 style="color: green;text-align: center" class="span12 well">Sistema de Caronas - Unipampa</h2>
            </div>

            <div id="main">

                <div class="offset1 span10 offset1">

                    <div class="hero-unit" id="div-menu-home">
                        <%
                            if (login != null) {
                                if (login.getTipoUsuario().getId() == 4) {
                        %>
                        <a href="usuario/listaUsuarios.jsp">
                            <button class="btn btn-success" title="Clique aqui para Acessar a Área de Usuários!">
                                <img src="img/user-mapping.png">   
                            </button>
                        </a>
                        <%      }
                            if (login.getTipoUsuario().getId() == 2 || login.getTipoUsuario().getId() == 4) {
                        %>
                        <a href="veiculo/listaVeiculos.jsp">
                            <button class="btn btn-success" title="Clique aqui para Acessar a Área de Veículos!">
                                <img src="img/car.png">   
                            </button>
                        </a>
                        <%      }
                            if (login.getTipoUsuario().getId() == 2 || login.getTipoUsuario().getId() == 4) {
                        %>
                        <a href="viagem/listaSolicitacoes.jsp">
                            <button class="btn btn-success" title="Clique aqui para Acessar a Área de Viagens!">
                                <img src="img/viagem.png">   
                            </button>
                        </a>
                        <%      }
                            if (login.getTipoUsuario().getId() == 5 || login.getTipoUsuario().getId() == 4) {
                        %>
                        <a href="viagem/formularioViagem.jsp">
                            <button class="btn btn-success" title="Clique aqui para Registrar as Informações da Viagem!">
                                <img src="img/relatorio.png">   
                            </button>
                        </a>
                        <%      }
                            if (login.getTipoUsuario().getId() >= 1 && login.getTipoUsuario().getId() <= 4) {
                        %>
                        <a href="viagem/solicitar.jsp">
                            <button class="btn btn-success" title="Clique aqui para fazer uma Solicitação de Viagens!">
                                <img src="img/solicitar.png">   
                            </button>
                        </a>
                        <%      }
                            }
                        %>
                    </div>
                </div>
            </div>       
        </div>
                    
        <div id="footer" class="well">
            <hr>
            <footer>
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
