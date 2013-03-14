<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>


<%@page import="model.entity.Usuario"%>
<%@page import="controller.UsuarioController"%>
<%@page import="controller.SolicitacaoViagemController"%>
<%@page import="controller.ViagemController"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="model.entity.Cidade"%>
<%@page import="controller.CidadeController"%>
<%@page import="model.entity.Estado"%>
<%@page import="java.util.List"%>
<%@page import="controller.EstadoController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.*" %> 
<%@page import="javax.servlet.http.*" %> 
<!DOCTYPE html>

<%
   
    List<SolicitacaoViagem> selecionadas = null;

    if (request.getMethod().equalsIgnoreCase("post")) {

        if (request.getParameter("criarViagem") != null) {

            if (request.getAttribute("solicitacoes") != null) {
                selecionadas = (List<SolicitacaoViagem>) request.getAttribute("solicitacoes");
            }

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

        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/pick/jquery-ui.css">
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery-ui.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.ui.datepicker-pt-BR.js"></script>

        <script type="text/javascript" src="/sistema-carona-rp/perifer-timePicker-b5195df/jquery.timePicker.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/perifer-timePicker-b5195df/jquery.timePicker.min.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/perifer-timePicker-b5195df/timePicker.css">

        <script type="text/javascript" src="/sistema-carona-rp/ajax/Viagem.js"></script>

        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        <script>
            $(document).ready(function() {
   
                $("#data_saida").datepicker($.datepicker.regional['pt-BR']);
                $("#data_retorno").datepicker($.datepicker.regional['pt-BR']);
                $("#horario_saida").timePicker();
                $("#horario_retorno").timePicker();
                
                $("#estadoOrigem").change(function() {
                    $.ajax({
                        url:'../ajax/cidades.jsp',
                        dataType:'html',
                        data:{estado: $('#estadoOrigem').val()},
                        type:'POST',
                        success:function(data){
                            $('#cidadeOrigem').html(data)
                        }
                    });
                });
                
                $("#estadoRetorno").change(function() {
                    $.ajax({
                        url:'../ajax/cidades.jsp',
                        dataType:'html',
                        data:{estado: $('#estadoRetorno').val()},
                        type:'POST',
                        success:function(data){
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

        <div class="offset1 hero-unit span9">
            <div>Solicitações Respondidas</div>
            <br/>
            <table id="tabela1" class="table table-bordered">
                <thead>
                    <tr>
                        <td>Id</td>
                        <td>Data de Saida</td>
                        <td>Origem</td>
                        <td>Destino</td>
                        <td>Situação</td>
                        <td>Selecionar</td>
                    </tr>
                    </head>

                <tbody>

                    <%  
                       ViagemController viagemController = new ViagemController();
                       for (SolicitacaoViagem solicitacao : selecionadas) {
                    %>

                    <tr  id="<%= solicitacao.getId()%>">
                        <td id="identificador" ><%= solicitacao.getId()%></td>
                        <td><%= new SimpleDateFormat("dd/MM/yyyy").format(solicitacao.getDataSaida())%></td>
                        <td><%= solicitacao.getOrigem().getNome()%></td>
                        <td><%= solicitacao.getDestino().getNome()%></td>
                        <td><%= solicitacao.getSituacao().getDescricao()%></td>
                        <td>
                            
                           
                            <a href="#" onclick="removerItemTabela(<%= solicitacao.getId()%>)" class="btn btn-mini">X</a>
                            <a href="#" onclick="exibirDetalhesItemDaTabela(<%= viagemController.criarDetalheItem(solicitacao)%>)" class="btn btn-mini" >detalhes</a>
                        </td>
                    </tr>
                    
                    <%
                        }
                    %>
                      
                </tbody>
                <tbody id="escolhadomodal">
                </tbody>

            </table>
            <div class="span12">
                <div class="span5"></div>    
                <div class="span4">
                    <a href="" onclick="adicionarNovasSolicitacoes()" data-toggle="modal" class="btn btn-large">Adicionar outra solicitação</a>
                </div>           
            </div>           

            <div class="span12"></div>     
            <form class="form" id="form">

                <div class="control-group">
                    <label class="control-label" for="inputVeiculo">Veiculo</label>
                    <div class="controls">
                        <select style="width: 90%" name="veiculo">
                            <option>Gol branco, 4 pessoas placa 4434</option>
                        </select>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputMotorista">Motorista</label>
                    <div class="controls">
                        <select style="width: 90%" name="motorista">
                            <option>Selecione o motorista</option>
                             <%
                                    UsuarioController usuarioController = new UsuarioController();
                                    List<Usuario> usuarios = usuarioController.listar();
                                    for (int i = 0; i < usuarios.size(); i++) {
                                        if(usuarios.get(i).getTipoUsuario().getDescricao().endsWith("MOTORISTA")){
                                            out.print("<option value='" + usuarios.get(i).getId() + "'>" + usuarios.get(i).getNome() +" - Tel("+ usuarios.get(i).getTelefone()+") </option>");
                                        }
                                    }
                                %>
                        </select>
                    </div>
                </div>

                <fieldset>
                    <legend>Informações da origem</legend>
                    <div class="control-group">
                        <label class="control-label" for="inputEstadoOrigem">Estado de origem:</label>
                        <div class="controls">
                            <select id="estadoOrigem" name="estadoOrigem">
                                <option>Selecione o estado de Origem</option>
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
                                <option>Selecione a cidade de origem</option>

                            </select>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="inputDataSaida">Data de saída:</label>
                        <div class="controls">
                            <input class="input-xxlarge" type="text" id="data_saida" name="dataSaida" placeholder="12/12/2013">

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="inputHorarioSaida">Horario de saída</label>
                        <div class="controls">
                            <input class="input-xxlarge"  type="text" id="horario_saida" name="horarioSaida" placeholder="08:24">

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
                                <option>Selecione o estado de retorno</option>
                                 <%
                                    for (int i = 0; i < listaEstadosOriegem.size(); i++) {
                                        out.print("<option value='" + listaEstadosOriegem.get(i).getId() + "'>" + listaEstadosOriegem.get(i).getSigla() + "</option>");
                                    }
                                %>

                            </select>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="inputCidadeOrigem">Cidade:</label>
                        <div class="controls">
                            <select id="cidadeRetorno" name="cidadeRetorno">
                                <option>Selecione a cidade de retorno</option>

                            </select>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="inputDataRetorno">Data:</label>
                        <div class="controls">
                            <input class="input-xxlarge" type="text" id="data_retorno" name="dataRetorno" placeholder="12/12/2013">

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="inputHorarioRetorno">Horario:</label>
                        <div class="controls">
                            <input class="input-xxlarge" type="text" id="horario_retorno" name="horarioRetorno" placeholder="08:24">

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="inputLocalRetorno">Local:</label>
                        <div class="controls">
                            <input class="input-xxlarge" type="text" id="localRetorno" name="localRetorno" placeholder="Em frente a unipampa">

                        </div>
                    </div>
                </fieldset>  

                <div class="control-group">
                    <label class="control-label" for="inputPercurso">Percurso:</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="percurso" name="percurso" placeholder="Alegrete/bage/alegrete">

                    </div>
                </div>

                <fieldset>
                    <legend>Observações</legend>
                    <div class="control-group">
                        <div class="controls">
                            <textarea name="observacao"  rows="4" style="width: 90%" >

                            </textarea>
                        </div>    
                    </div>    
                </fieldset> 
                   <button type="submit" class="btn btn-success btn" title="Clique aqui para criar a viagem!">
                        <i class="icon-ok"></i> Criar viagem
                    </button>              

            </form>
            <br/>

        </div>
        <br/>

        <div id="myModal" title="Lista de solicitação" style="display: none">
            
                    

                <div id="ResultTabela"></div>

               
        </div>
        <div id="ModalItemTabela" title="Lista de solicitação" style="display: none">

        </div>            
    </body>
</html>
