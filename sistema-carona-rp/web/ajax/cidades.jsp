<%-- 
    Document   : cidades
    Created on : 01/02/2013, 00:47:46
    Author     : renanmarceluchoa
--%>
<%@page import="model.entity.Estado"%>
<%@page import="controller.EstadoController"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Cidade"%>
<%@page import="controller.CidadeController"%>

<%

    if (session.getAttribute("usuario") != null) {

        CidadeController cidadeController = new CidadeController();
        EstadoController estadoController = new EstadoController();
        String id = request.getParameter("estado") == null ? "" : request.getParameter("estado");
        Estado estado = estadoController.buscarPorId(Integer.parseInt(id));
        List<Cidade> cidades = cidadeController.listarPorEstado(estado);

        String html = "";

        for (Cidade cidade : cidades) {
            html += "<option value='" + cidade.getId() + "'>" + cidade.getNome() + "</option>";
        }

        out.print(html);

    } else {

        response.sendRedirect("login.jsp");

    }

%>