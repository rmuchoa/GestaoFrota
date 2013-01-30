/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Response;
import model.dao.TipoVeiculoDAO;
import model.dao.VeiculoDAO;
import model.entity.Veiculo;
/**
 *
 * @author Marcelo Maia
 */
public class VeiculoController {
    
    private Veiculo veiculo = new Veiculo();
    private VeiculoDAO veiculoDAO = new VeiculoDAO();
    private TipoVeiculoDAO tipoVeiculoDAO = new TipoVeiculoDAO();

    
    
    
    public void inserirVeiculo(HttpServletRequest request){
        
        veiculo.setPlaca(request.getParameter("placa"));
        veiculo.setRenavam(Integer.parseInt(request.getParameter("renavan")));
        veiculo.setMarca(request.getParameter("marca"));
        veiculo.setModelo(request.getParameter("modelo"));
        veiculo.setCor(request.getParameter("cor"));
        veiculo.setAno(Integer.parseInt(request.getParameter("ano")));
        veiculo.setCapacidade_passageiros(Integer.parseInt(request.getParameter("capacidade_passageiros")));
        veiculo.setCapacidade_carga(Integer.parseInt(request.getParameter("capacidade_carga")));
        veiculo.setTipo_veiculo(tipoVeiculoDAO.getTipoPorDescricao(request.getParameter("tipo_veiculo")));
        veiculoDAO = new VeiculoDAO();
        
        veiculoDAO.inserir(veiculo);
    }
    
    
    public void alterarVeiculo(HttpServletRequest request){
        System.out.println(" Marca"+veiculo.getMarca()+" Tipo:"+veiculo.getTipo_veiculo());
        veiculo.setPlaca(request.getParameter("placa"));
        veiculo.setRenavam(Integer.parseInt(request.getParameter("renavan")));
        veiculo.setMarca(request.getParameter("marca"));
        veiculo.setModelo(request.getParameter("modelo"));
        veiculo.setCor(request.getParameter("cor"));
        veiculo.setAno(Integer.parseInt(request.getParameter("ano")));
        //
        //
        veiculo.setCapacidade_passageiros(Integer.parseInt(request.getParameter("capacidade_passageiros")));
        veiculo.setCapacidade_carga( Integer.parseInt(request.getParameter("capacidade_carga")));
        veiculo.setTipo_veiculo(tipoVeiculoDAO.getTipoPorDescricao(request.getParameter("tipo_veiculo")));
        
        veiculo.setId(Integer.parseInt(request.getParameter("id")));
        veiculoDAO = new VeiculoDAO();
        veiculoDAO.alterarImovel(veiculo);
        
         
        
    }
}

