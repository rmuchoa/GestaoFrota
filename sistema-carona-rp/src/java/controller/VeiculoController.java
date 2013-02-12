/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Response;
import model.dao.OpcionalVeiculoDAO;
import model.dao.TipoVeiculoDAO;
import model.dao.VeiculoDAO;
import model.dao.VeiculoOpcionalVeiculoDAO;
import model.entity.OpcionalVeiculo;
import model.entity.Veiculo;

/**
 *
 * @author Marcelo Maia
 */
public class VeiculoController {

    private Veiculo veiculo = new Veiculo();
    private VeiculoDAO veiculoDAO = new VeiculoDAO();
    private TipoVeiculoDAO tipoVeiculoDAO = new TipoVeiculoDAO();
    private OpcionalVeiculoDAO opicionalVeiculoDAO;
    private List<OpcionalVeiculo> listaDeOpcional;
    private VeiculoOpcionalVeiculoDAO veiculoOpcionalVeiculoDAO;

    public void inserirVeiculo(HttpServletRequest request) {

        veiculo.setPlaca(request.getParameter("placa"));
        veiculo.setRenavam(Long.parseLong(request.getParameter("renavan")));
        veiculo.setMarca(request.getParameter("marca"));
        veiculo.setModelo(request.getParameter("modelo"));
        veiculo.setCor(request.getParameter("cor"));
        veiculo.setAno(Integer.parseInt(request.getParameter("ano")));
        veiculo.setCapacidadePassageiros(Integer.parseInt(request.getParameter("capacidade_passageiros")));
        veiculo.setCapacidadeCarga(Integer.parseInt(request.getParameter("capacidade_carga")));
        veiculo.setTipoVeiculo(tipoVeiculoDAO.getTipoPorId(Integer.parseInt(request.getParameter("tipo_veiculo"))));
        veiculoDAO = new VeiculoDAO();


        Veiculo v = veiculoDAO.inserir(veiculo);
        verificaOpcionaisSelecionados(request, v);
    }

    public void alterarVeiculo(HttpServletRequest request) {
        veiculo.setPlaca(request.getParameter("placa"));
        veiculo.setRenavam(Long.parseLong(request.getParameter("renavan")));
        veiculo.setMarca(request.getParameter("marca"));
        veiculo.setModelo(request.getParameter("modelo"));
        veiculo.setCor(request.getParameter("cor"));
        veiculo.setAno(Integer.parseInt(request.getParameter("ano")));
        veiculo.setCapacidadePassageiros(Integer.parseInt(request.getParameter("capacidade_passageiros")));
        veiculo.setCapacidadeCarga(Integer.parseInt(request.getParameter("capacidade_carga")));
        veiculo.setTipoVeiculo(tipoVeiculoDAO.getTipoPorId(Integer.parseInt(request.getParameter("tipo_veiculo"))));

        veiculo.setId(Integer.parseInt(request.getParameter("id")));
        veiculoDAO = new VeiculoDAO();
        veiculoOpcionalVeiculoDAO = new VeiculoOpcionalVeiculoDAO();
        veiculoOpcionalVeiculoDAO.remover(veiculo.getId());
        Veiculo v = veiculoDAO.alterarVeiculo(veiculo);
        verificaOpcionaisSelecionados(request, v);



    }

    private void verificaOpcionaisSelecionados(HttpServletRequest request, Veiculo v) {

        this.opicionalVeiculoDAO = new OpcionalVeiculoDAO();
        listaDeOpcional = this.opicionalVeiculoDAO.getTodosOpcionais();
        for (int i = 0; i < listaDeOpcional.size(); i++) {
            if (request.getParameter(listaDeOpcional.get(i).getId().toString()) != null) {
                this.veiculoOpcionalVeiculoDAO = new VeiculoOpcionalVeiculoDAO();
                this.veiculoOpcionalVeiculoDAO.inserir(v.getId(), listaDeOpcional.get(i));
            }
        }
    }
}
