<%-- 
    Document   : ListaSolicitacoesAjax
    Created on : 21/Fev/2013, 1:34:39
    Author     : Marcelo Maia
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="controller.SolicitacaoViagemController"%>
<%@page import="model.dao.SolicitacaoViagemDAO"%>

<%
    if (request.getMethod().equalsIgnoreCase("get")) {
        List<SolicitacaoViagem> listaSolicitacao = new ArrayList<SolicitacaoViagem>();
        SolicitacaoViagemController solicitacaoViagemController = new SolicitacaoViagemController();
        listaSolicitacao = solicitacaoViagemController.listarPorIntervaloDatas(request);

        String html = "<table class='table table-bordered'>"
                + "<thead>"
                + "<tr>"
                + "<td>Id</td>"
                + "<td>Data de Saída</td>"
                + "<td>Orígem</td>"
                + "<td>Destino</td>"
                + "<td>Situação</td>"
                + "<td>Selecionar</td>"
                + "</tr>"
                + "</head>"
                + "<tbody>";

        for (int i = 0; i < listaSolicitacao.size(); i++) {
            html += "<tr>"
                    + "<td>" + listaSolicitacao.get(i).getId() + "</td>"
                    + "<td>" + new SimpleDateFormat("dd/MM/yyyy").format(listaSolicitacao.get(i).getDataSaida()) + "</td>"
                    + "<td>" + listaSolicitacao.get(i).getOrigem().getNome() + "</td>"
                    + "<td>" + listaSolicitacao.get(i).getDestino().getNome() + "</td>"
                    + "<td>" + listaSolicitacao.get(i).getSituacao().getDescricao() + "</td>"
                    + "<td><input type='checkbox' name='solicitacao" + listaSolicitacao.get(i).getId() + "'"
                    + " value='" + listaSolicitacao.get(i).getId() + "'></td>"
                    + "</tr>";
        }

        html += "</tbody>"
                + "</table>"
                + "<input type='submit' class='btn btn-large' name='criarViagem' value='Criar Viagem'>";
        out.print(html);
    }
%>