<%-- 
    Document   : cadastrarVeiculo
    Created on : 30/01/2013, 23:52:39
    Author     : renanmarceluchoa
--%>

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
    if (request.getMethod().equalsIgnoreCase("post")) {
        UsuarioController usuarioController = new UsuarioController();
        usuarioController.inserir(request);
        response.sendRedirect("listaUsuarios.jsp");
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
        <script>
            $(document).ready(function() {
                $("#estado").change(function() {
                    $.ajax({
                        url:"cidades.jsp",
                        dataType:"json",
                        data:{estado: $("#estado").val()},
                        type:"POST",
                        success:function(data){
                            console.log(data);
                            this.alert("chegou!!!");
                            for (var i=0; i<data.length(); i++) {
                                $("#cidade").append("<option value='"+data.i.getId()+"'>"+data.i.getNome()+"</option>");
                            }
                        }
                    });
                });
            });            
        </script>
        
        

        <title>Sistema de Caronas Unipampa</title>
    </head>
    <body>
        <h3 class="span12 well">Sistema de Caronas Unipampa</h3>
        <div class="offset2 span8 offset2">



            <form action="cadastrarUsuario.jsp" method="POST" class="form-horizontal well">

                <div class="control-group">
                    <label class="control-label" for="inputNome">Nome</label>
                    <div class="controls">
                        <input type="text" id="nome" name="nome" placeholder="Nome">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputLogin">Login</label>
                    <div class="controls">
                        <input type="text"  id="login" name="login" placeholder="Login">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputSenha">Senha</label>
                    <div class="controls">
                        <input type="password" name="senha" id="senha" placeholder="Senha">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"  for="inputTipo">Tipo</label>
                    <div  class="controls">
                        <select id="tipo" name="tipo_usuario">
                            <%
                                TipoUsuarioController tipoVeiculoController = new TipoUsuarioController();
                                List<TipoUsuario> listaTiposUsuario = tipoVeiculoController.listar();
                                for (int i = 0; i < listaTiposUsuario.size(); i++) {
                                    out.print("<option value='"+listaTiposUsuario.get(i).getId()+"'>" + listaTiposUsuario.get(i).getDescricao() + "</option>");
                                }
                            %>

                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label" for="inputEmail">Email</label>
                    <div class="controls">
                        <input type="text" name="email" id="email" placeholder="Email">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputTelefone">telefone</label>
                    <div class="controls">
                        <input type="text" name="telefone" id="telefone" placeholder="Telefone">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputCelular">Celular</label>
                    <div class="controls">
                        <input type="text" name="celular" id="celular" placeholder="Celular">
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="inputRg">RG</label>
                    <div class="controls">
                        <input type="text" id="rg"  name="rg" placeholder="RG">

                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputSiape">Siape</label>
                    <div class="controls">
                        <input type="text" name="siape" id="siape" placeholder="Siape">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCnh">Habilitação</label>
                    <div class="controls">
                        <input type="text" name="numero_cnh" id="cnh" placeholder="Habilitação">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputValidade">Validade</label>
                    <div class="controls">
                        <input type="text" name="validade_cnh" id="validade" placeholder="Validade">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCategoria">Categoria</label>
                    <div class="controls">
                        <input type="text" name="categoria_cnh" id="categoria" placeholder="Categoria">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputRua">Rua</label>
                    <div class="controls">
                        <input type="text" name="rua" id="rua" placeholder="Rua">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputNumero">Numero</label>
                    <div class="controls">
                        <input type="text" name="numero" id="numero" placeholder="Numero">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputComplemento">Complemento</label>
                    <div class="controls">
                        <input type="text" name="complemento" id="complemento" placeholder="Complemento">
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label" for="inputCep">CEP</label>
                    <div class="controls">
                        <input type="text" name="cep" id="cep" placeholder="CEP">
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
                                for (int i = 0; i < listaEstados.size(); i++) {
                                    out.print("<option value='"+listaEstados.get(i).getId() +"'>" + listaEstados.get(i).getSigla() + "</option>");
                                }
                            %>
                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <label class="control-label"  for="inputCidade">Cidade</label>
                    <div  class="controls">
                        <select id="cidade" name="cidade">
                           <option></option>
                            <%
                                 CidadeController cidadeController = new CidadeController(); 
                                 List<Cidade> listaCidades = cidadeController.listar(); 
                                 for (int i = 0; i < listaCidades.size(); i++) {
                                     Cidade cidade = listaCidades.get(i);
                                     out.print("<option value='"+cidade.getId()+"'>"+cidade.getNome()+" - "+cidade.getEstado().getSigla()+"</option>");
                                 }
                            %> 
                        </select>
                    </div>
                </div> 

                <div class="control-group">
                    <div class="controls">
                        <input type="submit" id="enviar" value="Cadastrar" class="btn">
                        <div class="btn"><a href="listaUsuarios.jsp">Cancelar</a></div>
                    </div>
                </div>


            </form>

        </div>
    </body>


</html>
