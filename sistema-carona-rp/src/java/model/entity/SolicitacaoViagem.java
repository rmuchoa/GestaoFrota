/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.entity;

/**
 *
 * @author Marcelo Maia
 */
public class SolicitacaoViagem {
    private Integer id;
    private Usuario usuario;
    private String data_saida;
    private String logal_saida;
    private String data_retorno;
    private String local_retorno;
    private String justificativa;
    private String observacoes;
    private Integer id_origem;
    private Integer id_destino;
    private Integer numero_pessoas;
    private String percurso;
    private SituacaoSolicitacao situacaoSolicitacao;
    private Boolean ehservidor;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getData_saida() {
        return data_saida;
    }

    public void setData_saida(String data_saida) {
        this.data_saida = data_saida;
    }

    public String getLogal_saida() {
        return logal_saida;
    }

    public void setLogal_saida(String logal_saida) {
        this.logal_saida = logal_saida;
    }

    public String getData_retorno() {
        return data_retorno;
    }

    public void setData_retorno(String data_retorno) {
        this.data_retorno = data_retorno;
    }

    public String getLocal_retorno() {
        return local_retorno;
    }

    public void setLocal_retorno(String local_retorno) {
        this.local_retorno = local_retorno;
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

    public Integer getOrigem() {
        return id_origem;
    }

    public void setOrigem(Integer id_origem) {
        this.id_origem = id_origem;
    }

    public Integer getDestino() {
        return id_destino;
    }

    public void setDestino(Integer id_destino) {
        this.id_destino = id_destino;
    }

    public Integer getNumero_pessoas() {
        return numero_pessoas;
    }

    public void setNumero_pessoas(Integer numero_pessoas) {
        this.numero_pessoas = numero_pessoas;
    }

    public String getPercurso() {
        return percurso;
    }

    public void setPercurso(String percurso) {
        this.percurso = percurso;
    }

    public SituacaoSolicitacao getSituacaoSolicitacao() {
        return situacaoSolicitacao;
    }

    public void setSituacaoSolicitacao(SituacaoSolicitacao situacaoSolicitacao) {
        this.situacaoSolicitacao = situacaoSolicitacao;
    }

    public Boolean getEhservidor() {
        return ehservidor;
    }

    public void setEhservidor(Boolean ehservidor) {
        this.ehservidor = ehservidor;
    }
    
    
    
    
}
