<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>


<%@page import="util.Autenticacao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="java.util.List"%>
<%@page import="controller.SolicitacaoViagemController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.*" %> 
<%@page import="javax.servlet.http.*" %> 
<!DOCTYPE html>

<%

    if (session.getAttribute("usuario") != null) {

        new Autenticacao("/sistema-carona-rp/index.jsp").valida(session, response, new String[]{"OPERADOR","ADMINISTRADOR"});
        if (request.getMethod().equalsIgnoreCase("POST")) {
            
            if (request.getParameter("criarViagem") != null) {
                SolicitacaoViagemController solicitacaoViagemController = new SolicitacaoViagemController();
                List<SolicitacaoViagem> solicitacoes = solicitacaoViagemController.listar();
                List<SolicitacaoViagem> selecionadas = new ArrayList<SolicitacaoViagem>();

                for (SolicitacaoViagem solicitacao : solicitacoes) {
                    if (request.getParameter("solicitacao" + solicitacao.getId()) != null) {
                        selecionadas.add(solicitacao);
                    }
                }

                request.setAttribute("solicitacoes", selecionadas);
                RequestDispatcher dispatcher = request.getRequestDispatcher("criacaoViagem.jsp");
                dispatcher.forward(request, response);
            }
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
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.min.js"></script>

        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/pick/jquery-ui.css">
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery-ui.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.ui.datepicker-pt-BR.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/ajax/Viagem.js"></script>

        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        <script>
            $(document).ready(function() {
                $("#data_inicial").datepicker();
                $("#data_inicial").datepicker($.datepicker.regional['pt-BR']);
                $("#data_final").datepicker();
                $("#data_final").datepicker($.datepicker.regional['pt-BR']);
            });
        </script>
        <title>Sistema de Caronas Unipampa</title>
    </head>    
    <script type="text/javascript">
        $(document).ready(function() {
            $('#formFiltro').submit(function() {
                var dataInicial = $('#data_inicial').val();
                var dataFinal = $('#data_final').val();
                preencheTabela(dataInicial, dataFinal);
                return false;
            });
        });
    </script>
    <body>
        <div id="wrap">
            <div id="header">
                <h2 id="cabecalho" class="span12 well">Sistema de Caronas - Unipampa</h2>
            </div>
            
            <div id="main">
                <div class="offset1 span10 offset1">
                    <nav class="navbar">
                        <ul class="breadcrumb">
                            <li>
                                <a href="../index.jsp">Página Inicial</a><span class="divider">/</span>
                            </li>

                            <li>
                                <a href="index.jsp">Área de Viagens</a><span class="divider">/</span>
                            </li>

                            <li class="active">
                                Lista de Solicitações
                            </li>
                        </ul>
                    </nav>
                    <hr>  

                    <div class="well">
                        <h3>Área de Viagens</h3>
                        <hr>
                        <p>
                            Listagem de solicitações de viagens do sistema:
                        </p>
                        <br/>

                        <form id="formFiltro" class="form-horizontal">
                            <strong> Data Inicial:</strong> <input id="data_inicial" class="input-small" value="" type="text" title="Clique aqui para Selecionar uma Data." placeholder="01/03/2013">
                            <strong> Data Final:</strong> <input id="data_final" class="input-small" value="" type="text" title="Clique aqui para Selecionar uma Data." placeholder="07/03/2013">
                            <button type="submit" class="btn btn-success" title="Clique aqui para realizar a Filtragem!">
                                <i class="icon-calendar"></i> Filtrar
                            </button>
                        </form>
                        <br/>
                        <div class="well">
                            <form id="formTabela" action="listaSolicitacoes.jsp" method="POST">
                                <div id="conteudoForm">

                                </div>
                            </form>
                        </div>

                        <hr>
                        <br />
                        <div>
                            <a href="../index.jsp" class="btn btn-info btn" title="Clique aqui para Retornar a Página Anterior!">&laquo; Voltar </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="footer" class="well">
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
