<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>

<%@page import="model.entity.OpcionalVeiculo"%>
<%@page import="model.dao.OpcionalVeiculoDAO"%>
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
    if (request.getMethod().equalsIgnoreCase("post")) {
        VeiculoController veiculoController = new VeiculoController();
        veiculoController.inserirVeiculo(request);
        response.sendRedirect("listaVeiculos.jsp");
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
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery-1.9.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/Validators.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body>
        <script type="text/javascript">
            $(document).ready( function() {
                validaFormularioVeiculo()
            });
        </script>
        <h3 style="color: green;text-align: center" class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset2 span8 offset2">

                 <nav class="navbar">
                 <ul class="breadcrumb">
                    <li>
                        <a href="../index.jsp">Página Inicial</a><span class="divider">/</span>
                    </li>
                    <li>
                        <a href="listaVeiculos.jsp">Lista de Veículos</a><span class="divider">/</span>                        
                    </li>                   
                    <li class="active">
                        Lista de Veículos
                    </li>
                </ul>
            </nav>
            <hr>
            
        <form action="index.jsp" method="POST" id="formularioVeiculo" class="form-horizontal well">

                <div class="control-group">
                    <label class="control-label" for="inputPlaca">Placa</label>
                    <div class="controls">
                        <input type="text" id="placa" name="placa" placeholder="Placa">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputRenavan">Renavan</label>
                    <div class="controls">
                        <input type="text"  id="renavan" name="renavan" placeholder="Renavan">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputMarca">Marca</label>
                    <div class="controls">
                        <input type="text" name="marca" id="marca" placeholder="Marca">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputModelo">Modelo</label>
                    <div class="controls">
                        <input type="text" name="modelo" id="modelo" placeholder="Modelo">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCor">Cor</label>
                    <div class="controls">
                        <input type="text" name="cor" id="cor" placeholder="Cor">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCor">Ano</label>
                    <div class="controls">
                        <input type="text" name="ano" id="ano" placeholder="Ano">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"  for="inputCor">Tipo</label>
                    <div  class="controls">
                        <select id="tipo_veiculo" name="tipo_veiculo">
                            <%
                            TipoVeiculoController tipoVeiculoController = new TipoVeiculoController();
                            List<TipoVeiculo>  listaDeTipos;
                           listaDeTipos = tipoVeiculoController.listarTodosTiposVeiculos();
                            for(int i = 0;i<listaDeTipos.size();i++){        
                               out.print("<option value='"+listaDeTipos.get(i).getId()+"'>"+listaDeTipos.get(i).getDescricao() +"</option>");
                             }        
                           %>
                          
                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label" for="inputPassageiros">Capacidade de passageiros</label>
                    <div class="controls">
                        <input type="text" id="capacidade_passageiros"  name="capacidade_passageiros" placeholder="Capacidade de passageiros">
                        
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCarga">Capacidade de carga(Kg)</label>
                    <div class="controls">
                        <input type="text" name="capacidade_carga" id="capacidade_carga" placeholder="Capacidade carga">
                    </div>
                </div>
                  
                <div class="control-group">
                    <div class="controls">
                        <%
                        List<OpcionalVeiculo> lista;
                        OpcionalVeiculoDAO opcionalVeiculoDAO = new OpcionalVeiculoDAO();
                        lista  = opcionalVeiculoDAO.getTodosOpcionais();
                        for(int i =0;i<lista.size();i++){
                         out.println("<input type='checkbox' name='"+lista.get(i).getId()+"' value=' "+lista.get(i).getId()+"'>"+lista.get(i).getDescricao() +"<br>");
                        }
                        %>
                     </div>
                </div>
                 
                <div class="control-group">
                    <div class="controls">
                        <input type="submit" id="enviar" value="Cadastrar veiculo" class="btn">
                        <div class="btn"><a href="listaVeiculos.jsp">Cancelar</a></div>
                    </div>
                </div>


            </form>

        </div>
    </body>
</html>
