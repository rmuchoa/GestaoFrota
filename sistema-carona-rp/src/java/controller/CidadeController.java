/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.dao.CidadeDAO;
import model.dao.EstadoDAO;
import model.entity.Cidade;
import model.entity.Estado;

/**
 *
 * @author renanmarceluchoa
 */
public class CidadeController {

    EstadoDAO estadoDAO = new EstadoDAO();
    CidadeDAO cidadeDAO = new CidadeDAO();
    Cidade cidade = new Cidade();

    public List<Cidade> listar() {
        return cidadeDAO.listar();
    }

    public List<Cidade> listarPorEstado(Estado estado) {
        return cidadeDAO.listarPorEstado(estado);
    }
}
