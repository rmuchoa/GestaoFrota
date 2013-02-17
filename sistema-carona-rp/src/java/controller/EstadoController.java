/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.dao.EstadoDAO;
import model.entity.Estado;

/**
 *
 * @author renanmarceluchoa
 */
public class EstadoController {

    EstadoDAO estadoDAO = new EstadoDAO();
    Estado estado = new Estado();

    public List<Estado> listar() {
        return estadoDAO.listar();
    }

    public Estado buscarPorId(int id) {
        return estadoDAO.buscarPorId(id);
    }
}
