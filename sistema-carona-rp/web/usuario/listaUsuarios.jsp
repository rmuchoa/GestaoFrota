<%-- 
    Document   : listaUsuarios
    Created on : 30/01/2013, 23:44:56
    Author     : renanmarceluchoa
--%>

<%@page import="controller.UsuarioController"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap-responsive.css">
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/jquery-1.8.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.min.js"></script>
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body>
        <h3 class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset2 span8 offset2">

            <h3>Lista de Veículos do sistema</h3>
            <div class="btn"><a href="cadastrarUsuario.jsp">Novo Usuário</a></div>
            <div class="span12"></div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <td>Nome</td>
                        <td>Login</td>
                        <td>Email</td>
                        <td>Tipo</td>
                        <td>Ações</td>
                    </tr>
                </thead>
                <tbody>

                    <%
                        List<Usuario> listaUsuarios;
                        UsuarioController usuarioController = new UsuarioController();
                        listaUsuarios = usuarioController.listar();
                        for (int i = 0; i < listaUsuarios.size(); i++) {
                            out.println("<tr><td>" + listaUsuarios.get(i).getNome() + "</td>");
                            out.println("<td>" + listaUsuarios.get(i).getLogin() + "</td>");
                            out.println("<td>" + listaUsuarios.get(i).getEmail() + "</td>");
                            out.println("<td>" + listaUsuarios.get(i).getTipoUsuario().getDescricao() + "</td>");
                            out.println("<td><a href='editarUsuario.jsp?id=" + listaUsuarios.get(i).getId() + "'><img src='/sistema-carona-rp/img/edit_pencil.png' /></a></td>"
                                    + "  <td><a href='removerUsuario.jsp?id=" + listaUsuarios.get(i).getId() + "'><img src='/sistema-carona-rp/img/Gnome-Edit-Delete-32.png' /></a></td>"
                                    + "  </tr>");
                        }
                    %>

                </tbody>
            </table>
    </body>
</div>
</html>
