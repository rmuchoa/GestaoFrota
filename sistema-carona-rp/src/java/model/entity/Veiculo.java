/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.entity;

/**
 *
 * @author Marcelo Maia
 */
public class Veiculo {
    
    private Integer id;
    private String placa;
    private Long renavam;
    private String cor;
    private String modelo;
    private String marca;
    private Integer ano;
    private Integer capacidade_passageiros;
    private Integer capacidade_carga;
    private TipoVeiculo tipo_veiculo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPlaca() {
        return placa;
    }

    public void setPlaca(String placa) {
        this.placa = placa;
    }

    public Long getRenavam() {
        return renavam;
    }

    public void setRenavam(Long renavam) {
        this.renavam = renavam;
    }

    public String getCor() {
        return cor;
    }

    public void setCor(String cor) {
        this.cor = cor;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public Integer getAno() {
        return ano;
    }

    public void setAno(Integer ano) {
        this.ano = ano;
    }

    public Integer getCapacidade_passageiros() {
        return capacidade_passageiros;
    }

    public void setCapacidade_passageiros(Integer capacidade_passageiros) {
        this.capacidade_passageiros = capacidade_passageiros;
    }

    public Integer getCapacidade_carga() {
        return capacidade_carga;
    }

    public void setCapacidade_carga(Integer capacidade_carga) {
        this.capacidade_carga = capacidade_carga;
    }

    public TipoVeiculo getTipo_veiculo() {
        return tipo_veiculo;
    }

    public void setTipo_veiculo(TipoVeiculo tipo_veiculo) {
        this.tipo_veiculo = tipo_veiculo;
    }
    
    
    
    
    
}
