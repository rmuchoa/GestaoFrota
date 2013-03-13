/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import model.dao.*;
import model.entity.Passageiro;
import model.entity.SolicitacaoViagem;

/**
 *
 * @author Marcelo Maia
 */
public class SolicitacaoViagemController {

    private SolicitacaoViagemDAO solicitacaoViagemDAO;
    private SolicitacaoViagem solicitacaoViagem;

    public List<SolicitacaoViagem> listar() {
        
        solicitacaoViagemDAO = new SolicitacaoViagemDAO();
        return solicitacaoViagemDAO.listar();
        
    }

    public List<SolicitacaoViagem> listaAcrescenta(List<SolicitacaoViagem> listaParaRemover) {
        List<SolicitacaoViagem> lista;
        solicitacaoViagemDAO = new SolicitacaoViagemDAO();
        lista =  solicitacaoViagemDAO.listar();
        for(int i=0;i<lista.size();i++){
            for(int j=0;j<listaParaRemover.size();j++){
                if(lista.get(i).getId()==listaParaRemover.get(j).getId()){
                 lista.remove(i);   
                }
               
            }
        }
        return lista;
        
    }

    public SolicitacaoViagem buscarPorId(Integer id) {
        
        solicitacaoViagemDAO = new SolicitacaoViagemDAO();
        return solicitacaoViagemDAO.buscarPorId(id);
        
    }
    
    public SolicitacaoViagem inserirSolicitacao(HttpServletRequest request) {
        
        try {
            
            this.solicitacaoViagem = new SolicitacaoViagem();
            this.solicitacaoViagem.setSolicitante(new UsuarioDAO().buscarPorId(Integer.parseInt(request.getParameter("solicitante"))));
            this.solicitacaoViagem.setPassageiro(Boolean.parseBoolean(request.getParameter("passageiro")));
            System.out.println("Cidade "+request.getParameter("cidadeOrigem"));
            this.solicitacaoViagem.setOrigem(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter("cidadeOrigem"))));
            this.solicitacaoViagem.setDataSaida(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(
                    request.getParameter("dataSaida") + " " + request.getParameter("horarioSaida")));
            this.solicitacaoViagem.setLocalSaida(request.getParameter("localSaida"));
            this.solicitacaoViagem.setDestino(new CidadeDAO().buscarPorId(Integer.parseInt(request.getParameter("cidadeRetorno"))));
            this.solicitacaoViagem.setDataRetorno(new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(
                    request.getParameter("dataRetorno") + " " + request.getParameter("horarioRetorno")));
            this.solicitacaoViagem.setLocalRetorno(request.getParameter("localRetorno"));
            this.solicitacaoViagem.setPercurso(request.getParameter("percurso"));
            this.solicitacaoViagem.setObservacoes(request.getParameter("observacao"));
            this.solicitacaoViagem.setJustificativa(request.getParameter("objetivo"));
            this.solicitacaoViagem.setSituacao(new SituacaoDAO().buscarPorDescricao("ABERTA"));
            this.solicitacaoViagem.setPassageiros(new ArrayList<Passageiro>());
            
            if (request.getParameter("passageiro").equals("true")) {
                
                Passageiro solicitante = new PassageiroDAO().buscarPorRg(solicitacaoViagem.getSolicitante().getRg());
                if (solicitante == null) {

                    this.solicitacaoViagem.getPassageiros().add(new PassageiroDAO().inserir(solicitacaoViagem.getSolicitante()));
                    return new SolicitacaoViagemDAO().inserir(solicitacaoViagem);

                } else {

                    if (!solicitacaoViagem.getSolicitante().getNome().equals(solicitante.getNome())
                            || !solicitacaoViagem.getSolicitante().getEmail().equals(solicitante.getEmail())
                            || !solicitante.getEndereco().equals("Rua " + solicitacaoViagem.getSolicitante().getRua() + ", " + solicitacaoViagem.getSolicitante().getNumero() + ", " + solicitacaoViagem.getSolicitante().getComplemento() + " - CEP " + solicitacaoViagem.getSolicitante().getCep() + ", " + solicitacaoViagem.getSolicitante().getCidade().getNome() + "/" + solicitacaoViagem.getSolicitante().getCidade().getEstado().getSigla())) {
                        
                        this.solicitacaoViagem.getPassageiros().add(new PassageiroDAO().alterar(solicitacaoViagem.getSolicitante()));
                        return new SolicitacaoViagemDAO().inserir(solicitacaoViagem);
                        
                    } else {
                        this.solicitacaoViagem.getPassageiros().add(solicitante);
                        return new SolicitacaoViagemDAO().inserir(solicitacaoViagem);
                    }
                }
            }
            
        } catch (ParseException ex) {
            Logger.getLogger(SolicitacaoViagemController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return null;
        
    }
    
    public List<SolicitacaoViagem> listarPorIntervaloDatas(HttpServletRequest request) {
        
        try {
            Date dataInicio = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("dataInicial"));
            Date dataFim = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("dataFinal"));
            return new SolicitacaoViagemDAO().buscarPorIntervaloDatas(dataInicio, dataFim);
        } catch (ParseException ex) {
            Logger.getLogger(SolicitacaoViagemController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return new ArrayList<SolicitacaoViagem>();
    
    }
    
    public Boolean rejeitarSolicitacao(HttpServletRequest request) {
        
        Integer solicitacaoId = Integer.parseInt(request.getParameter("solicitacao_id"));
        SolicitacaoViagem solicitacao = new SolicitacaoViagemDAO().buscarPorId(solicitacaoId);
        solicitacao.setSituacao(new SituacaoDAO().buscarPorDescricao("REJEITADA"));
        return new SolicitacaoViagemDAO().alterarSituacaoSolicitacao(solicitacao);
        
    }
    
}
