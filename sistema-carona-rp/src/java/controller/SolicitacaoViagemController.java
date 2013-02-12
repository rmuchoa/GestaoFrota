/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import model.dao.CidadeDAO;
import model.dao.SituacaoSolicitacaoDAO;
import model.dao.SolicitacaoViagemDAO;
import model.dao.UsuarioDAO;
import model.entity.SolicitacaoViagem;
import model.entity.Usuario;

/**
 *
 * @author Marcelo Maia
 */
public class SolicitacaoViagemController {
    
    private SolicitacaoViagemDAO solicitacaoViagemDAO;
    private SolicitacaoViagem solicitacaoViagem;
    private UsuarioDAO usuarioDAO;
    
    public void inserirSolicitacao(HttpServletRequest request){
        try {
            this.usuarioDAO = new UsuarioDAO();  
            this.solicitacaoViagem = new SolicitacaoViagem();
            this.solicitacaoViagem.setSolicitante(this.usuarioDAO.buscarPorId(Integer.parseInt(request.getParameter("solicitante"))));
            this.solicitacaoViagem.setPassageiro(Boolean.parseBoolean(request.getParameter("passageiro")));
            this.solicitacaoViagem.setOrigem(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter("cidadeOrigem"))));
            this.solicitacaoViagem.setDataSaida(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(
                    request.getParameter("dataSaida")+" "+request.getParameter("horarioSaida")));
            this.solicitacaoViagem.setLogalSaida(request.getParameter("localSaida"));
            this.solicitacaoViagem.setDestino(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter("cidadeRetorno"))));
            this.solicitacaoViagem.setDataRetorno(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(
                    request.getParameter("dataRetorno")+" "+request.getParameter("horarioRetorno")));
            this.solicitacaoViagem.setLocalRetorno(request.getParameter("localRetorno"));
            this.solicitacaoViagem.setPercurso(request.getParameter("percurso"));
            this.solicitacaoViagem.setObservacoes(request.getParameter("observacao"));
            this.solicitacaoViagem.setJustificativa(request.getParameter("objetivo"));
            this.solicitacaoViagem.setSituacaoSolicitacao(new SituacaoSolicitacaoDAO().buscarPorId(1));
            this.solicitacaoViagemDAO = new SolicitacaoViagemDAO();
            this.solicitacaoViagemDAO.inserir(solicitacaoViagem);
        } catch (ParseException ex) {
            Logger.getLogger(SolicitacaoViagemController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public SolicitacaoViagem buscarPorDataSaida(HttpServletRequest request) {
        try {
            Date dataSolicitacao = new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(request.getParameter("dataSaida")+" "+request.getParameter("horarioRetorno"));
            Usuario solicitante = new UsuarioDAO().buscarPorId(Integer.parseInt(request.getParameter("solicitante")));
            solicitacaoViagemDAO = new SolicitacaoViagemDAO();
            return solicitacaoViagemDAO.buscarPorDataSaida(dataSolicitacao, solicitante);
        } catch (ParseException ex) {
            Logger.getLogger(SolicitacaoViagemController.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    public SolicitacaoViagem buscarPorId(Integer id) {
        solicitacaoViagemDAO = new SolicitacaoViagemDAO();
        return solicitacaoViagemDAO.buscarPorId(id);
    }
   
}
