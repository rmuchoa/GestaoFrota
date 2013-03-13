<%-- 
    Document   : inicio
    Created on : 29/Jan/2013, 17:40:16
    Author     : Marcelo Maia
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Veiculo"%>
<%@page import="model.dao.VeiculoDAO"%>
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
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">

        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body>
        <h2 style="color: green;text-align: center" class="span12 well">Sistema de Caronas - Unipampa</h2>
        <div class="offset1 span10 offset1">

            <nav class="navbar">
                <ul class="breadcrumb">
                    <li>
                        <a href="../index.jsp">Página Inicial</a><span class="divider">/</span>
                    </li>
                    <li class="active">
                        Lista de Veículos
                    </li>
                </ul>
            </nav>
            <hr>           
            <div class="well">
                <h3>Lista de Veículos</h3>
                <%
                    if (request.getAttribute("removido") != null) {

                        Boolean removido = (Boolean) request.getAttribute("removido");
                        if (removido) {
                            out.println(""
                                    + "<div class='alert alert-success'>"
                                    + "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
                                    + "<strong> Sucesso: </strong> Veículo Excluido com Sucesso! </div>");
                        }
                    }
                %>                
                <hr>
                <br />
                <div>
                    <a href="index.jsp" class="btn btn btn-primary" title="Clique aqui para Cadastrar um Novo Veículo!">Novo Veículo</a>
                </div>
                <br />
                <table class="table table-striped table-bordered table-condensed">
                    <thead>
                        <tr>
                            <th>Placa</th>
                            <th>Cor</th>
                            <th>Modelo</th>
                            <th>Marca</th>
                            <th>Capacidade Pessoas</th>
                            <th>Capacidade Carga</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>

                        <%
                            List<Veiculo> lista;
                            VeiculoDAO veiculoDAO = new VeiculoDAO();
                            lista = veiculoDAO.getTodosVeiculos();
                            for (int i = 0; i < lista.size(); i++) {
                                out.println("<tr><td>" + lista.get(i).getPlaca() + "</td>");
                                out.println("<td>" + lista.get(i).getCor() + "</td>");
                                out.println("<td>" + lista.get(i).getModelo() + "</td>");
                                out.println("<td>" + lista.get(i).getMarca() + "</td>");
                                out.println("<td>" + lista.get(i).getCapacidadePassageiros() + "</td>");
                                out.println("<td>" + lista.get(i).getCapacidadeCarga() + "</td>"
                                        + "            <td title='Clique aqui para Editar o Veículo!'><a href='editarVeiculo.jsp?id=" + lista.get(i).getId() + "'><img src='/sistema-carona-rp/img/edit_pencil.png' /></a></td>"
                                        + "            <td title='Clique aqui para Excluir o Veículo!'><a href='removerVeiculo.jsp?id=" + lista.get(i).getId() + "'><img src='/sistema-carona-rp/img/Gnome-Edit-Delete-32.png' /></a></td>"
                                        + "            </tr>");
                            }
                        %>

                    </tbody>
                </table>

                <hr>
                <br />
                <div>
                    <a href="../index.jsp" class="btn btn-info btn" title="Clique aqui para Retornar a Página Anterior!">&laquo; Voltar </a>
                </div>
            </div>
        </div>
        <div class="span12 well">
            <hr>
            <footer style="text-align: center">
                <p>
                    &copy; 2013 <b>IbirapuiTech Coporation</b> - Todos os direitos reservados.
                </p>
                <em>
                    Desenvolvido como trabalho para a disciplina de Resolução de Problemas VI.
                </em>
            </footer>
        </div>
    </body>
</html>
