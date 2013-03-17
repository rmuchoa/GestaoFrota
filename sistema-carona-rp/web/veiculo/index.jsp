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
            $(document).ready(function() {
                validaFormularioVeiculo()
            });
        </script>

        <h2 style="color: green;text-align: center" class="span12 well">Sistema de Caronas - Unipampa</h2>

        <div class="offset1 span10 offset1">
            <nav class="navbar">
                <ul class="breadcrumb">
                    <li>
                        <a href="../index.jsp">Página Inicial</a><span class="divider">/</span>
                    </li>
                    <li>
                        <a href="listaVeiculos.jsp">Lista de Veículos</a><span class="divider">/</span>                        
                    </li>                   
                    <li class="active">
                        Cadastro de Veículos
                    </li>
                </ul>
            </nav>
            <hr>

            <form action="index.jsp" method="POST" id="formularioVeiculo" class="form-horizontal well">

                <div class="control-group">
                    <label class="control-label" for="inputPlaca">Placa</label>
                    <div class="controls">
                        <input type="text" id="placa" name="placa" placeholder="Placa" title="Insira a Placa" required="true" autofocus>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputRenavan">Renavan</label>
                    <div class="controls">
                        <input type="text"  id="renavan" name="renavan" placeholder="Renavan" title="Insira o Renavan" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputMarca">Marca</label>
                    <div class="controls">
                        <input type="text" name="marca" id="marca" placeholder="Marca" title="Insira a Marca" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputModelo">Modelo</label>
                    <div class="controls">
                        <input type="text" name="modelo" id="modelo" placeholder="Modelo" title="Insira o Modelo" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCor">Cor</label>
                    <div class="controls">
                        <input type="text" name="cor" id="cor" placeholder="Cor" title="Insira a Cor" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCor">Ano</label>
                    <div class="controls">
                        <input type="text" name="ano" id="ano" placeholder="Ano" title="Insira o Ano" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"  for="inputCor">Tipo</label>
                    <div  class="controls">
                        <select id="tipo_veiculo" name="tipo_veiculo" title="Selecione o tipo do Veículo">
                            <%
                                TipoVeiculoController tipoVeiculoController = new TipoVeiculoController();
                                List<TipoVeiculo> listaDeTipos;
                                listaDeTipos = tipoVeiculoController.listarTodosTiposVeiculos();
                                for (int i = 0; i < listaDeTipos.size(); i++) {
                                    out.print("<option value='" + listaDeTipos.get(i).getId() + "'>" + listaDeTipos.get(i).getDescricao() + "</option>");
                                }
                            %>

                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label" for="inputPassageiros">Capacidade de passageiros</label>
                    <div class="controls">
                        <input type="text" id="capacidade_passageiros"  name="capacidade_passageiros" placeholder="Capacidade de passageiros" title="Insira a Capacidade de Passageiros" required="true">

                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCarga">Capacidade de carga(Kg)</label>
                    <div class="controls">
                        <input type="text" name="capacidade_carga" id="capacidade_carga" placeholder="Capacidade carga" title="Insira a Capacidade de Carga" required="true">
                    </div>
                </div>

                   <div class="control-group">
                       <label class="control-label" for="itensOpc">Itens Opcionais</label>
                    <div class="controls">
                        <%
                            List<OpcionalVeiculo> lista;
                            OpcionalVeiculoDAO opcionalVeiculoDAO = new OpcionalVeiculoDAO();
                            lista = opcionalVeiculoDAO.getTodosOpcionais();
                            for (int i = 0; i < lista.size(); i++) {
                                out.println("<label class='checkbox'><input type='checkbox' name='" + lista.get(i).getId() + "' value=' " + lista.get(i).getId() + "'>" + lista.get(i).getDescricao() + "</label>");
                            }
                        %>
                    </div>
                </div>
                <hr>
                
                <p>
                    <a href="listaVeiculos.jsp" class="btn btn-info btn" title="Clique aqui para Retornar a Página Anterior!">&laquo; Voltar </a>

                    <button type="submit" class="btn btn-success btn" title="Clique aqui para Cadastrar um Novo Veículo!">
                        <i class="icon-ok"></i> Cadastrar </button>
                </p>
        </div>
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
