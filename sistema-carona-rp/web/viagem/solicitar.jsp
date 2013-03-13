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
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        <script type="text/javascript">
            $(document).ready(function() {

                $("#estadoOrigem").change(function() {
                    $.ajax({
                        url: '../ajax/cidades.jsp',
                        dataType: 'html',
                        data: {estado: $('#estadoOrigem').val()},
                        type: 'POST',
                        success: function(data) {
                            $('#cidadeOrigem').html(data)
                        }
                    });
                });

                $("#estadoRetorno").change(function() {
                    $.ajax({
                        url: '../ajax/cidades.jsp',
                        dataType: 'html',
                        data: {estado: $('#estadoRetorno').val()},
                        type: 'POST',
                        success: function(data) {
                            $('#cidadeRetorno').html(data)
                        }
                    });
                });

            });
        </script>
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body style="">
        <h3 style="text-align: center;color: green" class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset1 span10 offset1">

            <nav class="navbar">
                <ul class="breadcrumb">
                    <li>
                        <a href="../index.jsp">Página Inicial</a><span class="divider">/</span>
                    </li>                   
                    <li class="active">
                        Solicitação de Viagem
                    </li>
                </ul>
            </nav>
            <hr> 


            <form action="solicitar.jsp" id="formularioSolicitacao" method="POST" class="form-horizontal well">
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
                            <select id="estadoOrigem" name="estadoOrigem">
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
                            <select id="cidadeOrigem" name="cidadeOrigem">
                                <option></option>
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
                            <select id="estadoRetorno" name="estadoRetorno">
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
                            <select id="cidadeRetorno" name="cidadeRetorno">
                                <option></option>
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
                <hr>

                <p>
                    <a href="../index.jsp" class="btn btn-info btn" title="Clique aqui para Retornar a Página Anterior!">&laquo; Voltar </a>

                    <button type="submit" class="btn btn-success btn" title="Clique aqui para Cadastrar um Passageiro!">
                        <i class="icon-ok"></i> Adicionar Passageiros
                    </button>
                </p>

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
        <br/>
    </body>
</html>
