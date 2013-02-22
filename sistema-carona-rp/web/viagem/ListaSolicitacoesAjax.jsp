<%-- 
    Document   : ListaSolicitacoesAjax
    Created on : 21/Fev/2013, 1:34:39
    Author     : Marcelo Maia
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="controller.SolicitacaoViagemController"%>
<%@page import="model.dao.SolicitacaoViagemDAO"%>

<%
   if(request.getMethod().equalsIgnoreCase("get")){
       List<SolicitacaoViagem> listaSolicitacao = new ArrayList<>();
       SolicitacaoViagemController solicitacaoViagemController = new SolicitacaoViagemController();
       listaSolicitacao = solicitacaoViagemController.listarPorIntervaloDatas(request);
       
       
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
                        
                        "<tbody>";
                      for(int i=0;i<listaSolicitacao.size();i++){      
                          html+= "<tr>"+
                                "<td>"+listaSolicitacao.get(i).getId() +"</td>"+
                                "<td>"+listaSolicitacao.get(i).getDataSaida() +"</td>"+
                                "<td>"+listaSolicitacao.get(i).getOrigem().getNome()+"</td>"+
                                "<td>"+listaSolicitacao.get(i).getDestino().getNome()+"</td>"+
                                "<td>"+listaSolicitacao.get(i).getSituacao().getDescricao()+"</td>"+
                                "<td><input type='checkbox' name='select' value='Bike'></td>"+
                            "</tr>";
                      }
  
                       html+= "</tbody>"+
                        
                    "</table><input type='submit' class='btn btn-large' value='Criar Viagem'>";
       System.out.println(html);
       out.print(html);
   }
%>