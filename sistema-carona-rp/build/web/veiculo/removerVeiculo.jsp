<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>

<%@page import="model.dao.VeiculoOpcionalVeiculoDAO"%>
<%@page import="model.dao.VeiculoDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.TipoVeiculo"%>
<%@page import="controller.TipoVeiculoController"%>
<%@page import="controller.VeiculoController"%>
<%@page import="model.entity.Veiculo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %> 
<%@ page import="javax.servlet.http.*" %> 
<!DOCTYPE html>

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
        <h3 style="color: green;text-align: center" class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset2 span8 offset2">

            <h3>Alteração dos dados do veículo</h3> 
            <% VeiculoDAO veiculoDAO = new VeiculoDAO();
            Veiculo veiculo;
            veiculo =  veiculoDAO.getVeiculoPorId(Integer.parseInt(request.getParameter("id")));  
            veiculoDAO.removerVeicupoPorId(veiculo.getId());
            VeiculoOpcionalVeiculoDAO veiculo_opcional_veiculoDAO = new VeiculoOpcionalVeiculoDAO();
            veiculo_opcional_veiculoDAO.remover(veiculo.getId());
            response.sendRedirect("listaVeiculos.jsp");
           
            %>
            <div class="offset1 span8 offset1 well">
                Usuario removido
            </div>
           

        </div>
    </body>
</html>

