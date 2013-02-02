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
import model.entity.OpicionalVeiculo;
import model.entity.Veiculo;
import model.entity.Veiculo_opcional_veiculo;

/**
 *
 * @author Marcelo Maia
 */
public class Veiculo_opcional_veiculoDAO {
    private Connection connection;
    private Veiculo_opcional_veiculoDAO veiculo_opcional_veiculoDAO;
    
    public Veiculo_opcional_veiculoDAO(){
      try {
            this.connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void inserir(int id_veiculo, OpicionalVeiculo opicionalVeiculo){
        String sql = "insert into veiculo_opcionais_veiculo (id_veiculo,id_opcionais_veiculo) values (?,?)";
        System.out.println("Id do veiculo : "+id_veiculo);
        try {
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1,id_veiculo);
        stmt.setInt(2,opicionalVeiculo.getId());
        stmt.execute();
        stmt.close();
        }
        catch(SQLException e){
            e.printStackTrace();
        
        }
    }
    
    public List<Integer> getPorIdVeiculo(int id_veiculo){
        String sql = "select * from veiculo_opcionais_veiculo where id_veiculo=?;";
        List<Integer> lista = new ArrayList<Integer>() ;
        try {
            
            PreparedStatement stmt = this.connection.prepareStatement(sql);
            stmt.setInt(1, id_veiculo);
            ResultSet rs = stmt.executeQuery();
            int posicao = 0;
            while (rs.next()) {
                lista.add(posicao,rs.getInt("id_opcionais_veiculo"));
                posicao++;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    
    
}