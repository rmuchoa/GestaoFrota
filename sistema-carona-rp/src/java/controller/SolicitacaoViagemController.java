/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import javax.servlet.http.HttpServletRequest;
import model.dao.SolicitacaoViagemDAO;
import model.dao.UsuarioDAO;
import model.entity.SolicitacaoViagem;

/**
 *
 * @author Marcelo Maia
 */
public class SolicitacaoViagemController {
    
    private SolicitacaoViagemDAO solicitacaoViagemDAO;
    private SolicitacaoViagem solicitacaoViagem;
    private UsuarioDAO usuarioDAO;
    
    public void inserirSolicitacao(HttpServletRequest request){
      this.usuarioDAO = new UsuarioDAO();  
      this.solicitacaoViagem = new SolicitacaoViagem();
      this.solicitacaoViagem.setUsuario(this.usuarioDAO.buscarPorNome(request.getParameter("solicitante")));
      this.solicitacaoViagem.setNumero_pessoas(Integer.parseInt(request.getParameter("numeroPessoas")));
      this.solicitacaoViagem.setEhservidor(Boolean.parseBoolean(request.getParameter("ehservidor")));
      this.solicitacaoViagem.setOrigem(Integer.parseInt(request.getParameter("cidadeOrigem")));
      this.solicitacaoViagem.setData_saida(request.getParameter("dataSaida")+" "+request.getParameter("horarioSaida"));
      this.solicitacaoViagem.setLogal_saida(request.getParameter("localSaida"));
      this.solicitacaoViagem.setDestino(Integer.parseInt(request.getParameter("cidadeRetorno")));
      this.solicitacaoViagem.setData_retorno(request.getParameter("dataRetorno")+" "+request.getParameter("horarioRetorno"));
      this.solicitacaoViagem.setLocal_retorno(request.getParameter("localRetorno"));
      this.solicitacaoViagem.setPercurso(request.getParameter("percurso"));
      this.solicitacaoViagem.setObservacoes(request.getParameter("observacao"));
      this.solicitacaoViagem.setJustificativa(request.getParameter("objetivo"));
      this.solicitacaoViagemDAO = new SolicitacaoViagemDAO();
      this.solicitacaoViagemDAO.inserir(solicitacaoViagem);
    }
    
    public SolicitacaoViagem buscarPorDataSaida(HttpServletRequest request) {
        return solicitacaoViagemDAO.buscarPorDataSaida(
                request.getParameter("dataSaida")+" "+request.getParameter("horarioRetorno"), 
                new UsuarioDAO().buscarPorNome(request.getParameter("solicitante")));
    }
   
}
