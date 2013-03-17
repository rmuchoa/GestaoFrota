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
        System.out.print(usuario.getLogin() + "-" + usuario.getSenha());
        System.out.print(usuario.getTipoUsuario().getId());
        
        session.setAttribute("usuario", usuario);
        response.sendRedirect("index.jsp");
        
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
