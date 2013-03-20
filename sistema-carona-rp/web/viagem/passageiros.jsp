<%-- 
    Document   : passageiros
    Created on : 04/02/2013, 10:14:10
    Author     : renanmarceluchoa
--%>

<%@page import="model.entity.Usuario"%>
<%@page import="util.Autenticacao"%>
<%@page import="controller.SolicitacaoViagemController"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="model.entity.Passageiro"%>
<%@page import="java.util.List"%>
<%@page import="controller.PassageiroController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap-responsive.css">
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/jquery-1.8.0.min.js"></script>
        <script type="text/javas;cript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery-1.9.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.maskedinput-1.1.4.pack.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/Validators.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">

        <script type="text/javascript">
            $(document).ready(function() {
                validaFormularioPassageiros();
            });
        </script>

        <title>Sistema Caronas Unipampa</title>
    </head>
    <body>

        <%

            Usuario login = null;

            if (session.getAttribute("usuario") != null) {

                login = (Usuario) session.getAttribute("usuario");
                new Autenticacao("/sistema-carona-rp/index.jsp").valida(session, response, new String[]{"USUARIO", "OPERADOR", "AUTORIZADOR", "ADMINISTRADOR"});
                if (request.getParameter("avancar") != null) {
                    request.setAttribute("action", "list");
                }

                if (request.getAttribute("action") == null) {

                    if (request.getParameter("add") != null) {

                        SolicitacaoViagemController solicitacaoViagemController = new SolicitacaoViagemController();
                        SolicitacaoViagem solicitacaoViagem = solicitacaoViagemController.buscarPorId(Integer.parseInt(request.getParameter("solicitacao")));
                        request.setAttribute("solicitacao", solicitacaoViagem);
                        request.setAttribute("action", "list");
                        PassageiroController passageiroController = new PassageiroController();
                        passageiroController.adicionarPassageiro(request);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("passageiros.jsp");
                        dispatcher.forward(request, response);

                    }

                } else if (request.getAttribute("action").equals("list")) {

                    request.setAttribute("action", "add");

                }

            } else {

                response.sendRedirect("login.jsp");

            }

        %>

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
                            <li><a href="/sistema-carona-rp/viagem/formularioViagem.jsp"><i class="icon-road"></i> Relatorio Viagem</a></li>
                            <%           }
                                if (login.getTipoUsuario().getId() >= 1 && login.getTipoUsuario().getId() <= 4) {
                            %>
                            <li class="divider-vertical"></li>
                            <li class="active"><a href="/sistema-carona-rp/viagem/solicitar.jsp"><i class="icon-envelope"></i> Solicitação</a></li>
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

        <h3 style="color: green;text-align: center"  class="span12 well">Sistema de Caronas Unipampa</h3>

        <div class="offset2 span8 offset2 well">
            <div><h3 class="well">Cadastro de passageiros</h3></div>
            <form action="passageiros.jsp" id="cadastroPassageiros" method="POST" class="form-actions">

                <input type="hidden" name="solicitacao" value="<%= ((SolicitacaoViagem) request.getAttribute("solicitacao")).getId()%>" />

                <div class="control-group">
                    <label class="control-label" for="inputNome">Nome do Passageiro:</label>
                    <div class="controls">
                        <input class="input-large" type="text" id="nome" name="nome" placeholder="Digite o nome do passageiro">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputRg">Rg do Passageiro:</label>
                    <div class="controls">
                        <input class="input-large" type="text" id="rg" name="rg" placeholder="Digite o rg do passageiro">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputEmail">Email do Passageiro:</label>
                    <div class="controls">
                        <input class="input-large" type="text" id="email" name="email" placeholder="Digite o email do passageiro">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputEndereco">Endereço do Passageiro:</label>
                    <div class="controls">
                        <input class="input-large" type="text" id="endereco" name="endereco" placeholder="Digite o endereço do passageiro">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputServidor">É Servidor da Unipampa:</label>
                    <div class="controls">
                        <input id="sim" name="servidor" value="true" type="radio" /><label for="sim"> Sim</label> 
                        <input id="nao" name="servidor" value="false" type="radio" /><label for="nao" CHECKED> Não</label> 
                    </div>
                </div>
                <div class="span5">  
                    <input type="submit" name="add" value="Adicionar Passageiro" class="btn btn-success btn-large"
                </div>

            </form>
        </div>
    </div>

    <div class="well offset2 span9 offset2">
        <div><h3 class="well">Listagem de passageiros</h3></div>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>RG</th>
                    <th>Email</th>
                    <th>Endereço</th>
                    <th>Servidor</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <%
                PassageiroController passageiroController = new PassageiroController();
                List<Passageiro> passageiros = passageiroController.buscarPorSolicitacaoId(((SolicitacaoViagem) request.getAttribute("solicitacao")).getId());
                for (Passageiro p : passageiros) {
            %>
            <tbody>
                <tr>
                    <td><%= p.getNome()%></td>
                    <td><%= p.getRg()%></td>
                    <td><%= p.getEmail()%></td>
                    <td><%= p.getEndereco()%></td>
                    <td><%= p.isServidor() ? "Sim" : "Não"%></td>
                    <td><a href="" value="Editar" /><a href="" value="Remover" /></td>
                </tr>
            </tbody>
            <%
                }
            %>
        </table>
    </div>

</body>
</html>
