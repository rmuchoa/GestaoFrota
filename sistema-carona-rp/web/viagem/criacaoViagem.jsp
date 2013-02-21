<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>


<%@page import="model.entity.Cidade"%>
<%@page import="controller.CidadeController"%>
<%@page import="model.entity.Estado"%>
<%@page import="java.util.List"%>
<%@page import="controller.EstadoController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.*" %> 
<%@page import="javax.servlet.http.*" %> 
<!DOCTYPE html>



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


        <script type="text/javascript" src="/sistema-carona-rp/Ajax/Viagem.js"></script>

        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        <script>
            $(document).ready(function() {
   
                $("#data_saida").datepicker($.datepicker.regional['pt-BR']);
                $("#data_retorno").datepicker($.datepicker.regional['pt-BR']);
                $("#hora_saida").timePicker();
                $("#hora_retorno").timePicker();
            });
        </script>
        <title>Sistema de Caronas Unipampa</title>
    </head>
    
    <body style="">
        <h3 style="text-align: center;color: green" class="span12 well">Sistema de Caronas Unipampa</h3>

        <div class="offset1 hero-unit span9">
            <div>Solicitações associadas</div>
            <br/>
            <table id="tabela1" class="table table-bordered">
                <thead>
                    <tr>
                        <td>CD Solicitação</td>
                        <td>Data Saida</td>
                        <td>Origem</td>
                        <td>Destino</td>
                        <td>Status solicitação</td>
                        <td>Selecionar</td>
                    </tr>
                    </head>

                <tbody>

                    <tr>
                        <td id="codigo">0012</td>
                        <td>12/02/2012</td>
                        <td>Alegrete-RS</td>
                        <td>Bage-RS</td>
                        <td>Aguardando Processamento</td>
                        <td>
                            <a href=""><button class="btn btn-mini">X</button></a>
                            <a href=""><button class="btn btn-mini">detalhes</button></a>
                        </td>
                    </tr>

                </tbody>

            </table>
            <div class="span12">
                <div class="span5"></div>    
                <div class="span4">
                    <a href="#myModal" data-toggle="modal" class="btn btn-large">Adcionar outra solicitação</a>
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
                            <option>Pitoco Junior</option>
                        </select>
                    </div>
                </div>
                
                <fieldset>
                    <legend>Informações da origem</legend>
                    <div class="control-group">
                        <label class="control-label" for="inputEstadoOrigem">Estado de origem:</label>
                        <div class="controls">
                            <select name="estadoOrigem">
                                <option>oi</option>
                                
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="inputCidadeOrigem">Cidade de origem:</label>
                        <div class="controls">
                            <select name="cidadeOrigem">
                                <option>oi</option>
                                
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
                            <select name="estadoRetorno">
                                <option>oi</option>
                              
                            </select>
                        </div>
                    </div>
                    
                    <div class="control-group">
                        <label class="control-label" for="inputCidadeOrigem">Cidade:</label>
                        <div class="controls">
                            <select name="cidadeRetorno">
                                <option></option>
                                
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
                
            </form>
            <br/>
            
        </div>
        <br/>
        
        <div id="myModal"  class="modal hide fade">
            <table id="tabela1" class="table table-bordered">
                <thead>
                    <tr>
                        <td>CD Solicitação</td>
                        <td>Data Saida</td>
                        <td>Origem</td>
                        <td>Destino</td>
                        <td>Status solicitação</td>
                        <td>Selecionar</td>
                    </tr>
                    </head>

                <tbody>

                    <tr>
                        <td id="codigo">0012</td>
                        <td>12/02/2012</td>
                        <td>Alegrete-RS</td>
                        <td>Bage-RS</td>
                        <td>Aguardando Processamento</td>
                        <td>
                            <a href=""><button class="btn btn-mini">X</button></a>
                            <a href=""><button class="btn btn-mini">detalhes</button></a>
                        </td>
                    </tr>

                </tbody>

            </table>
        </div>
    </body>
</html>
