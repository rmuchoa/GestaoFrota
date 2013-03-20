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
        new Autenticacao("/sistema-carona-rp/index.jsp").valida(session, response, new String[]{"OPERADOR", "AUTORIZADOR", "ADMINISTRADOR"});
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
                listaViagens();
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
                            <li class="active"><a href="/sistema-carona-rp/viagem/listaViagens.jsp"><i class="icon-globe"></i> Viagens</a></li>
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
                        <%                            }
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
                                Lista de Viagens
                            </li>
                        </ul>
                    </nav>
                    <hr>  

                    <div class="well">
                        <h3>Lista de Viagens</h3>
                        <hr>
                        <p>
                            Listagem de solicitações de viagens do sistema:
                        </p>
                        <br/>

                        <form id="formBuscaViagem" method="POST" class="form-horizontal">
                            <strong> Filtro da pesquisa:</strong>
                            <select id="pesquisa">
                                <option value="situacao_viagem" id="situacao">Situação</option>
                                <option value="cidade_origem" id="origem">Origem</option>
                                <option value="cidade_retorno" id="destino">Destino</option>
                            </select>

                            <strong> Valor:</strong> <input id="valor_pesquisa" class="input-large" value="" type="text">
                            <button type="submit" class="btn btn-success" title="Clique aqui para pesquisar viagens!">
                                <i class="icon-ok"></i> Pesquisar
                            </button>

                        </form>
                        <br/>
                        <div class="well">
                            <form id="formTabela" action="listaSolicitacoes.jsp" method="POST">
                                <div id="conteudoTable">

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
        <div style="display: none" title="Justificativa de rejeição de viagem" id="modalJustificativa">
            <form class="form-horizontal">
                <label>Insira a justificativa</label>
                <textarea id="justificativa" name="observacoes"  rows="4" style="width: 90%" ></textarea>
            </form>
        </div> 
        <div style="display: none" title="Detalhe Viagem" id="detalheViagem"></div>            
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
