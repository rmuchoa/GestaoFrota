<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>

<%@page import="model.entity.Usuario"%>
<%@page import="controller.UsuarioController"%>
<%@page import="model.entity.Cidade"%>
<%@page import="controller.CidadeController"%>
<%@page import="model.entity.Estado"%>
<%@page import="controller.EstadoController"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="model.dao.SituacaoSolicitacaoDAO"%>
<%@page import="model.entity.SituacaoSolicitacao"%>
<%@page import="controller.SolicitacaoViagemController"%>
<%@page import="model.entity.OpcionalVeiculo"%>
<%@page import="model.dao.OpcionalVeiculoDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.TipoVeiculo"%>
<%@page import="controller.TipoVeiculoController"%>
<%@page import="controller.VeiculoController"%>
<%@page import="model.entity.Veiculo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.*" %> 
<%@page import="javax.servlet.http.*" %> 
<!DOCTYPE html>

<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        if (request.getParameter("avancar") != null) {
            SolicitacaoViagemController solicitacaoViagemController = new SolicitacaoViagemController();
            SolicitacaoViagem solicitacaoViagem = solicitacaoViagemController.inserirSolicitacao(request);
            request.setAttribute("solicitacao", solicitacaoViagem);
            RequestDispatcher dispatcher = request.getRequestDispatcher("passageiros.jsp");
            dispatcher.forward(request, response);
        }
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
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body style="">
        <h3 style="text-align: center;color: green" class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset1 hero-unit span9">



            <form action="solicitar.jsp" id="formularioSolicitacao" method="POST" class="form-horizontal">
                <legend>Formulario de solicitação de Viagens</legend>
                <div class="control-group">
                    <label class="control-label" for="inputSolicitante">Nome do solicitante:</label>
                    <div class="controls">
                        <select name="solicitante">
                            <option></option>
                            <%
                                UsuarioController usuarioController = new UsuarioController();
                                List<Usuario> usuarios = usuarioController.listar();
                                for (int i = 0; i < usuarios.size(); i++) {
                                    out.print("<option value='" + usuarios.get(i).getId() + "'>" + usuarios.get(i).getNome() + " - " + usuarios.get(i).getRg() + "</option>");
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="Passageiro">O Solicitante é passageiro:</label>
                    <div class="controls">
                        <input type="radio" name="passageiro" value="true">Sim
                        <input type="radio" name="passageiro" value="false"> Não
                    </div>
                </div>

                <fieldset>
                    <legend>Informações da origem</legend>
                    <div class="control-group">
                        <label class="control-label" for="inputEstadoOrigem">Estado de origem:</label>
                        <div class="controls">
                            <select name="estadoOrigem">
                                <option></option>
                                <%
                                    EstadoController estadoController = new EstadoController();
                                    List<Estado> listaEstadosOriegem = estadoController.listar();
                                    for (int i = 0; i < listaEstadosOriegem.size(); i++) {
                                        out.print("<option value='" + listaEstadosOriegem.get(i).getId() + "'>" + listaEstadosOriegem.get(i).getSigla() + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="inputCidadeOrigem">Cidade de origem:</label>
                        <div class="controls">
                            <select name="cidadeOrigem">
                                <option></option>
                                <%
                                    CidadeController cidadeController = new CidadeController();
                                    List<Cidade> listaCidadesOrigem = cidadeController.listar();
                                    for (int i = 0; i < listaCidadesOrigem.size(); i++) {
                                        Cidade cidade = listaCidadesOrigem.get(i);
                                        out.print("<option value='" + cidade.getId() + "'>" + cidade.getNome() + " - " + cidade.getEstado().getSigla() + "</option>");
                                    }
                                %> 
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
                                <option></option>
                                <%
                                    estadoController = new EstadoController();
                                    List<Estado> listaEstadosDestino = estadoController.listar();
                                    for (int i = 0; i < listaEstadosDestino.size(); i++) {
                                        out.print("<option value='" + listaEstadosDestino.get(i).getId() + "'>" + listaEstadosDestino.get(i).getSigla() + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    
                    <div class="control-group">
                        <label class="control-label" for="inputCidadeOrigem">Cidade:</label>
                        <div class="controls">
                            <select name="cidadeRetorno">
                                <option></option>
                                <%
                                    cidadeController = new CidadeController();
                                    List<Cidade> listaCidadesDestino = cidadeController.listar();
                                    for (int i = 0; i < listaCidadesDestino.size(); i++) {
                                        Cidade cidade = listaCidadesDestino.get(i);
                                        out.print("<option value='" + cidade.getId() + "'>" + cidade.getNome() + " - " + cidade.getEstado().getSigla() + "</option>");
                                    }
                                %> 
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
                            <textarea name="objetivo"  rows="4" style="width: 90%" >

                            </textarea>
                        </div>    
                    </div>    
                </fieldset>

                <fieldset>
                    <legend>Observações</legend>
                    <div class="control-group">
                        <div class="controls">
                            <textarea name="observacao"  rows="4" style="width: 90%" >

                            </textarea>
                        </div>    
                    </div>    
                </fieldset>

                <div class="span11">
                    <div class="span5">    
                        <input type="submit" name="enviar" value="Cancelar" class="btn btn-success btn-large">
                    </div>
                    <div class="span5">
                        <input type="submit" name="avancar" value="Adicionar passageiros" class="btn btn-success btn-large">
                    </div>
                </div>
                
            </form>

        </div>
        <br/>
    </body>
</html>
