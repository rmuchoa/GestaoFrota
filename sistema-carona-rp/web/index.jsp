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

    Usuario usuario = null;

    if (session.getAttribute("usuario") != null) {
        usuario = (Usuario) session.getAttribute("usuario");
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
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.min.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">

        <title class="span12 well">Sistema de Caronas Unipampa</title>

    </head>
    <body style="">
        
        <h2 style="color: green;text-align: center" class="span12 well">Sistema de Caronas - Unipampa</h2>
        <div class="offset1 span10 offset1">

            <div class="hero-unit" id="div-menu-home">
                <%
                    if (usuario != null) {
                        if (usuario.getTipoUsuario().getId() == 4) {
                %>
                <a href="usuario/listaUsuarios.jsp">
                    <button class="btn btn-success" title="Clique aqui para Acessar a Área de Usuários!">
                        <img src="img/user-mapping.png">   
                    </button>
                </a>
                <%      }
                        if (usuario.getTipoUsuario().getId() == 2 || usuario.getTipoUsuario().getId() == 4) {
                %>
                <a href="veiculo/listaVeiculos.jsp">
                    <button class="btn btn-success" title="Clique aqui para Acessar a Área de Veículos!">
                        <img src="img/car.png">   
                    </button>
                </a>
                <%      }
                        if (usuario.getTipoUsuario().getId() == 2 || usuario.getTipoUsuario().getId() == 4) {
                %>
                <a href="viagem/listaSolicitacoes.jsp">
                    <button class="btn btn-success" title="Clique aqui para Acessar a Área de Viagens!">
                        <img src="img/viagem.png">   
                    </button>
                </a>
                <%      }
                        if (usuario.getTipoUsuario().getId() == 5 || usuario.getTipoUsuario().getId() == 4) {
                %>
                <a href="#">
                    <button class="btn btn-success" title="Clique aqui para Registrar as Informações da Viagem!">
                        <img src="img/relatorio.png">   
                    </button>
                </a>
                <%      }
                        if (usuario.getTipoUsuario().getId() >= 1 || usuario.getTipoUsuario().getId() <= 5) {
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