/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.dao.TipoVeiculoDAO;
import model.entity.TipoVeiculo;

/**
 *
 * @author Marcelo Maia
 */
public class TipoVeiculoController {
    
    TipoVeiculoDAO tipoVeiculoDao = new TipoVeiculoDAO();
    TipoVeiculo tipoVeiculo = new TipoVeiculo();
    
    public List listarTodosTiposVeiculos(){
      return tipoVeiculoDao.listarTodos();
    }
    
    
    
    
}
