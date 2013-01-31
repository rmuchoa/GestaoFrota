/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.dao.TipoUsuarioDAO;
import model.entity.TipoUsuario;

/**
 *
 * @author renanmarceluchoa
 */
public class TipoUsuarioController {

    TipoUsuarioDAO tipoUsuarioDao = new TipoUsuarioDAO();
    TipoUsuario tipoVeiculo = new TipoUsuario();

    public List<TipoUsuario> listar() {
        return tipoUsuarioDao.listar();
    }
}
