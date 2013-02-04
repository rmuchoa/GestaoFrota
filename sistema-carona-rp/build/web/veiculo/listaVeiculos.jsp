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
       <h3 style="color: green;text-align: center" class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset2 span8 well offset2">
 
        <h3>Lista de Veículos do sistema</h3>
        <div class="btn"><a href="index.jsp">Novo veículo</a></div>
        <div class="span12"></div>
        <table class="table table-bordered">
            <thead>
               <tr><td>Placa</td>
               <td>Cor</td>
               <td>Modelo</td>
               <td>Marca</td>
               <td>Capacidade Pessoas</td>
               <td>Capacidade Carga</td>
               <td>Ações</td></tr>
           </thead>
           <tbody>
               
               <%
               List<Veiculo> lista;
               VeiculoDAO veiculoDAO = new VeiculoDAO();
               lista = veiculoDAO.getTodosVeiculos();
               for(int i=0;i<lista.size();i++){
                out.println("<tr><td>"+lista.get(i).getPlaca()+"</td>");
                out.println("<td>"+lista.get(i).getCor()+"</td>");
                out.println("<td>"+lista.get(i).getModelo()+"</td>");
                out.println("<td>"+lista.get(i).getMarca()+"</td>");
                out.println("<td>"+lista.get(i).getCapacidade_passageiros()+"</td>");
                out.println("<td>"+lista.get(i).getCapacidade_carga()+"</td>"
 + "            <td><a href='editarVeiculo.jsp?id_veiculo="+lista.get(i).getId()+"'><img src='/sistema-carona-rp/img/edit_pencil.png' /></a></td>"
 + "            <td><a href='removerVeiculo.jsp?id_veiculo="+lista.get(i).getId()+"'><img src='/sistema-carona-rp/img/Gnome-Edit-Delete-32.png' /></a></td>"
 + "            </tr>");
               }
               %>
               
           </tbody>
       </table>
    </body>
    </div>
</html>
