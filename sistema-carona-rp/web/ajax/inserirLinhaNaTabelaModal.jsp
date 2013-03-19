<%-- 
    Document   : ListaSolicitacoesAjax
    Created on : 21/Fev/2013, 1:34:39
    Author     : Marcelo Maia
--%>

<%@page import="controller.ViagemController"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="controller.SolicitacaoViagemController"%>
<%@page import="model.dao.SolicitacaoViagemDAO"%>

<%

    if (session.getAttribute("usuario") != null) {

        if (request.getMethod().equalsIgnoreCase("get")) {
            
            SolicitacaoViagem solicitacaoViagem = new SolicitacaoViagem();
            SolicitacaoViagemController solicitacaoViagemController = new SolicitacaoViagemController();
            solicitacaoViagem = solicitacaoViagemController.buscarPorId(Integer.parseInt(request.getParameter("id")));

            String mensagem = '"' + "Identificador da solicitação" + solicitacaoViagem.getId() + "<br/>"
                    + "Nome do solicitante: " + solicitacaoViagem.getSolicitante().getNome() + "<br/>"
                    + "Email: " + solicitacaoViagem.getSolicitante().getEmail() + "<br/>"
                    + "Telefone: " + solicitacaoViagem.getSolicitante().getTelefone() + "<br/>"
                    + "Data saída: " + solicitacaoViagem.getDataSaida() + "<br/>"
                    + "Data retorno: " + solicitacaoViagem.getDataRetorno() + "<br/>"
                    + "Origem: " + solicitacaoViagem.getOrigem().getNome() + "<br/>"
                    + "Destino: " + solicitacaoViagem.getDestino().getNome() + "<br/>"
                    + "Situação: " + solicitacaoViagem.getSituacao().getDescricao() + '"';

            String html = "";
            html += "<tr id='" + solicitacaoViagem.getId() + "'>"
                    + "<td id='identificador'>" + solicitacaoViagem.getId() + "</td>"
                    + "<td>" + new SimpleDateFormat("dd/MM/yyyy").format(solicitacaoViagem.getDataSaida()) + "</td>"
                    + "<td>" + solicitacaoViagem.getOrigem().getNome() + "</td>"
                    + "<td>" + solicitacaoViagem.getDestino().getNome() + "</td>"
                    + "<td>" + solicitacaoViagem.getSituacao().getDescricao() + "</td>"
                    + "<td>"
                    + "<a href='#' onclick='removerItemTabela(" + solicitacaoViagem.getId() + ")' class='btn btn-mini'>X</a>"
                    + "<a href='#' onclick='exibirDetalhesItemDaTabela(" + mensagem + ")' class='btn btn-mini' >detalhes</a>"
                    + "</td>"
                    + "</tr>";

            out.print(html);
        }

    } else {

        response.sendRedirect("login.jsp");

    }

%>