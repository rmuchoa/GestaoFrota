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
     
     
     ViagemController viagemController = new ViagemController();
     viagemController.autorizarViagem(request);
     ViagemDAO viagemDAO = new ViagemDAO();
     Viagem viagem = viagemDAO.buscarPorId(Integer.parseInt(request.getParameter("id")));
   
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
                                      html+= "<td>"+viagem.getId() +"</td>"+
                                            "<td>"+ new SimpleDateFormat("dd/MM/yyyy").format(viagem.getDataSaida()) +"</td>"+
                                            "<td>"+viagem.getCidadeOrigem().getNome() +"</td>"+
                                            "<td>"+viagem.getCidadeRetorno().getNome()+"</td>"+
                                            "<td>"+viagem.getSituacao().getDescricao()+"</td>"+
                                            
                                            "<td>"+
                                                
                                                
                                                "<a onclick='detalheViagem("+viagem.getId()+")' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
                                                "<i class='icon-search'></i>"+ 
                                                "</a>"+
                                                
//                                                "<a onclick='cancelarViagem("+viagem.getId()+")' class='btn btn-success btn' title='Clique aqui para Salvar o Formulário!'>"+
//                                                "<i class='icon-remove'></i>"+
//                                                "</a>"+
                                            "</td>";
                                        
           
         html  += "</tbody></table>";
         out.println(html);
 }
%>
