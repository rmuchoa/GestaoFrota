/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import model.dao.*;
import model.entity.SolicitacaoViagem;
import model.entity.Viagem;

/**
 *
 * @author renanmarceluchoa
 */
public class ViagemController {

    private ViagemDAO viagemDAO;
    private Viagem viagem;

    public Viagem abrirViagem(HttpServletRequest request) {

        try {

            viagem = new Viagem();
            viagem.setVeiculo(new VeiculoDAO().getVeiculoPorId(Integer.parseInt(request.getParameter(""))));
            viagem.setMotorista(new UsuarioDAO().buscarPorId(Integer.parseInt(request.getParameter(""))));
            viagem.setSituacao(new SituacaoDAO().buscarPorDescricao("AGENDADA"));
            viagem.setCidadeOrigem(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter(""))));
            viagem.setDataSaida(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(request.getParameter("")));
            viagem.setLocalSaida(request.getParameter(""));
            viagem.setCidadeRetorno(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter(""))));
            viagem.setDataRetorno(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(request.getParameter("")));
            viagem.setLocalRetorno(request.getParameter(""));
            viagem.setPercurso(request.getParameter(""));
            viagem.setObservacoes(request.getParameter(""));
            viagem.setSolicitacoes((List<SolicitacaoViagem>) request.getAttribute("solicitacoes"));
            
            for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {
                solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("AGENDADA"));
            }
            
            return viagemDAO.abrirViagem(viagem);

        } catch (ParseException ex) {
            Logger.getLogger(SolicitacaoViagemController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;

    }
    
    public Boolean autorizarViagem(HttpServletRequest request) {
        
        Integer viagemId = Integer.parseInt(request.getParameter("viagemId"));
        viagem = viagemDAO.buscarPorId(viagemId);
        viagem.setSituacao(new SituacaoDAO().buscarPorDescricao("AUTORIZADA"));
        for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {
            solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("AUTORIZADA"));
        }
        return viagemDAO.alterarSituacaoViagem(viagem);
        
    }
    
    public Boolean rejeitarViagem(HttpServletRequest request) {
        
        Integer viagemId = Integer.parseInt(request.getParameter("viagemId"));
        viagem = viagemDAO.buscarPorId(viagemId);
        viagem.setSituacao(new SituacaoDAO().buscarPorDescricao("REJEITADA"));
        for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {
            solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("REJEITADA"));
        }
        return viagemDAO.alterarSituacaoViagem(viagem);
        
    }
    
    public Boolean finalizarViagem(HttpServletRequest request) {
        
        Integer viagemId = Integer.parseInt(request.getParameter("viagemId"));
        viagem = viagemDAO.buscarPorId(viagemId);
        viagem.setSituacao(new SituacaoDAO().buscarPorDescricao("REALIZADA"));
        for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {
            solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("REALIZADA"));
        }
        return viagemDAO.alterarSituacaoViagem(viagem);
        
    }
    
}
