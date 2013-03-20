<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>


<%@page import="model.entity.Usuario"%>
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

    Usuario login = null;

    if (session.getAttribute("usuario") != null) {

        login = (Usuario) session.getAttribute("usuario");
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
                            <li class="active"><a href="/sistema-carona-rp/viagem/listaSolicitacoes.jsp"><i class="icon-calendar"></i> Reservas</a></li>
                            <%           }
                                if (login.getTipoUsuario().getId() == 5 || login.getTipoUsuario().getId() == 4) {
                            %>      
                            <li class="divider-vertical"></li>
                            <li><a href="/sistema-carona-rp/viagem/formularioViagem.jsp"><i class="icon-road"></i> Relatorio Viagem</a></li>
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
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

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
