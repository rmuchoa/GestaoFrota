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
import model.dao.OpicionalVeiculoDAO;
import model.dao.TipoVeiculoDAO;
import model.dao.VeiculoDAO;
import model.dao.Veiculo_opcional_veiculoDAO;
import model.entity.OpicionalVeiculo;
import model.entity.Veiculo;
/**
 *
 * @author Marcelo Maia
 */
public class VeiculoController {
    
    private Veiculo veiculo = new Veiculo();
    private VeiculoDAO veiculoDAO = new VeiculoDAO();
    private TipoVeiculoDAO tipoVeiculoDAO = new TipoVeiculoDAO();
    private OpicionalVeiculoDAO opicionalVeiculoDAO;
    private OpicionalVeiculo opicionalVeiculo;
    private List<OpicionalVeiculo> listaDeOpcional;
    private Veiculo_opcional_veiculoDAO veiculo_opcional_veiculoDAO;
    
    
    
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
       
        
        Veiculo v = veiculoDAO.inserir(veiculo);
        verificaOpcionaisSelecionados(request,v);
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
        veiculo_opcional_veiculoDAO = new Veiculo_opcional_veiculoDAO();
        veiculo_opcional_veiculoDAO.remover(veiculo.getId());
        Veiculo v = veiculoDAO.alterarVeiculo(veiculo);
        verificaOpcionaisSelecionados(request,v);
        
         
        
    }
    
    private void verificaOpcionaisSelecionados(HttpServletRequest request, Veiculo v){
       
        this.opicionalVeiculoDAO = new OpicionalVeiculoDAO();
        listaDeOpcional = this.opicionalVeiculoDAO.getTodosOpcionais();
        System.out.println("Tamnhanho da lista:"+listaDeOpcional.size());
       
        for(int i =0;i<listaDeOpcional.size();i++){
          if(request.getParameter(listaDeOpcional.get(i).getId().toString())!=null){
              System.out.println("O opicional é: "+request.getParameter(listaDeOpcional.get(i).getId().toString()));
              this.veiculo_opcional_veiculoDAO = new Veiculo_opcional_veiculoDAO();
              this.veiculo_opcional_veiculoDAO.inserir(v.getId(), listaDeOpcional.get(i));
          }
        }
    }
}

