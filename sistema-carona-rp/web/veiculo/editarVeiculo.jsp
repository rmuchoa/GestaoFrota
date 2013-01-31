<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>

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
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body>
        <h3 class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset2 span8 offset2">

            <h3>Alteração dos dados do veículo</h3> 
            <% VeiculoDAO veiculoDAO = new VeiculoDAO();
            Veiculo veiculo;
             veiculo =  veiculoDAO.getVeiculoPorId(Integer.parseInt(request.getParameter("id_veiculo")));  
            %>
            <form action="editarVeiculo.jsp?id_veiculo=<%out.println(request.getParameter("id_veiculo"));%>" method="POST" class="form-horizontal well">

                <input  style="display:none" name="id" value="<% out.print(veiculo.getId()); %>">
                <div class="control-group">
                    <label class="control-label" for="inputPlaca">Placa</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(veiculo.getPlaca());%>" id="placa" name="placa" placeholder="Placa">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputRenavan">Renavan</label>
                    <div class="controls">
                        <input type="text"  value="<%out.println(veiculo.getRenavam());%>" id="renavan" name="renavan" placeholder="Renavan">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputMarca">Marca</label>
                    <div class="controls">
                        <input type="text" name="marca" value="<%out.println(veiculo.getMarca());%>"  id="marca" placeholder="Marca">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputModelo">Modelo</label>
                    <div class="controls">
                        <input type="text" name="modelo" value="<%out.println(veiculo.getModelo());%>"  id="modelo" placeholder="Modelo">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCor">Cor</label>
                    <div class="controls">
                        <input type="text" name="cor" value="<%out.println(veiculo.getCor());%>" id="cor" placeholder="Cor">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCor">Ano</label>
                    <div class="controls">
                        <input type="text" name="ano" value="<%out.println(veiculo.getAno());%>" id="ano" placeholder="Ano">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"  for="inputCor">Tipo</label>
                    <div  class="controls">
                        <select name="tipo_veiculo">
                            <%
                            TipoVeiculoController tipoVeiculoController = new TipoVeiculoController();
                            List<TipoVeiculo>  listaDeTipos;
                            listaDeTipos = tipoVeiculoController.listarTodosTiposVeiculos();
                            for(int i = 0;i<listaDeTipos.size();i++){
                               if(veiculo.getTipo_veiculo().getDescricao().equals(listaDeTipos.get(i).getDescricao())){   
                                out.print("<option selected = 'true'>"+listaDeTipos.get(i).getDescricao() +"</option>");
                               }
                              else{
                                out.print("<option>"+listaDeTipos.get(i).getDescricao() +"</option>");
                              }
                            }        
                           %>
                           
                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label"  for="inputPassageiros">Capacidade de passageiros</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(veiculo.getCapacidade_passageiros());%>" id="capacidade_passageiros"  name="capacidade_passageiros" placeholder="Capacidade de passageiros">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCarga">Capacidade de carga(Kg)</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(veiculo.getCapacidade_carga());%>" name="capacidade_carga" id="capacidade_carga" placeholder="Capacidade carga">
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

<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        System.out.println("chego aq");
        VeiculoController veiculoController = new VeiculoController();
        veiculoController.alterarVeiculo(request);
        response.sendRedirect("listaVeiculos.jsp");
     }
    
%>
