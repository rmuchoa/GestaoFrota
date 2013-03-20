<%-- 
    Document   : index
    Created on : 14/03/2013, 20:58:04
    Author     : Bruno
--%>

<%@page import="util.Autenticacao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.omg.PortableInterceptor.SYSTEM_EXCEPTION"%>
<%@page import="model.entity.Viagem"%>
<%@page import="controller.ViagemController"%>
<%@page import="model.entity.Usuario"%>
<%@page import="controller.UsuarioController"%>
<%@page import="model.entity.Veiculo"%>
<%@page import="java.util.List"%>
<%@page import="controller.VeiculoController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%

    Usuario login = null;

    if (session.getAttribute("usuario") != null) {

        login = (Usuario) session.getAttribute("usuario");
        new Autenticacao("/sistema-carona-rp/index.jsp").valida(session, response, new String[]{"MOTORISTA", "ADMINISTRADOR"});

        if (request.getMethod().equalsIgnoreCase("post")) {
            ViagemController viagemController = new ViagemController();
            viagemController.finalizarViagem(request);
            response.sendRedirect("/sistema-carona-rp/index.jsp");
        }

    } else {

        response.sendRedirect("login.jsp");

    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap-responsive.css">
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/jquery-1.8.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery-1.9.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery-ui.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.ui.datepicker-pt-BR.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/perifer-timePicker-b5195df/jquery.timePicker.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/Validators.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/perifer-timePicker-b5195df/timePicker.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/pick/jquery-ui.css">
        <script>
            $(document).ready(function() {
                $("#data_saida").datepicker($.datepicker.regional['pt-BR']);
                $("#data_retorno").datepicker($.datepicker.regional['pt-BR']);
                $("#hora_saida").timePicker();
                $("#hora_chegada").timePicker();
                
                $("#viagem").change(function() {
                    $.ajax({
                        url: '/sistema-carona-rp/ajax/dadosViagem.jsp',
                        dataType: 'html',
                        data: {viagem: $('#viagem').val()},
                        type: 'POST',
                        success: function(data) {
                            $('#dados_viagem').html(data)
                        }
                    });
                });
            });
        </script>
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body>

        <div class="navbar nav">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="/sistema-carona-rp/index.jsp">Sistema Caronas</a>

                    <div class="nav-collapse collapse">
                        <ul class="nav">
                            <li class="divider-vertical"></li>
                            <li><a href="/sistema-carona-rp/index.jsp"><i class="icon-home"></i> Home</a></li>
                            <%
                                if (login != null) {
                                    if (login.getTipoUsuario().getId() == 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="/sistema-carona-rp/usuario/listaUsuarios.jsp"><i class="icon-user"></i> Usuarios</a></li>

                            <%           }
                                if (login.getTipoUsuario().getId() == 2 || login.getTipoUsuario().getId() == 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="/sistema-carona-rp/veiculo/listaVeiculos.jsp"><i class="icon-tags"></i> Veiculos</a></li>
                            <%           }
                                if (login.getTipoUsuario().getId() == 2 || login.getTipoUsuario().getId() == 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="/sistema-carona-rp/viagem/listaSolicitacoes.jsp"><i class="icon-calendar"></i> Reservas</a></li>
                            <%           }
                                if (login.getTipoUsuario().getId() >= 2 && login.getTipoUsuario().getId() <= 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="/sistema-carona-rp/viagem/listaViagens.jsp"><i class="icon-globe"></i> Viagens</a></li>
                            <%           }
                                if (login.getTipoUsuario().getId() == 5 || login.getTipoUsuario().getId() == 4) {
                            %>      
                            <li class="divider-vertical"></li>
                            <li class="active"><a href="/sistema-carona-rp/viagem/formularioViagem.jsp"><i class="icon-road"></i> Relatorio Viagem</a></li>
                            <%           }
                                if (login.getTipoUsuario().getId() >= 1 && login.getTipoUsuario().getId() <= 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li><a href="/sistema-carona-rp/viagem/solicitar.jsp"><i class="icon-envelope"></i> Solicitação</a></li>
                            <%           }
                                }
                            %>
                        </ul>
                        <%
                            if (login != null) {
                        %>
                        <div class="pull-right">
                            <ul class="nav pull-right">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                        <i class="icon-user"></i> Bem vindo, <%= login.getNome()%> <span class="caret"></span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a href="/sistema-carona-rp/login.jsp"><i class="icon-off"></i> Logout</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <%
                        } else {
                        %>
                        <div class="pull-right">
                            <ul class="nav pull-right">
                                <li class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" href="/sistema-carona-rp/login.jsp">
                                        <i class="icon-user"></i> Login
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <%                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

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

            <form action="formularioViagem.jsp" method="POST" id="formularioViagem" class="form-horizontal well">

                <div class="control-group">
                    <label class="control-label" for="inputViagem">Viagem Realizada</label>
                    <div class="controls">
                        <select id="viagem" name="viagem" style="width: 80%" placeholder="Viagem Realizada" title="Insira a viagem que foi realizada" required="true">
                            <option value="">Selecione a Viagem Realizada</option>
                            <%
                                ViagemController viagemController = new ViagemController();
                                List<Viagem> viagens = viagemController.listarViagensMotorista(login);
                                for (int i = 0; i < viagens.size(); i++) {
                                    out.print("<option value='" + viagens.get(i).getId() + "'> Cidade de Origem: " + viagens.get(i).getCidadeOrigem().getNome()
                                            + " | Destino: " + viagens.get(i).getCidadeRetorno().getNome()
                                            + " | Data Saída: " + new SimpleDateFormat("dd/MM/yyyy").format(viagens.get(i).getDataSaida())
                                            + " | Data Retorno: " + new SimpleDateFormat("dd/MM/yyyy").format(viagens.get(i).getDataRetorno())
                                            + " </option>");
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="container-fluid well">     
                    <div id="dados_viagem" class="row-fluid">
                        <div class="span6">Motorista:</div>  
                        <div class="span6">Veiculo:</div>  
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label" for="inputDataSaida">Data de Saída</label>
                    <div class="controls">
                        <input type="text" id="data_saida" name="dataSaida" placeholder="12/12/2013" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputHorarioSaida">Hora de saída</label>
                    <div class="controls">
                        <input  type="text" id="hora_saida" name="horaSaida" placeholder="08:24" required="true">

                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputQuilometragemSaida">Quilometragem do veículo na saída</label>
                    <div class="controls">
                        <input type="text" id="quilometragem_saida"  name="quilometragemSaida" placeholder="12.000" title="Insira a quilometragem do veículo na saída" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputDataRetorno">Data do Retorno</label>
                    <div class="controls">
                        <input type="text" id="data_retorno" name="dataRetorno" placeholder="12/12/2013" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputHoraChegada">Hora de Chegada</label>
                    <div class="controls">
                        <input type="text" id="hora_chegada" name="horaChegada" placeholder="08:24" required="true">

                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputQuilometragemRetorno">Quilometragem do veículo no retorno</label>
                    <div class="controls">
                        <input type="text" id="quilometragem_retorno"  name="quilometragemRetorno" placeholder="12.000" title="Insira a quilometragem do veículo no retorno" required="true">
                    </div>
                </div>

                <fieldset>
                    <legend>Observações</legend>
                    <div class="control-group">
                        <div class="controls">
                            <textarea name="observacoes"  rows="4" style="width: 90%" >

                            </textarea>
                        </div>    
                    </div>    
                </fieldset>
                <hr>

                <p>
                    <a href="#" class="btn btn-info btn" title="Clique aqui para Retornar a Página Anterior!">&laquo; Voltar </a>

                    <button type="submit" class="btn btn-success btn" title="Clique aqui para Salvar o Formulário!">
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

