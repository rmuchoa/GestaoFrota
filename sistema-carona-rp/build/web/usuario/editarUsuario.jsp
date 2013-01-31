<%-- 
    Document   : editarVeiculo
    Created on : 30/01/2013, 23:52:27
    Author     : renanmarceluchoa
--%>

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
    if (request.getMethod().equalsIgnoreCase("post")) {
        UsuarioController usuarioController = new UsuarioController();
        usuarioController.alterar(request);
        response.sendRedirect("listaUsuarios.jsp");
    }

%>

<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap-responsive.css">
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/jquery-1.8.0.min.js"></script>
        <script type="text/javas;cript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.min.js"></script>
        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body>
        <h3 class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset2 span8 offset2">

            <h3>Alteração dos dados do veículo</h3> 
            <%
                UsuarioController usuarioController = new UsuarioController();
                Usuario usuario = usuarioController.buscarPorId(Integer.parseInt(request.getParameter("id")));
            %>
            <form action="editarUsuario.jsp?id=<%out.println(request.getParameter("id"));%>" method="POST" class="form-horizontal well">

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
                                    if (usuario.getTipoUsuario().getDescricao().equals(listaTiposUsuario.get(i).getDescricao())) {
                                        out.print("<option selected = 'true'>" + listaTiposUsuario.get(i).getDescricao() + "</option>");
                                    } else {
                                        out.print("<option>" + listaTiposUsuario.get(i).getDescricao() + "</option>");
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
                        <input type="text" value="<%out.println(new SimpleDateFormat("dd/MM/yyyy").format(usuario.getValidadeCnh()));%>" name="validade_cnh" id="validade" placeholder="Validade">
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
                    <label class="control-label"  for="inputCidade">Cidade</label>
                    <div  class="controls">
                        <select id="tipo" name="cidade">
                            <%
                                CidadeController cidadeController = new CidadeController();
                                List<Cidade> listaCidades = cidadeController.listar();
                                for (int i = 0; i < listaCidades.size(); i++) {
                                    if (usuario.getCidade().getNome().equals(listaCidades.get(i).getNome())) {
                                        out.print("<option selected = 'true'>" + listaCidades.get(i).getNome() + "</option>");
                                    } else {
                                        out.print("<option>" + listaCidades.get(i).getNome() + "</option>");
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
    </body>
</html>
