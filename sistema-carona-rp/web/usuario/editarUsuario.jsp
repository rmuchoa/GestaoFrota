<%-- 
    Document   : editarVeiculo
    Created on : 30/01/2013, 23:52:27
    Author     : renanmarceluchoa
--%>

<%@page import="util.Autenticacao"%>
<%@page import="model.entity.Estado"%>
<%@page import="controller.EstadoController"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="controller.UsuarioController"%>
<%@page import="controller.TipoUsuarioController"%>
<%@page import="controller.CidadeController"%>
<%@page import="model.entity.Usuario"%>
<%@page import="model.entity.TipoUsuario"%>
<%@page import="model.entity.Cidade"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %> 
<%@ page import="javax.servlet.http.*" %> 
<!DOCTYPE html>

<%
    Usuario login = null;

    if (session.getAttribute("usuario") != null) {

        login = (Usuario) session.getAttribute("usuario");
        new Autenticacao("/sistema-carona-rp/index.jsp").valida(session, response, new String[]{"ADMINISTRADOR"});
        if (request.getMethod().equalsIgnoreCase("post")) {
            UsuarioController usuarioController = new UsuarioController();
            usuarioController.alterar(request);
            response.sendRedirect("listaUsuarios.jsp");
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
        <!--        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.maskedinput-1.1.4.pack.js"></script>-->
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.js"></script>
        <!--        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.min.js"></script>-->
        <script type="text/javascript" src="/sistema-carona-rp/validadores/Validators.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery-ui.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.ui.datepicker-pt-BR.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/perifer-timePicker-b5195df/jquery.timePicker.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/perifer-timePicker-b5195df/timePicker.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/pick/jquery-ui.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        <script type="text/javascript">
            $(document).ready(function() {
                $("#validade").datepicker($.datepicker.regional['pt-BR']);
                validaFormularioUsuario();
                $("#estado").change(function() {
                    $.ajax({
                        url: '../ajax/cidades.jsp',
                        dataType: 'html',
                        data: {estado: $('#estado').val()},
                        type: 'POST',
                        success: function(data) {
                            $('#cidade').html(data);
                        }
                    });
                });
            });
        </script>

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
                            <li class="active"><a href="/sistema-carona-rp/usuario/listaUsuarios.jsp"><i class="icon-user"></i> Usuarios</a></li>

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

        <h3 style="color: green;text-align: center"  class="span12 well">Sistema de Caronas Unipampa</h3>

        <div class="offset1 span10 offset1">
            <nav class="navbar">
                <ul class="breadcrumb">
                    <li>
                        <a href="../index.jsp">Página Inicial</a><span class="divider">/</span>
                    </li>
                    <li>
                        <a href="listaUsuarios.jsp">Lista de Usuários</a><span class="divider">/</span>                        
                    </li>                   
                    <li class="active">
                        Editar Usuário
                    </li>
                </ul>
            </nav>
            <hr>

            <%
                UsuarioController usuarioController = new UsuarioController();
                Usuario usuario = usuarioController.buscarPorId(Integer.parseInt(request.getParameter("id")));
            %>
            <form action="editarUsuario.jsp?id=<%out.println(request.getParameter("id"));%>" method="POST" id="formularioUsuario" class="form-horizontal well">
                <h3>Alteração dos dados do usuário</h3> 
                <hr />
                <input  style="display:none" name="id" value="<% out.print(usuario.getId());%>">
                <div class="control-group">
                    <label class="control-label" for="inputId">Id</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getId());%>" id="id" name="id" placeholder="Id">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputNome">Nome</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getNome());%>" id="nome" name="nome" placeholder="Nome">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputLogin">Login</label>
                    <div class="controls">
                        <input type="text"  value="<%out.println(usuario.getLogin());%>" id="login" name="login" placeholder="Login">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputSenha">Senha</label>
                    <div class="controls">
                        <input type="password" value="<%out.println(usuario.getSenha());%>" name="senha" id="senha" placeholder="Senha">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"  for="inputTipo">Tipo</label>
                    <div  class="controls">
                        <select id="tipo" name="tipo_usuario">
                            <%
                                TipoUsuarioController tipoUsuarioController = new TipoUsuarioController();
                                List<TipoUsuario> listaTiposUsuario = tipoUsuarioController.listar();
                                for (int i = 0; i < listaTiposUsuario.size(); i++) {
                                    if (usuario.getTipoUsuario().getId().equals(listaTiposUsuario.get(i).getId())) {
                                        out.print("<option value='" + listaTiposUsuario.get(i).getId() + "' selected='true'>" + listaTiposUsuario.get(i).getDescricao() + "</option>");
                                    } else {
                                        out.print("<option value='" + listaTiposUsuario.get(i).getId() + "'>" + listaTiposUsuario.get(i).getDescricao() + "</option>");
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label" for="inputEmail">Email</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getEmail());%>" name="email" id="email" placeholder="Email">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputTelefone">telefone</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getTelefone());%>" name="telefone" id="telefone" placeholder="Telefone">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCelular">Celular</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getCelular());%>" name="celular" id="celular" placeholder="Celular">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputRg">RG</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getRg());%>" id="rg"  name="rg" placeholder="RG">

                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputSiape">Siape</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getSiape());%>" name="siape" id="siape" placeholder="Siape">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCnh">Habilitação</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getNumeroCnh());%>" name="numero_cnh" id="cnh" placeholder="Habilitação">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputValidade">Validade</label>
                    <div class="controls">
                        <input id="validade" type="text" value="<%out.println(new SimpleDateFormat("dd/MM/yyyy").format(usuario.getValidadeCnh()));%>" name="validade_cnh" id="validade" placeholder="Validade">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCategoria">Categoria</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getCategoriaCnh());%>" name="categoria_cnh" id="categoria" placeholder="Categoria">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputRua">Rua</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getRua());%>" name="rua" id="rua" placeholder="Rua">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputNumero">Numero</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getNumero());%>" name="numero" id="numero" placeholder="Numero">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputComplemento">Complemento</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getComplemento());%>" name="complemento" id="complemento" placeholder="Complemento">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCep">CEP</label>
                    <div class="controls">
                        <input type="text" value="<%out.println(usuario.getCep());%>" name="cep" id="cep" placeholder="CEP">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"  for="inputEstado">Estado</label>
                    <div  class="controls">
                        <select id="estado" name="estado">
                            <option></option>
                            <%
                                EstadoController estadoController = new EstadoController();
                                List<Estado> listaEstados = estadoController.listar();
                                for (Estado estado : listaEstados) {
                                    if (usuario.getCidade().getEstado().getId().equals(estado.getId())) {
                                        out.print("<option value='" + estado.getId() + "' selected='true'>" + estado.getSigla() + "</option>");
                                    } else {
                                        out.print("<option value='" + estado.getId() + "'>" + estado.getSigla() + "</option>");
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label"  for="inputCidade">Cidade</label>
                    <div  class="controls">
                        <select id="cidade" name="cidade">
                            <%
                                CidadeController cidadeController = new CidadeController();
                                List<Cidade> listaCidades = cidadeController.listarPorEstado(usuario.getCidade().getEstado());
                                for (Cidade cidade : listaCidades) {
                                    if (usuario.getCidade().getId().equals(cidade.getId())) {
                                        out.print("<option value='" + cidade.getId() + "' selected='true'>" + cidade.getNome() + "</option>");
                                    } else {
                                        out.print("<option value='" + cidade.getId() + "'>" + cidade.getNome() + "</option>");
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <div class="controls">
                        <input type="submit" id="enviar" value="Salvar" class="btn">
                        <div class="btn"><a href="listaUsuarios.jsp">Cancelar</a></div>
                    </div>
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
