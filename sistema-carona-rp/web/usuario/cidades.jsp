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
<%@page import="org.json.JSONObject"%>

<%
    CidadeController cidadeController = new CidadeController();
    EstadoController estadoController = new EstadoController();
    String id = request.getParameter("estado") == null ? "" : request.getParameter("estado");
    Estado estado = estadoController.buscarPorId(Integer.parseInt(id));
    List<Cidade> cidades = cidadeController.listarPorEstado(estado);
    
    JSONObject json = new JSONObject();
    int i = 0;
    json.put(""+i, "");
    
    for (Cidade cidade : cidades) {
        i++;
        if (cidade.getEstado().getId() == estado.getId()) {
            System.out.println(cidade.getNome());
            json.put(""+i, cidade);
        }
    }
    
    out.print(json);
%>