/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.entity;

/**
 *
 * @author renanmarceluchoa
 */
public class Passageiro {
    
    private Integer id;
    private String nome;
    private String rg;
    private Boolean ehServidor;
    
    public Passageiro() {
        
    }
    
    public Integer getId() {
        return id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the nome
     */
    public String getNome() {
        return nome;
    }

    /**
     * @param nome the nome to set
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * @return the rg
     */
    public String getRg() {
        return rg;
    }

    /**
     * @param rg the rg to set
     */
    public void setRg(String rg) {
        this.rg = rg;
    }

    /**
     * @return the ehServidor
     */
    public Boolean getEhServidor() {
        return ehServidor;
    }

    /**
     * @param ehServidor the ehServidor to set
     */
    public void setEhServidor(Boolean ehServidor) {
        this.ehServidor = ehServidor;
    }
    
}
