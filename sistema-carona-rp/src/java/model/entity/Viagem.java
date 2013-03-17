/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author renanmarceluchoa
 */
public class Viagem {
    
    private Integer id;
    private Veiculo veiculo;
    private Usuario motorista;
    private Cidade cidadeOrigem;
    private Date dataSaida;
    private String localSaida;
    private Cidade cidadeRetorno;
    private Date dataRetorno;
    private String localRetorno;
    private String percurso;
    private String observacoes;
    private String justificativaRejeite;
    private Situacao situacao;
    private Date dataInicioReal;
    private Integer kilometragemInicio;
    private Date dataFimReal;
    private Integer kilometragemFim;
    private String observacoesPercurso;
    private List<SolicitacaoViagem> solicitacoes;
    
    public Viagem () {
    
    }
    
    public Viagem(Veiculo veiculo, Usuario motorista, 
            Cidade cidadeOrigem, Date dataSaida, String localSaida, 
            Cidade cidadeRetorno,Date dataRetorno, String localRetorno,
            String percurso, String observacoes, Situacao situacao, List<SolicitacaoViagem> solicitacoes) {
        this.veiculo = veiculo;
        this.motorista = motorista;
        this.cidadeOrigem = cidadeOrigem;
        this.dataSaida = dataSaida;
        this.localSaida = localSaida;
        this.cidadeRetorno = cidadeRetorno;
        this.dataRetorno = dataRetorno;
        this.localRetorno = localRetorno;
        this.percurso = percurso;
        this.observacoes = observacoes;
        this.situacao = situacao;
        this.solicitacoes = solicitacoes;
    }

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the veiculo
     */
    public Veiculo getVeiculo() {
        return veiculo;
    }

    /**
     * @param veiculo the veiculo to set
     */
    public void setVeiculo(Veiculo veiculo) {
        this.veiculo = veiculo;
    }

    /**
     * @return the motorista
     */
    public Usuario getMotorista() {
        return motorista;
    }

    /**
     * @param motorista the motorista to set
     */
    public void setMotorista(Usuario motorista) {
        this.motorista = motorista;
    }

    /**
     * @return the cidadeOrigem
     */
    public Cidade getCidadeOrigem() {
        return cidadeOrigem;
    }

    /**
     * @param cidadeOrigem the cidadeOrigem to set
     */
    public void setCidadeOrigem(Cidade cidadeOrigem) {
        this.cidadeOrigem = cidadeOrigem;
    }

    /**
     * @return the dataSaida
     */
    public Date getDataSaida() {
        return dataSaida;
    }

    /**
     * @param dataSaida the dataSaida to set
     */
    public void setDataSaida(Date dataSaida) {
        this.dataSaida = dataSaida;
    }

    /**
     * @return the localSaida
     */
    public String getLocalSaida() {
        return localSaida;
    }

    /**
     * @param localSaida the localSaida to set
     */
    public void setLocalSaida(String localSaida) {
        this.localSaida = localSaida;
    }

    /**
     * @return the cidadeRetorno
     */
    public Cidade getCidadeRetorno() {
        return cidadeRetorno;
    }

    /**
     * @param cidadeRetorno the cidadeRetorno to set
     */
    public void setCidadeRetorno(Cidade cidadeRetorno) {
        this.cidadeRetorno = cidadeRetorno;
    }

    /**
     * @return the dataRetorno
     */
    public Date getDataRetorno() {
        return dataRetorno;
    }

    /**
     * @param dataRetorno the dataRetorno to set
     */
    public void setDataRetorno(Date dataRetorno) {
        this.dataRetorno = dataRetorno;
    }

    /**
     * @return the localRetorno
     */
    public String getLocalRetorno() {
        return localRetorno;
    }

    /**
     * @param localRetorno the localRetorno to set
     */
    public void setLocalRetorno(String localRetorno) {
        this.localRetorno = localRetorno;
    }

    /**
     * @return the percurso
     */
    public String getPercurso() {
        return percurso;
    }

    /**
     * @param percurso the percurso to set
     */
    public void setPercurso(String percurso) {
        this.percurso = percurso;
    }

    /**
     * @return the observacoes
     */
    public String getObservacoes() {
        return observacoes;
    }

    /**
     * @param observacoes the observacoes to set
     */
    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    /**
     * @return the situacao
     */
    public Situacao getSituacao() {
        return situacao;
    }

    /**
     * @param situacao the situacao to set
     */
    public void setSituacao(Situacao situacao) {
        this.situacao = situacao;
    }

    /**
     * 
     * @return justificativaRejeite
     */
    public String getJustificativaRejeite() {
        return justificativaRejeite;
    }

    /**
     * 
     * @param justificativaRejeite 
     */
    public void setJustificativaRejeite(String justificativaRejeite) {
        this.justificativaRejeite = justificativaRejeite;
    }

    /**
     * 
     * @return dataInicioReal
     */
    public Date getDataInicioReal() {
        return dataInicioReal;
    }

    
    /**
     * 
     * @param dataInicioReal 
     */
    public void setDataInicioReal(Date dataInicioReal) {
        this.dataInicioReal = dataInicioReal;
    }

    /**
     * 
     * @return kilometragemInicio
     */
    public Integer getKilometragemInicio() {
        return kilometragemInicio;
    }

    /**
     * 
     * @param kilometragemInicio 
     */
    public void setKilometragemInicio(Integer kilometragemInicio) {
        this.kilometragemInicio = kilometragemInicio;
    }

    /**
     * 
     * @return dataFimReal
     */
    public Date getDataFimReal() {
        return dataFimReal;
    }

    /**
     * 
     * @param dataFimReal 
     */
    public void setDataFimReal(Date dataFimReal) {
        this.dataFimReal = dataFimReal;
    }

    /**
     * 
     * @return kilometragemFim
     */
    public Integer getKilometragemFim() {
        return kilometragemFim;
    }

    /**
     * 
     * @param kilometragemFim 
     */
    public void setKilometragemFim(Integer kilometragemFim) {
        this.kilometragemFim = kilometragemFim;
    }

    /**
     * 
     * @return observacoesPercurso
     */
    public String getObservacoesPercurso() {
        return observacoesPercurso;
    }

    /**
     * 
     * @param observacoesPercurso 
     */
    public void setObservacoesPercurso(String observacoesPercurso) {
        this.observacoesPercurso = observacoesPercurso;
    }
    
    

    /**
     * @return the solicitacoes
     */
    public List<SolicitacaoViagem> getSolicitacoes() {
        return solicitacoes;
    }

    /**
     * @param solicitacoes the solicitacoes to set
     */
    public void setSolicitacoes(List<SolicitacaoViagem> solicitacoes) {
        this.solicitacoes = solicitacoes;
    }
    
}
