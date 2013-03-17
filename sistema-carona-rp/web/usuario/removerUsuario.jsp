<%-- 
    Document   : removerVeiculo
    Created on : 30/01/2013, 23:52:54
    Author     : renanmarceluchoa
--%>

<%@page import="util.Autenticacao"%>
<%@page import="java.util.List"%>
<%@page import="controller.UsuarioController"%>
<%@page import="controller.TipoUsuarioController"%>
<%@page import="model.entity.Usuario"%>
<%@page import="model.entity.TipoUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %> 
<%@ page import="javax.servlet.http.*" %> 
<!DOCTYPE html>

<%
    if (session.getAttribute("usuario") != null) {

        new Autenticacao("/sistema-carona-rp/index.jsp").valida(session, response, new String[]{"ADMINISTRADOR"});

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
        <script type="text/javas;cript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.min.js"></script>
        
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body>
        <h3 style="color: green;text-align: center"  class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset2 span8 offset2">

            <h3>Alteração dos dados do veículo</h3> 
            <%
                UsuarioController usuarioController = new UsuarioController();
                Usuario usuario = usuarioController.buscarPorId(Integer.parseInt(request.getParameter("id")));  
                usuarioController.remover(usuario);
                response.sendRedirect("listaUsuarios.jsp");
            %>
            <div class="offset1 span8 offset1 well">
                Usuario removido
            </div>
           

        </div>
    </body>
</html>

