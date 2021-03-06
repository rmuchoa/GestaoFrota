<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>

<%@page import="model.entity.Usuario"%>
<%@page import="util.Autenticacao"%>
<%@page import="model.dao.VeiculoOpcionalVeiculoDAO"%>
<%@page import="model.entity.OpcionalVeiculo"%>
<%@page import="model.dao.OpcionalVeiculoDAO"%>
<%@page import="model.dao.VeiculoDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.TipoVeiculo"%>
<%@page import="controller.TipoVeiculoController"%>
<%@page import="controller.VeiculoController"%>
<%@page import="model.entity.Veiculo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %> 
<%@ page import="javax.servlet.http.*" %> 
<!DOCTYPE html>

<%

    Usuario login = null;

    if (session.getAttribute("usuario") != null) {

        login = (Usuario) session.getAttribute("usuario");
        new Autenticacao("/sistema-carona-rp/index.jsp").valida(session, response, new String[]{"OPERADOR", "ADMINISTRADOR"});

        if (request.getMethod().equalsIgnoreCase("post")) {
            VeiculoController veiculoController = new VeiculoController();
            veiculoController.alterarVeiculo(request);
            response.sendRedirect("listaVeiculos.jsp");
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
        <script type="text/javas;cript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery-1.9.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/Validators.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">

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
                            <li class="active"><a href="/sistema-carona-rp/veiculo/listaVeiculos.jsp"><i class="icon-tags"></i> Veiculos</a></li>
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

            <script type="text/javascript">
                $(document).ready(function() {
                    validaFormularioVeiculo()
                });
            </script>

            <div id="header">
                <h2 style="color: green;text-align: center" class="span12 well">Sistema de Caronas - Unipampa</h2>
            </div>


            <div id="main">
                <div class="offset1 span10 offset1">
                    <nav class="navbar">
                        <ul class="breadcrumb">
                            <li>
                                <a href="../index.jsp">Página Inicial</a><span class="divider">/</span>
                            </li>
                            <li>
                                <a href="listaVeiculos.jsp">Lista de Veículos</a><span class="divider">/</span>                        
                            </li>                   
                            <li class="active">
                                Editar Veículo
                            </li>
                        </ul>
                    </nav>
                    <hr>

                    <%
                        VeiculoDAO veiculoDAO = new VeiculoDAO();
                        Veiculo veiculo = veiculoDAO.getVeiculoPorId(Integer.parseInt(request.getParameter("id")));
                    %>
                    <form id="formularioVeiculo" action="editarVeiculo.jsp?id=<%out.println(request.getParameter("id"));%>" method="POST" class="form-horizontal well">

                        <h3>Alteração dos dados do Veículo</h3> 
                        <hr>

                        <input  style="display:none" name="id" value="<% out.print(veiculo.getId());%>">
                        <div class="control-group">
                            <label class="control-label" for="inputPlaca">Placa</label>
                            <div class="controls">
                                <input type="text" value="<%out.println(veiculo.getPlaca());%>" id="placa" name="placa" placeholder="Placa" title="Insira a Placa" required="true">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="inputRenavan">Renavan</label>
                            <div class="controls">
                                <input type="text"  value="<%out.println(veiculo.getRenavam());%>" id="renavan" name="renavan" placeholder="Renavan" title="Insira o Renavan" required="true">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="inputMarca">Marca</label>
                            <div class="controls">
                                <input type="text" name="marca" value="<%out.println(veiculo.getMarca());%>"  id="marca" placeholder="Marca" title="Insira a Marca" required="true">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="inputModelo">Modelo</label>
                            <div class="controls">
                                <input type="text" name="modelo" value="<%out.println(veiculo.getModelo());%>"  id="modelo" placeholder="Modelo" title="Insira o Modelo" required="true">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="inputCor">Cor</label>
                            <div class="controls">
                                <input type="text" name="cor" value="<%out.println(veiculo.getCor());%>" id="cor" placeholder="Cor" title="Insira a Cor" required="true">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="inputCor">Ano</label>
                            <div class="controls">
                                <input type="text" name="ano" value="<%out.println(veiculo.getAno());%>" id="ano" placeholder="Ano" title="Insira o Ano" required="true">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label"  for="inputCor">Tipo</label>
                            <div  class="controls">
                                <select name="tipo_veiculo" title="Selecione o tipo do Veículo">
                                    <%
                                        TipoVeiculoController tipoVeiculoController = new TipoVeiculoController();
                                        List<TipoVeiculo> listaDeTipos;
                                        listaDeTipos = tipoVeiculoController.listarTodosTiposVeiculos();
                                        for (int i = 0; i < listaDeTipos.size(); i++) {
                                            if (veiculo.getTipoVeiculo().getDescricao().equals(listaDeTipos.get(i).getDescricao())) {
                                                out.print("<option value='" + listaDeTipos.get(i).getId() + "' selected = 'true'>" + listaDeTipos.get(i).getDescricao() + "</option>");
                                            } else {
                                                out.print("<option value='" + listaDeTipos.get(i).getId() + "'>" + listaDeTipos.get(i).getDescricao() + "</option>");
                                            }
                                        }
                                    %>

                                </select>
                            </div>
                        </div> 

                        <div class="control-group">
                            <label class="control-label"  for="inputPassageiros">Capacidade de passageiros</label>
                            <div class="controls">
                                <input type="text" value="<%out.println(veiculo.getCapacidadePassageiros());%>" id="capacidade_passageiros"  name="capacidade_passageiros" placeholder="Capacidade de passageiros" title="Insira a Capacidade de Passageiros" required="true">
                            </div>
                        </div>


                        <div class="control-group">
                            <label class="control-label" for="inputCarga">Capacidade de carga(Kg)</label>
                            <div class="controls">
                                <input type="text" value="<%out.println(veiculo.getCapacidadeCarga());%>" name="capacidade_carga" id="capacidade_carga" placeholder="Capacidade carga" title="Insira a Capacidade de Carga" required="true">
                            </div>
                        </div>

                        <div class="control-group">
                            <label class="control-label" for="itensOpc">Itens Opcionais</label>
                            <div class="controls">
                                <%
                                    List<OpcionalVeiculo> lista;
                                    List<Integer> listaOpcionaisSelecionados = new VeiculoOpcionalVeiculoDAO().getPorIdVeiculo(veiculo.getId());
                                    OpcionalVeiculoDAO opcionalVeiculoDAO = new OpcionalVeiculoDAO();
                                    lista = opcionalVeiculoDAO.getTodosOpcionais();
                                    int status = 0;
                                    for (int i = 0; i < lista.size(); i++) {
                                        status = 0;
                                        for (int j = 0; j < listaOpcionaisSelecionados.size(); j++) {
                                            if (lista.get(i).getId() == listaOpcionaisSelecionados.get(j)) {
                                                out.println("<label class='checkbox'><input type='checkbox' name='" + lista.get(i).getId() + "' value=' " + lista.get(i).getId() + "' CHECKED>" + lista.get(i).getDescricao() + "</label>");
                                                status = 1;
                                            }
                                        }
                                        if (status == 0) {
                                            out.println("<label class='checkbox'><input type='checkbox' name='" + lista.get(i).getId() + "' value=' " + lista.get(i).getId() + "' >" + lista.get(i).getDescricao() + "</label>");
                                        }
                                    }
                                %>
                            </div>
                        </div>   
                        <hr>

                        <p>
                            <a href="listaVeiculos.jsp" class="btn btn-info btn" title="Clique aqui para Retornar a Página Anterior!">&laquo; Voltar </a>

                            <button type="submit" class="btn btn-success btn" title="Clique aqui para Salvar as Alterações nos Dados do Veículo!">
                                <i class="icon-ok"></i> Salvar Alterações </button>
                        </p>
                    </form>
                </div>
            </div>


        </div>

        <div id="footer" class="well">
            <hr>
            <footer>
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
