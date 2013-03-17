<%-- 
    Document   : cadastrarVeiculo
    Created on : 30/01/2013, 23:52:39
    Author     : renanmarceluchoa
--%>

<%@page import="util.Autenticacao"%>
<%@page import="controller.EstadoController"%>
<%@page import="model.entity.Estado"%>
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
    if (session.getAttribute("usuario") != null) {

        new Autenticacao("/sistema-carona-rp/index.jsp").valida(session, response, new String[]{"ADMINISTRADOR"});
        
        if (request.getMethod().equalsIgnoreCase("post")) {
            UsuarioController usuarioController = new UsuarioController();
            usuarioController.inserir(request);
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
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery-1.9.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/Validators.js"></script>

        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery-ui.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.ui.datepicker-pt-BR.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/perifer-timePicker-b5195df/jquery.timePicker.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/perifer-timePicker-b5195df/jquery.timePicker.min.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/perifer-timePicker-b5195df/timePicker.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/pick/jquery-ui.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        <script type="text/javascript">
            $(document).ready(function() {
                $("#validade").datepicker($.datepicker.regional['pt-BR']);
                validaFormularioUsuario();
                $("#estado").change(function() {
                    $.ajax({
                        url: '/sistema-carona-rp/ajax/cidades.jsp',
                        dataType: 'html',
                        data: {estado: $('#estado').val()},
                        type: 'POST',
                        success: function(data) {
                            $('#cidade').html(data)
                        }
                    });
                });
            });
        </script>


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
                    <li>
                        <a href="listaUsuarios.jsp">Lista de Usuários</a><span class="divider">/</span>                        
                    </li>                   
                    <li class="active">
                        Cadastro de Usuário
                    </li>
                </ul>
            </nav>
            <hr>           

            <form action="cadastrarUsuario.jsp" method="POST" id="formularioUsuario" class="form-horizontal well">

                <div class="control-group">
                    <label class="control-label" for="inputNome">Nome</label>
                    <div class="controls">
                        <input type="text" id="nome" name="nome" placeholder="Digite o seu nome" title="Insira o Nome do Usuário" required="true" autofocus>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputLogin">Login</label>
                    <div class="controls">
                        <input type="text"  id="login" name="login" placeholder="Informa um login" title="Insira o Login do Usuário" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputSenha">Senha</label>
                    <div class="controls">
                        <input type="password" name="senha" id="senha" placeholder="Informe uma senha" title="Insira a Senha do Usuário" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"  for="inputTipo">Tipo</label>
                    <div  class="controls">
                        <select id="tipo" name="tipo_usuario" title="Selecione o Tipo do Usuário" required="true">
                            <%
                                TipoUsuarioController tipoVeiculoController = new TipoUsuarioController();
                                List<TipoUsuario> listaTiposUsuario = tipoVeiculoController.listar();
                                for (int i = 0; i < listaTiposUsuario.size(); i++) {
                                    out.print("<option value='" + listaTiposUsuario.get(i).getId() + "'>" + listaTiposUsuario.get(i).getDescricao() + "</option>");
                                }
                            %>

                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label" for="inputEmail">Email</label>
                    <div class="controls">
                        <input type="email" name="email" id="email" placeholder="Informe um e-mail" title="Insira o E-mail do Usuário" required="true">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputTelefone">telefone</label>
                    <div class="controls">
                        <input type="text" name="telefone" id="telefone" placeholder="5532003200" title="Insira o Telefône do Usuário">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCelular">Celular</label>
                    <div class="controls">
                        <input type="text" name="celular" id="celular" placeholder="5581008100" title="Insira o Telefône Celular do Usuário">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputRg">RG</label>
                    <div class="controls">
                        <input type="text" id="rg"  name="rg" placeholder="Informe o seu rg" title="Insira o RG do Usuário" required="true">

                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputSiape">Siape</label>
                    <div class="controls">
                        <input type="text" name="siape" id="siape" placeholder="Informe seu número siape" title="Insira o SIAPE do Usuário">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCnh">Habilitação</label>
                    <div class="controls">
                        <input type="text" name="numero_cnh" id="cnh" placeholder="12345678901" title="Insira a Habilitação do Usuário">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputValidade">Validade</label>
                    <div class="controls">
                        <input id="validade" type="text" name="validade_cnh" id="validade" placeholder="12/12/2012" title="Insire a Válidade da CNH do Usuário">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCategoria">Categoria</label>
                    <div class="controls">
                        <input type="text" name="categoria_cnh" id="categoria" placeholder="ABC" title="Insira a Categoria">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputRua">Rua</label>
                    <div class="controls">
                        <input type="text" name="rua" id="rua" placeholder="Rua" title="Insira a Rua">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputNumero">Numero</label>
                    <div class="controls">
                        <input type="text" name="numero" id="numero" placeholder="Somente numeros" title="Insira o Número da Residência">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputComplemento">Complemento</label>
                    <div class="controls">
                        <input type="text" name="complemento" id="complemento" placeholder="Complemento" title="Insira o Complemento">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCep">CEP</label>
                    <div class="controls">
                        <input type="text" name="cep" id="cep" placeholder="99500000" title="Insira o CEP">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"  for="inputEstado">Estado</label>
                    <div  class="controls">
                        <select id="estado" name="estado" title="Selecione o Estado">
                            <option></option>
                            <%
                                EstadoController estadoController = new EstadoController();
                                List<Estado> listaEstados = estadoController.listar();
                                for (int i = 0; i < listaEstados.size(); i++) {
                                    out.print("<option value='" + listaEstados.get(i).getId() + "'>" + listaEstados.get(i).getSigla() + "</option>");
                                }
                            %>
                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label"  for="inputCidade">Cidade</label>
                    <div  class="controls">
                        <select id="cidade" name="cidade" title="Selecione a Cidade">
                            <option></option>
                        </select>
                    </div>
                </div> 
                <hr>

                <p>
                    <a href="listaUsuarios.jsp" class="btn btn-info btn" title="Clique aqui para Retornar a Página Anterior!">&laquo; Voltar </a>

                    <button type="submit" class="btn btn-success btn" title="Clique aqui para Cadastrar um Novo Usuário!">
                        <i class="icon-ok"></i> Cadastrar
                    </button>
                </p>
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
