<%-- 
    Document   : cidades
    Created on : 01/02/2013, 00:47:46
    Author     : renanmarceluchoa
--%>
<%@page import="model.entity.Viagem"%>
<%@page import="controller.ViagemController"%>
<%@page import="model.entity.Estado"%>
<%@page import="controller.EstadoController"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Cidade"%>
<%@page import="controller.CidadeController"%>

<%
    ViagemController viagemController = new ViagemController();
    String id = request.getParameter("viagem") == null ? "" : request.getParameter("viagem");
    String html = "";

    if (!id.equals("")) {
        Viagem viagem = viagemController.buscarPorId(Integer.parseInt(id));
        html += " <div id='dados_viagem' class='row-fluid'> ";
        html += "     <div class='span6'>Motorista: " + viagem.getMotorista().getNome() + "</div> ";
        html += "     <div class='span6'>Veiculo: " + viagem.getVeiculo().getMarca() + " - " + viagem.getVeiculo().getModelo() + " - " + viagem.getVeiculo().getPlaca() + "</div> ";
        html += " </div> ";
    } else {
        html += " <div id='dados_viagem' class='row-fluid'> ";
        html += "     <div class='span6'>Motorista: </div> ";
        html += "     <div class='span6'>Veiculo: </div> ";
        html += " </div> ";
    }
    out.print(html);
%>