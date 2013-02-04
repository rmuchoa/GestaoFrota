<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>

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
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.min.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body style="">
        <h3 style="color: green;text-align: center" class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset2 span8 offset2">
            <div class="hero-unit">
                <a href="veiculo/listaVeiculos.jsp"><button class="btn btn-success">
                        <img src="img/car.png">   
                    </button></a>
                <a href="usuario/listaUsuarios.jsp"><button class="btn btn-success">
                        <img src="img/user-mapping.png">   
                    </button></a>
                <a href="viagem/solicitar.jsp"><button class="btn btn-success">
                        <img src="img/suitcase_travel.png">   
                    </button></a>
             
            </div>
            
        </div>
    </body>
</html>

<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        VeiculoController veiculoController = new VeiculoController();
        veiculoController.inserirVeiculo(request);
    }
    
%>
