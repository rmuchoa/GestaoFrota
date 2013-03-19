<%-- 
    Document   : cidades
    Created on : 01/02/2013, 00:47:46
    Author     : renanmarceluchoa
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="controller.SolicitacaoViagemController"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="controller.ViagemController"%>
<%@page import="model.entity.Estado"%>
<%@page import="controller.EstadoController"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Cidade"%>
<%@page import="controller.CidadeController"%>

<%

    if (session.getAttribute("usuario") != null) {

        List<SolicitacaoViagem> lista;
        String html = "";
        html += "<table id='tabela2' class='table table-bordered'>"
                + "<thead>"
                + "<tr>"
                + "<td>Id</td>"
                + "<td>Data Saida</td>"
                + "<td>Origem</td>"
                + "<td>Destino</td>"
                + "<td>Situação</td>"
                + "<td>Selecionar</td>"
                + "</tr>"
                + "</head>"
                + "<tbody>";
        
        SolicitacaoViagemController solicitacaoViagemController = new SolicitacaoViagemController();
        lista = solicitacaoViagemController.listar();
        for (SolicitacaoViagem solicitacao : lista) {
            if (solicitacao.getSituacao().getDescricao().equals("ABERTA")) {
                html += "<tr id='tabela2" + solicitacao.getId() + "'>"
                        + "<td id='codigo'>" + solicitacao.getId() + "</td>"
                        + "<td>" + new SimpleDateFormat("dd/MM/yyyy").format(solicitacao.getDataSaida()) + "</td>"
                        + "<td>" + solicitacao.getOrigem().getNome() + "</td>"
                        + "<td>" + solicitacao.getDestino().getNome() + "</td>"
                        + "<td>" + solicitacao.getSituacao().getDescricao() + "</td>"
                        + "<td>"
                        + "<input id='solicitacao" + solicitacao.getId() + "' type='checkbox' name='solicitacao" + solicitacao.getId() + "'  value='" + solicitacao.getId() + "'>"
                        + "</td>"
                        + "</tr>";
            }
        }
        
        html += "</tbody></table>";

        out.print(html);

    } else {

        response.sendRedirect("login.jsp");

    }

%>