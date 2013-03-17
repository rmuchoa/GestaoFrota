<%-- 
    Document   : ListaSolicitacoesAjax
    Created on : 21/Fev/2013, 1:34:39
    Author     : Marcelo Maia
--%>



<%@page import="controller.ViagemController"%>
<%

    if (request.getMethod().equalsIgnoreCase("post")) {
        ViagemController viagemController = new ViagemController();
        
        
        String html = "";


       out.print(html);
    }
%>