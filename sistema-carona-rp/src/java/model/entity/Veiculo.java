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
    private Integer capacidadePassageiros;
    private Integer capacidadeCarga;
    private TipoVeiculo tipoVeiculo;

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

    public Integer getCapacidadePassageiros() {
        return capacidadePassageiros;
    }

    public void setCapacidadePassageiros(Integer capacidadePassageiros) {
        this.capacidadePassageiros = capacidadePassageiros;
    }

    public Integer getCapacidadeCarga() {
        return capacidadeCarga;
    }

    public void setCapacidadeCarga(Integer capacidadeCarga) {
        this.capacidadeCarga = capacidadeCarga;
    }

    public TipoVeiculo getTipoVeiculo() {
        return tipoVeiculo;
    }

    public void setTipoVeiculo(TipoVeiculo tipoVeiculo) {
        this.tipoVeiculo = tipoVeiculo;
    }
    
    
    
    
    
}
