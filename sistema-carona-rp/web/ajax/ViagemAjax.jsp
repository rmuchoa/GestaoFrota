<%-- 
    Document   : ListaSolicitacoesAjax
    Created on : 21/Fev/2013, 1:34:39
    Author     : Marcelo Maia
--%>



<%@page import="model.entity.Viagem"%>
<%@page import="controller.ViagemController"%>
<%

    if (request.getMethod().equalsIgnoreCase("post")) {
    
        Viagem viagem = new Viagem();
        ViagemController viagemController = new ViagemController();
        viagemController.abrirViagem(request);        
        
        out.println(request.getAttribute(""));
        
        String html = "";


       out.print(html);
    }
%>