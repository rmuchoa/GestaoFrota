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
import model.entity.Usuario;
import model.entity.Viagem;

/**
 *
 * @author renanmarceluchoa
 */
public class ViagemController {

    private ViagemDAO viagemDAO = new ViagemDAO();
    private Viagem viagem;

    public Viagem abrirViagem(HttpServletRequest request) {

        try {

            viagem = new Viagem();
            viagem.setVeiculo(new VeiculoDAO().getVeiculoPorId(Integer.parseInt(request.getParameter("veiculo"))));
            viagem.setMotorista(new UsuarioDAO().buscarPorId(Integer.parseInt(request.getParameter("motorista"))));
            viagem.setSituacao(new SituacaoDAO().buscarPorDescricao("AGENDADA"));
            viagem.setCidadeOrigem(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter("cidadeOrigem"))));
            viagem.setDataSaida(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(request.getParameter("data_saida")+" "+request.getParameter("horario_saida")));
            viagem.setLocalSaida(request.getParameter("localSaida"));
            viagem.setCidadeRetorno(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter("cidadeRetorno"))));
            viagem.setDataRetorno(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(request.getParameter("data_retorno")+" "+request.getParameter("horario_retorno")));
            viagem.setLocalRetorno(request.getParameter("localRetorno"));
            viagem.setPercurso(request.getParameter("percurso"));
            viagem.setObservacoes(request.getParameter("observacao"));
            viagem.setSolicitacoes((List<SolicitacaoViagem>) request.getAttribute("solicitacoes"));
            
            for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {
                solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("AGENDADA"));
                System.out.println("ID"+solicitacao.getId());
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
    
    public Viagem buscarPorId(int id){
        return viagemDAO.buscarPorId(id);
        
    }
    
    public List<Viagem> listarViagensMotorista (Usuario usuario) {
    
        Usuario motorista = new UsuarioDAO().buscarPorId(5);
        return viagemDAO.listarViagemMotorista(motorista);
                
       
    }
    
    public String criarDetalheItem(SolicitacaoViagem solicitacao){
        String mensagem = "'Identificador da solicitação"+solicitacao.getId()+"<br/>"+
        "Nome do solicitante: "+solicitacao.getSolicitante().getNome()+"<br/>"+
        "Email: "+solicitacao.getSolicitante().getEmail()+"<br/>"+
        "Telefone: "+solicitacao.getSolicitante().getTelefone()+"<br/>"+
        "Data saída: "+solicitacao.getDataSaida()+"<br/>"+
        "Data retorno: "+solicitacao.getDataRetorno()+"<br/>"+
        "Origem: "+solicitacao.getOrigem().getNome()+"<br/>"+
        "Destino: "+solicitacao.getDestino().getNome()+"<br/>"+
        "Situação: "+solicitacao.getSituacao().getDescricao()+"'";
        return mensagem;
    }
    
}
