/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import jdbc.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.jms.JMSException;
import javax.swing.JOptionPane;
import model.entity.TipoVeiculo;
import model.entity.Veiculo;
/**
 *
 * @author Marcelo Maia
 */
public class VeiculoDAO {
    
    private Connection connection;
    private TipoVeiculo tipoveiculo;
  
    
    public VeiculoDAO(){
       try {
            this.connection = new ConnectionFactory() {

       }.getConnection();
    } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
     public void inserir(Veiculo veiculo) {
       
        String sql = "insert into veiculo ("
                + "placa, renavam,cor,modelo,marca,ano,capacidade_passageiros,"
                + "capacidade_carga,tipo_veiculo) values (?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setString(1, veiculo.getPlaca());
            stmt.setInt(2, veiculo.getRenavam());
            stmt.setString(3, veiculo.getCor());
            stmt.setString(4, veiculo.getModelo());
            stmt.setString(5, veiculo.getMarca());
            stmt.setInt(6, veiculo.getAno());
            stmt.setInt(7, veiculo.getCapacidade_passageiros());
            stmt.setInt(8, veiculo.getCapacidade_carga());
            stmt.setInt(9, veiculo.getTipo_veiculo().getId());
            stmt.execute();
            stmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
     
     public List<Veiculo> getTodosVeiculos(){
     
         List<Veiculo> lista = new ArrayList<Veiculo>();
         String sql = "select * from veiculo";
         try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            int posicao = 0;
            while (rs.next()) {
              TipoVeiculoDAO  tipoVeiculoDAO = new TipoVeiculoDAO();
                Veiculo veiculo = new Veiculo();
                veiculo.setId(rs.getInt("id"));
                veiculo.setAno(rs.getInt("ano"));
                veiculo.setCapacidade_carga(rs.getInt("capacidade_carga"));
                veiculo.setCapacidade_passageiros(rs.getInt("capacidade_passageiros"));
                veiculo.setCor(rs.getString("cor"));
                veiculo.setMarca(rs.getString("marca"));
                veiculo.setModelo(rs.getString("modelo"));
                veiculo.setPlaca(rs.getString("placa"));
                veiculo.setRenavam(rs.getInt("renavam"));
                veiculo.setTipo_veiculo(tipoVeiculoDAO.getTipoPorID(rs.getInt("tipo_veiculo")));
                lista.add(posicao,veiculo);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
         return lista;
     }
     
     
      public Veiculo getVeiculoPorId(int id){
     
         List<Veiculo> lista = new ArrayList<Veiculo>();
         Veiculo veiculo = new Veiculo();
         String sql = "select * from veiculo where id = ?";
         try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            int posicao = 0;
            while (rs.next()) {
               TipoVeiculoDAO tipoVeiculoDAO = new TipoVeiculoDAO();
                
                veiculo.setId(rs.getInt("id"));
                veiculo.setAno(rs.getInt("ano"));
                veiculo.setCapacidade_carga(rs.getInt("capacidade_carga"));
                veiculo.setCapacidade_passageiros(rs.getInt("capacidade_passageiros"));
                veiculo.setCor(rs.getString("cor"));
                veiculo.setMarca(rs.getString("marca"));
                veiculo.setModelo(rs.getString("modelo"));
                veiculo.setPlaca(rs.getString("placa"));
                veiculo.setRenavam(rs.getInt("renavam"));
                veiculo.setTipo_veiculo(tipoVeiculoDAO.getTipoPorID(rs.getInt("tipo_veiculo")));
               
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
         return veiculo;
     }
      
      public void alterarImovel(Veiculo veiculo){
           String sql = "update veiculo set tipo_veiculo=?,placa=?,renavam=?,cor=?,modelo=?,marca=?,ano=?,capacidade_passageiros=?,capacidade_carga=? where id=?";
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setInt(1, veiculo.getTipo_veiculo().getId());
            stmt.setString(2, veiculo.getPlaca());
            stmt.setInt(3, veiculo.getRenavam());
            stmt.setString(4, veiculo.getCor());
            stmt.setString(5, veiculo.getModelo());
            stmt.setString(6, veiculo.getMarca());
            stmt.setInt(7, veiculo.getAno());
            stmt.setInt(8, veiculo.getCapacidade_passageiros());
            stmt.setInt(9, veiculo.getCapacidade_carga());
            stmt.setInt(10, veiculo.getId());
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } 
      }
      
      public void removerVeicupoPorId(int id_veiculo){
      
        String sql = "delete from veiculo where id=?";
           
        try {
            PreparedStatement stmt = this.connection.prepareStatement(sql);
            stmt.setInt(1, id_veiculo);
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
      }
}
