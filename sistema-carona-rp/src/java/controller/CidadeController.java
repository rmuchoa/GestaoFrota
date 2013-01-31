/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.dao.CidadeDAO;
import model.entity.Cidade;

/**
 *
 * @author renanmarceluchoa
 */
public class CidadeController {
    
    CidadeDAO tipoUsuarioDao = new CidadeDAO();
    Cidade tipoVeiculo = new Cidade();

    public List<Cidade> listar() {
        return tipoUsuarioDao.listar();
    }
    
}
