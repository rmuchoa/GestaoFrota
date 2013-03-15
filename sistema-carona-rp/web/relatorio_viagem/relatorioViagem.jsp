<%-- 
    Document   : index
    Created on : 14/03/2013, 20:58:04
    Author     : Bruno
--%>

<%@page import="model.entity.Veiculo"%>
<%@page import="java.util.List"%>
<%@page import="controller.VeiculoController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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


        <h2 style="color: green;text-align: center" class="span12 well">Sistema de Caronas - Unipampa</h2>

        <div class="offset1 span10 offset1">
            <nav class="navbar">
                <ul class="breadcrumb">
                    <li>
                        <a href="../index.jsp">Página Inicial</a><span class="divider">/</span>
                    </li>
                    <li class="active">
                        <a href="#">Relatório de Viagem Realizada</a><span class="divider">/</span>                        
                    </li>                   
                </ul>
            </nav>
            <hr>

            <form action="index.jsp" method="POST" id="formularioViagem" class="form-horizontal well">

                <div class="control-group">
                    <label class="control-label" for="inputNome">Nome do Motorista</label>
                    <div class="controls">
                        <input type="text" id="placa" name="Nome" placeholder="Placa" title="Insira o nome do Motorista" required="true" autofocus>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"  for="inputVeiculo">Veiculo</label>
                    <div  class="controls">
                        <select id="veiculo" name="veiculo" title="Selecione o Veículo utilizado" required="true">
                            <%
                                VeiculoController veiculoController = new VeiculoController();
                                List<Veiculo> listaDeVeiculos;
                                listaDeVeiculos = veiculoController.listar();
                                for (int i = 0; i < listaDeVeiculos.size(); i++) {
                                    out.print("<option value='" + listaDeVeiculos.get(i).getId() + "'>" + listaDeVeiculos.get(i).getModelo() + listaDeVeiculos.get(i).getMarca() + "</option>");
                                }
                            %>

                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label" for="inputDestino">Destino</label>
                    <div class="controls">
                        <input type="text" name="destino" id="destino" placeholder="Destino" title="Insira o destino da viagem" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputDataSaida">Data de Saída</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="dataSaida" name="dataSaida" placeholder="12/12/2013" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputHorarioSaida">Hora de saída</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="horaSaida" name="horaSaida" placeholder="08:24" required="true">

                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputResponsavelViagem">Responsável pela Viagem</label>
                    <div class="controls">
                        <input type="text" name="responsavel" id="responsavel" placeholder="Responsável" title="Insira o nome da pessoa responsável pela viagem" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputQuilometragemSaida">Quilometragem do veículo na saída</label>
                    <div class="controls">
                        <input type="text" id="quilometragem_saida"  name="quilometragem_saida" placeholder="12.000 KM" title="Insira a quilometragem do veículo na saída" required="true">

                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputDataRetorno">Data do Retorno</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="data_retorno" name="data_retorno" placeholder="12/12/2013" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputHoraChegada">Hora de Chegada</label>
                    <div class="controls">
                        <input class="input-xxlarge" type="text" id="hora_chegada" name="hora_chegada" placeholder="08:24" required="true">

                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputQuilometragemRetorno">Quilometragem do veículo no retorno</label>
                    <div class="controls">
                        <input type="text" id="quilometragem_retorno"  name="quilometragem_retorno" placeholder="12.000 KM" title="Insira a quilometragem do veículo no retorno" required="true">

                    </div>
                </div>

                <fieldset>
                    <legend>Observações</legend>
                    <div class="control-group">
                        <div class="controls">
                            <textarea name="objetivo"  rows="4" style="width: 90%" >

                            </textarea>
                        </div>    
                    </div>    
                </fieldset>
                <hr>

                <p>
                    <a href="listaVeiculos.jsp" class="btn btn-info btn" title="Clique aqui para Retornar a Página Anterior!">&laquo; Voltar </a>

                    <button type="submit" class="btn btn-success btn" title="Clique aqui para Salvar o Relatório!">
                        <i class="icon-ok"></i> Salvar </button>
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

