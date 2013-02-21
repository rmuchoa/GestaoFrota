<%-- 
    Document   : ListaSolicitacoesAjax
    Created on : 21/Fev/2013, 1:34:39
    Author     : Marcelo Maia
--%>

<%@page import="controller.SolicitacaoViagemController"%>
<%@page import="model.dao.SolicitacaoViagemDAO"%>

<%
   if(request.getMethod().equalsIgnoreCase("get")){
       String dataInicial = request.getParameter("dataInicial");
       String dataFinal = request.getParameter("dataFinal");
       
       String html;
       html = "<table class='table table-bordered'>"+
                        "<thead>"+
                            "<tr>"+
                            "<td>CD Solicitação</td>"+
                            "<td>Data Saida</td>"+
                            "<td>Origem</td>"+
                            "<td>Destino</td>"+
                            "<td>Status solicitação</td>"+
                            "<td>Selecionar</td>"+
                            "</tr>"+
                        "</head>"+
                        
                        "<tbody>"+
                            
                            "<tr>"+
                                "<td>0012</td>"+
                                "<td>12/02/2012</td>"+
                                "<td>Alegrete-RS</td>"+
                                "<td>Bage-RS</td>"+
                                "<td>Aguardando Processamento</td>"+
                                "<td><input type='checkbox' name='select' value='Bike'></td>"+
                            "</tr>"+
                            
                        "</tbody>"+
                        
                    "</table><input type='submit' class='btn btn-large' value='Criar Viagem'>";
       out.print(html);
   }
%>