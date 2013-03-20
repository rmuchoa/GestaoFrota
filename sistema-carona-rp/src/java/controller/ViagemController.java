
package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import model.dao.CidadeDAO;
import model.dao.SituacaoDAO;
import model.dao.UsuarioDAO;
import model.dao.VeiculoDAO;
import model.dao.ViagemDAO;
import model.entity.SolicitacaoViagem;
import model.entity.Usuario;
import model.entity.Viagem;
import notifica.Notificacoes;

/**
 *
 * @author renanmarceluchoa
 */
public class ViagemController {

    private ViagemDAO viagemDAO = new ViagemDAO();
    private Viagem viagem;
    Notificacoes notifica = new Notificacoes();

    public Viagem abrirViagem(HttpServletRequest request) {

        try {

            viagem = new Viagem();
            viagem.setVeiculo(new VeiculoDAO().getVeiculoPorId(Integer.parseInt(request.getParameter("veiculo"))));
            viagem.setMotorista(new UsuarioDAO().buscarPorId(Integer.parseInt(request.getParameter("motorista"))));
            viagem.setSituacao(new SituacaoDAO().buscarPorDescricao("AGENDADA"));
            viagem.setCidadeOrigem(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter("cidadeOrigem"))));
            System.out.println(request.getParameter("data_saida")+" "+request.getParameter("horario_saida"));
            viagem.setDataSaida(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").parse(request.getParameter("data_saida")+" "+request.getParameter("horario_saida")+":00"));
            viagem.setLocalSaida(request.getParameter("localSaida"));
            viagem.setCidadeRetorno(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter("cidadeRetorno"))));
            viagem.setDataRetorno(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").parse(request.getParameter("data_retorno")+" "+request.getParameter("horario_retorno")+":00"));
            viagem.setLocalRetorno(request.getParameter("localRetorno"));
            viagem.setPercurso(request.getParameter("percurso"));
            viagem.setObservacoes(request.getParameter("observacao"));
            viagem.setSolicitacoes((List<SolicitacaoViagem>) request.getAttribute("solicitacoes"));
            
            for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {
                solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("AGENDADA"));
                notifica.notificaViagemCriada(solicitacao);
                System.out.println("ID"+solicitacao.getId());
            }
            
            return viagemDAO.abrirViagem(viagem);

        } catch (ParseException ex) {
            Logger.getLogger(SolicitacaoViagemController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;

    }
    
    public Boolean autorizarViagem(HttpServletRequest request) {
        
        Integer viagemId = Integer.parseInt(request.getParameter("id"));
        viagem = viagemDAO.buscarPorId(viagemId);
        viagem.setSituacao(new SituacaoDAO().buscarPorDescricao("AUTORIZADA"));
        for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {
            solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("AUTORIZADA"));
        }
        notifica.notificaAutorizacaoViagem(viagem);
        return viagemDAO.alterarSituacaoViagem(viagem);
        
    }
    
    public Boolean rejeitarViagem(HttpServletRequest request) {
        System.out.println(request.getParameter("id")+"--"+request.getParameter("justificativa"));
        Integer viagemId = Integer.parseInt(request.getParameter("id"));
        viagem = viagemDAO.buscarPorId(viagemId);
        viagem.setJustificativaRejeite(request.getParameter("justificativa"));
        viagem.setSituacao(new SituacaoDAO().buscarPorDescricao("REJEITADA"));
        for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {
            solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("REJEITADA"));
        }
        
        notifica.notificaCanceladaViagem(viagem);
        return viagemDAO.rejeitarViagem(viagem);
        
    }
    
    public Boolean finalizarViagem(HttpServletRequest request) {
        try {
            Integer viagemId = Integer.parseInt(request.getParameter("viagem"));
            viagem = viagemDAO.buscarPorId(viagemId);
            viagem.setDataInicioReal(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(request.getParameter("dataSaida")+" "+request.getParameter("horaSaida")));
            viagem.setKilometragemInicio(Integer.parseInt(request.getParameter("quilometragemSaida")));
            viagem.setDataFimReal(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(request.getParameter("dataRetorno")+" "+request.getParameter("horaChegada")));
            viagem.setKilometragemFim(Integer.parseInt(request.getParameter("quilometragemRetorno")));
            viagem.setObservacoesPercurso(request.getParameter("observacoes"));
            Boolean finalizada = viagemDAO.finalizarViagem(viagem);
            if (finalizada) {
                viagem.setSituacao(new SituacaoDAO().buscarPorDescricao("REALIZADA"));
                for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {
                    solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("REALIZADA"));
                }
                return viagemDAO.alterarSituacaoViagem(viagem);
            } else {
                return Boolean.FALSE;
            }
        } catch (ParseException ex) {
            Logger.getLogger(ViagemController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
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
