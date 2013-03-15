/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.entity;

import java.util.Date;
import java.util.List;

/**
 *
 * @author Marcelo Maia
 */
public class SolicitacaoViagem {
    private Integer id;
    private Usuario solicitante;
    private Date dataSaida;
    private String localSaida;
    private Date dataRetorno;
    private String localRetorno;
    private String justificativa;
    private String observacoes;
    private Cidade origem;
    private Cidade destino;
    private String percurso;
    private Situacao situacao;
    private Boolean passageiro;
    private Viagem viagem;
    private List<Passageiro> passageiros;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Usuario getSolicitante() {
        return solicitante;
    }

    public void setSolicitante(Usuario solicitante) {
        this.solicitante = solicitante;
    }

    public Date getDataSaida() {
        return dataSaida;
    }

    public void setDataSaida(Date dataSaida) {
        this.dataSaida = dataSaida;
    }

    public String getLocalSaida() {
        return localSaida;
    }

    public void setLocalSaida(String localSaida) {
        this.localSaida = localSaida;
    }

    public Date getDataRetorno() {
        return dataRetorno;
    }

    public void setDataRetorno(Date dataRetorno) {
        this.dataRetorno = dataRetorno;
    }

    public String getLocalRetorno() {
        return localRetorno;
    }

    public void setLocalRetorno(String localRetorno) {
        this.localRetorno = localRetorno;
    }

    public String getJustificativa() {
        return justificativa;
    }

    public void setJustificativa(String justificativa) {
        this.justificativa = justificativa;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    public Cidade getOrigem() {
        return origem;
    }

    public void setOrigem(Cidade origem) {
        this.origem = origem;
    }

    public Cidade getDestino() {
        return destino;
    }

    public void setDestino(Cidade destino) {
        this.destino = destino;
    }

    public String getPercurso() {
        return percurso;
    }

    public void setPercurso(String percurso) {
        this.percurso = percurso;
    }

    public Situacao getSituacao() {
        return situacao;
    }

    public void setSituacao(Situacao situacao) {
        this.situacao = situacao;
    }

    public Boolean isPassageiro() {
        return passageiro;
    }

    public void setPassageiro(Boolean passageiro) {
        this.passageiro = passageiro;
    }

    /**
     * @return the passageiros
     */
    public List<Passageiro> getPassageiros() {
        return passageiros;
    }

    public Viagem getViagem() {
        return viagem;
    }

    public void setViagem(Viagem viagem) {
        this.viagem = viagem;
    }

    
    
    
    /**
     * @param passageiros the passageiros to set
     */
    public void setPassageiros(List<Passageiro> passageiros) {
        this.passageiros = passageiros;
    }
    
    
    
    
}
