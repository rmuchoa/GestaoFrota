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
    String html = "<option value=''></option></ br>";
%>

<%
    CidadeController cidadeController = new CidadeController();
    EstadoController estadoController = new EstadoController();
    String id = request.getParameter("estado") == null ? "" : request.getParameter("estado");
    Estado estado = estadoController.buscarPorId(Integer.parseInt(id));
    System.out.println(estado);
    List<Cidade> cidades = cidadeController.listarPorEstado(estado);
    System.out.println("número de cidades para "+estado+": "+cidades.size());

    for (Cidade cidade : cidades) {
        if (cidade.getEstado().getId() == estado.getId()) {
            System.out.println(cidade.getNome());

            html += "<option value='"+cidade.getId()+"'>"+cidade.getNome()+"</option></ br>";          

        }
    }
    
    out.print(html);

%>