<%-- 
    Document   : viagens
    Created on : 19/Mar/2013, 23:52:26
    Author     : Marcelo Maia
--%>

<%@page import="model.entity.Cidade"%>
<%@page import="model.dao.CidadeDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.entity.Situacao"%>
<%@page import="model.dao.SituacaoDAO"%>
<%@page import="model.dao.SolicitacaoViagemDAO"%>
<%@page import="controller.SolicitacaoViagemController"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="model.entity.Viagem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="model.dao.ViagemDAO"%>
<%@page import="controller.ViagemController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
 if(request.getMethod().equalsIgnoreCase("POST")){
     System.out.println("chego aq");
     System.out.println(request.getParameter("pesquisa")+"-"+request.getParameter("valor_pesquisa"));
     ViagemDAO viagemDAO = new ViagemDAO();
     List<Viagem> list = new ArrayList<Viagem>();
     
     if(request.getParameter("pesquisa").equalsIgnoreCase("situacao_viagem")){
         System.out.print("OKOK");
         SituacaoDAO situacaoDAO = new SituacaoDAO();
         Situacao situacao = situacaoDAO.buscarPorDescricao(request.getParameter("valor_pesquisa"));
         list = viagemDAO.listarViagens();
         String html="";
           html +=  "<table class='table table-striped table-bordered table-condensed'>"+
                                        "<thead>"+
                                         "<th>Codigo Viagem</th>"+
                                         "<th>Data solicitação</th>"+
                                         "<th>Destino</th>"+
                                         "<th>Status</th>"+
                                         "<th>Opções</th>"+
                                        "</thead>"+
                                        "<tbody>";
         for(int i=0;i<list.size();i++){
             if(list.get(i).getSituacao().getDescricao().equalsIgnoreCase(situacao.getDescricao())){
                System.out.println(list.get(i).getSituacao().getDescricao()+situacao.getDescricao());
                                        html+= "<tr>"+
                                                "<td>"+list.get(i).getId() +"</td>"+
                                            "<td>"+ new SimpleDateFormat("dd/MM/yyyy").format(list.get(i).getDataSaida()) +"</td>"+
                                            "<td>"+list.get(i).getCidadeOrigem().getNome() +"</td>"+
                                            "<td>"+list.get(i).getCidadeRetorno().getNome()+"</td>"+
                                            "<td>"+list.get(i).getSituacao().getDescricao()+"</td>"+
                                            
                                            "<td>"+
                                                "<a  onclick='autorizarViagem("+list.get(i).getId()+");' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-ok'></i>"+ 
                                                "</a>"+
                                                
                                                "<a onclick='detalheViagem("+list.get(i).getId()+")' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-search'></i>"+ 
                                                "</a>"+
                                                
                                                "<a  onclick='cancelarViagem("+list.get(i).getId()+")' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-remove'></i>"+
                                                "</a>"+
                                            "</td>"+
                                            "</tr>";
                                        
             }
                
         }
         html  += "</tbody></table>";
         out.println(html);
         System.out.println(html);
     }


      if(request.getParameter("pesquisa").equalsIgnoreCase("cidade_retorno")){
         
         CidadeDAO cidadeDAO = new CidadeDAO();
         
         Cidade cidade = cidadeDAO.buscarPorNome(request.getParameter("valor_pesquisa"));
         list = viagemDAO.listarViagens();
         String html="";
           html +=  "<table class='table table-striped table-bordered table-condensed'>"+
                                        "<thead>"+
                                         "<th>Codigo Viagem</th>"+
                                         "<th>Data solicitação</th>"+
                                         "<th>Destino</th>"+
                                         "<th>Status</th>"+
                                         "<th>Opções</th>"+
                                        "</thead>"+
                                        "<tbody>";
         for(int i=0;i<list.size();i++){
             if(list.get(i).getCidadeRetorno().getNome().equalsIgnoreCase(cidade.getNome())){
                                        html+= "<td>"+list.get(i).getId() +"</td>"+
                                            "<td>"+ new SimpleDateFormat("dd/MM/yyyy").format(list.get(i).getDataSaida()) +"</td>"+
                                            "<td>"+list.get(i).getCidadeOrigem().getNome() +"</td>"+
                                            "<td>"+list.get(i).getSituacao().getDescricao()+"</td>"+
                                            
                                            "<td>"+
                                                "<a onclick='autorizarViagem("+list.get(i).getId()+");' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-ok'></i>"+ 
                                                "</a>"+
                                                
                                                "<a onclick='detalheViagem("+list.get(i).getId()+")' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-search'></i>"+ 
                                                "</a>"+
                                                
                                                "<a onclick='cancelarViagem("+list.get(i).getId()+")' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-remove'></i>"+
                                                "</a>"+
                                            "</td>";
                                        
             }
                
         }
         html  += "</tbody></table>";
         out.println(html);
         System.out.println(html);
     }
    
       if(request.getParameter("pesquisa").equalsIgnoreCase("cidade_origem")){
         
         CidadeDAO cidadeDAO = new CidadeDAO();
         
         Cidade cidade = cidadeDAO.buscarPorNome(request.getParameter("valor_pesquisa"));
         list = viagemDAO.listarViagens();
         String html="";
           html +=  "<table class='table table-striped table-bordered table-condensed'>"+
                                        "<thead>"+
                                         "<th>Codigo Viagem</th>"+
                                         "<th>Data solicitação</th>"+
                                         "<th>Destino</th>"+
                                         "<th>Status</th>"+
                                         "<th>Opções</th>"+
                                        "</thead>"+
                                        "<tbody>";
         for(int i=0;i<list.size();i++){
             if(list.get(i).getCidadeOrigem().getNome().equalsIgnoreCase(cidade.getNome())){
                                        html+= "<td>"+list.get(i).getId() +"</td>"+
                                            "<td>"+ new SimpleDateFormat("dd/MM/yyyy").format(list.get(i).getDataSaida()) +"</td>"+
                                            "<td>"+list.get(i).getCidadeOrigem().getNome() +"</td>"+
                                            "<td>"+list.get(i).getSituacao().getDescricao()+"</td>"+
                                            
                                            "<td>"+
                                                "<a  onclick='autorizarViagem("+list.get(i).getId()+");' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-ok'></i>"+ 
                                                "</a>"+
                                                                                                  
                                                "<a onclick='detalheViagem("+list.get(i).getId()+")' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-search'></i>"+ 
                                                "</a>"+
                                                
                                                "<a onclick='cancelarViagem("+list.get(i).getId()+")'  class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-remove'></i>"+
                                                "</a>"+
                                            "</td>";
                                        
             }
                
         }
         html  += "</tbody></table>";
         out.println(html);
         System.out.println(html);
     }
 }
%>
