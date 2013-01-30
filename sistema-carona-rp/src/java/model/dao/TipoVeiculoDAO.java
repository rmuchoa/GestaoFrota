/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jdbc.ConnectionFactory;
import model.entity.TipoVeiculo;
import model.entity.Veiculo;

/**
 *
 * @author Marcelo Maia
 */
public class TipoVeiculoDAO {
   
    private Connection connection;
    
    public TipoVeiculoDAO(){
        try {
            this.connection = new ConnectionFactory() {

       }.getConnection();
    } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void inserirTipoVeiculo(TipoVeiculo tipoVeiculo){
    
       
        String sql = "insert into tipo_veiculo ("
                + "descricao) values (?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setString(1, tipoVeiculo.getDescricao());
            stmt.execute();
            stmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
    }
    
    
    public List<TipoVeiculo> listarTodos(){
        TipoVeiculo tipoVeiculo;
        List<TipoVeiculo> lista = new ArrayList<TipoVeiculo>();
        int posicao = 0;
        
        String sql = "select * from tipo_veiculo";
         try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                tipoVeiculo = new TipoVeiculo();
                tipoVeiculo.setId(rs.getInt("id"));
                tipoVeiculo.setDescricao(rs.getString("descricao"));
                lista.add(posicao,tipoVeiculo);
                posicao++;
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
         
         return lista;
    }
    
     public TipoVeiculo getTipoPorDescricao(String descricao){
        TipoVeiculo  tipoVeiculo = new TipoVeiculo();
        
        String sql = "select * from tipo_veiculo where descricao = ?";
         try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, descricao);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
               
                tipoVeiculo.setId(rs.getInt("id"));
                tipoVeiculo.setDescricao(rs.getString("descricao"));
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
         
         return tipoVeiculo;
    }
     
     
     public TipoVeiculo getTipoPorID(int id){
        TipoVeiculo  tipoVeiculo = new TipoVeiculo();
        
        String sql = "select * from tipo_veiculo where id = ?";
         try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
               
                tipoVeiculo.setId(rs.getInt("id"));
                tipoVeiculo.setDescricao(rs.getString("descricao"));
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
         
         return tipoVeiculo;
    }
    
   
}
