<%-- 
    Document   : passageiros
    Created on : 04/02/2013, 10:14:10
    Author     : renanmarceluchoa
--%>

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
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery-1.9.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.maskedinput-1.1.4.pack.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/jquery.validate.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/validadores/Validators.js"></script>
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">

        <title>Sistema Caronas Unipampa</title>
    </head>
    <body>

        <%
       
        if (request.getParameter("addPassageiro") != null) {
             System.out.print("add passageiro ");
                if (request.getMethod().equalsIgnoreCase("post")) {
                    PassageiroController passageiroController = new PassageiroController();
                    passageiroController.adicionarPassageiro(request);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("passageiros");
                    dispatcher.forward(request, response);
                }
            }

        %>

        <div><!-- Algum texto informativo --></div>

        <div>
            <form action="passageiros.jsp" method="POST" class="form-actions">
                <table>
                    <tr>
                        <td>
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
                        </td>

                        <td>
                            <div class="control-group">
                                <label class="control-label" for="inputServidor">É Servidor da Unipampa:</label>
                                <div class="controls">
                                    <input id="sim" name="servidor" value="true" type="radio" /><label for="sim"> Sim</label> 
                                    <input id="nao" name="servidor" value="false" type="radio" /><label for="nao"> Não</label> 
                                </div>
                            </div>
                        </td>

                        <td>
                            <div class="span5">  
                                <input type="submit" name="addPassageiro" value="Adicionar Passageiro" class="btn btn-success btn-large"
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>

        <div>
            <table>
                <tr>
                    <th>Nome</th>
                    <th>RG</th>
                    <th>Servidor</th>
                    <th>Ações</th>
                </tr>
                <%
                    PassageiroController passageiroController = new PassageiroController();
                    List<Passageiro> passageiros = passageiroController.buscarPorSolicitacaoId(Integer.parseInt(request.getAttribute("solicitacao").toString()));
                    for (Passageiro p : passageiros) {
                %>
                <tr>
                    <td><%= p.getNome()%></td>
                    <td><%= p.getRg()%></td>
                    <td><%= p.isServidor() ? "Sim" : "Não"%></td>
                    <td><a href="" value="Editar" /><a href="" value="Remover" /></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>

    </body>
</html>
