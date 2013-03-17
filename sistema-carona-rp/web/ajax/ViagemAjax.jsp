<%-- 
    Document   : ListaSolicitacoesAjax
    Created on : 21/Fev/2013, 1:34:39
    Author     : Marcelo Maia
--%>



<%@page import="java.util.ArrayList"%>
<%@page import="model.dao.SolicitacaoViagemDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.SolicitacaoViagem"%>
<%@page import="model.entity.Viagem"%>
<%@page import="controller.ViagemController"%>
<%

    if (request.getMethod().equalsIgnoreCase("post")) {

        ViagemController viagemController = new ViagemController();
       
        SolicitacaoViagemDAO solicitacaoViagemDAO = new SolicitacaoViagemDAO();
        List<SolicitacaoViagem> listaSolicitacao = new ArrayList<SolicitacaoViagem>();
        String str = request.getParameter("lista");
        char array[] = str.toCharArray();
        
        for(int i =0; i<array.length; i++){
             System.out.println(array[i]);
             String s =String.valueOf(array[i]);
             
             listaSolicitacao.add(solicitacaoViagemDAO.buscarPorId(Integer.parseInt(s)));
        }
        request.setAttribute("solicitacoes", listaSolicitacao);
        
        viagemController.abrirViagem(request);



        String html = "Cadastro realizado com sucesso";


        out.print(html);
    }
%>