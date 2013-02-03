<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>

<%@page import="model.entity.OpicionalVeiculo"%>
<%@page import="model.dao.OpicionalVeiculoDAO"%>
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
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body style="">
        <h3 style="text-align: center;color: green" class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset1 span10 offset1">


            
            <form action="index.jsp" method="POST" class="form-horizontal">
                <legend>Formulario de solicitação de Viagens</legend>
                <div class="control-group">
                    <label class="control-label" for="inputSolicitante">Nome do solicitante:</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="solicitante" name="solicitante" placeholder="Nome do solicitante">
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label" for="inputNumeroPessoas">Numero de pessoas transportadas:</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="numeroPessoas" name="numeroPessoas" placeholder="Numero de pessoas transportadas">
                    </div>
                </div>
                
                <fieldset>
                <legend>Informações da origem</legend>
                <div class="control-group">
                    <label class="control-label" for="inputEstadoOrigem">Estado de origem:</label>
                    <div class="controls">
                        <select name="estadoOrigem">
                            <option>MG</option>
                            <option>RS</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputCidadeOrigem">Cidade de origem:</label>
                    <div class="controls">
                        <select name="cidadeOrigem">
                            <option>Ouro Preto</option>
                            <option>Belo Horizonte</option>
                        </select>
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label" for="inputDataSaida">Data de saída:</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="dataSaida" name="dataSaida" placeholder="12/12/2013">
                   
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputHorarioSaida">Horario de saída</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="horarioSaida" name="horarioSaida" placeholder="08:24">
                   
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputLocalSaida">Local de saída</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="localSaida" name="localSaida" placeholder="Em frente a unipampa">
                   
                    </div>
                </div>
                </fieldset>
                
                
                <fieldset>
                <legend>Informações do Retorno</legend>
                <div class="control-group">
                    <label class="control-label" for="inputEstadoRetorno">Estado</label>
                    <div class="controls">
                        <select name="estadoRetorno">
                            <option>MG</option>
                            <option>RS</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputCidadeOrigem">Cidade:</label>
                    <div class="controls">
                        <select name="cidadeRetorno">
                            <option>Ouro Preto</option>
                            <option>Belo Horizonte</option>
                        </select>
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label" for="inputDataRetorno">Data:</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="dataRetorno" name="dataRetorno" placeholder="12/12/2013">
                   
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputHorarioRetorno">Horario:</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="horarioRetorno" name="horarioRetorno" placeholder="08:24">
                   
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputLocalRetorno">Local:</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="localRetorno" name="localRetorno" placeholder="Em frente a unipampa">
                   
                    </div>
                </div>
                </fieldset>
                <hr/>
                 <div class="control-group">
                    <label class="control-label" for="inputPercurso">Percurso:</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="percurso" name="percurso" placeholder="Alegrete/bage/alegrete">
                   
                    </div>
                </div>
                
                <fieldset>
                    <legend>Objetivo/Justificativa para a viagem</legend>
                    <div class="control-group">
                        <div class="controls">
                            <textarea  rows="4" style="width: 90%" >

                            </textarea>
                        </div>    
                    </div>    
                </fieldset>
                
                 <fieldset>
                    <legend>Observações</legend>
                    <div class="control-group">
                        <div class="controls">
                            <textarea  rows="4" style="width: 90%" >

                            </textarea>
                        </div>    
                    </div>    
                </fieldset>
                
                <div class="span11">
                    <div class="span5">    
                        <input type="submit" value="Enviar Solicitação" class="btn btn-success btn-large">
                    </div>
                    <div class="span5">
                        <a href=""  class="btn btn-success btn-large">Lista de passageiros</a>
                    </div>
                </div>

                

            </form>

        </div>
        <br/>
    </body>
</html>
