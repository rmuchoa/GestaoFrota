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
import model.entity.Cidade;
import model.entity.TipoUsuario;

/**
 *
 * @author renanmarceluchoa
 */
public class CidadeDAO {

    private Connection connection;
  
    
    public CidadeDAO(){
       try {
            this.connection = ConnectionFactory.getConnection();
    } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Cidade buscarPorId(int id) {
        
        Cidade cidade = new Cidade();
        String sql = "select * from cidade where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                EstadoDAO estadoDAO = new EstadoDAO();
                
                cidade.setId(rs.getInt("id"));
                cidade.setNome(rs.getString("nome"));
                cidade.setEstado(estadoDAO.buscarPorId(rs.getInt("estado")));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cidade;
        
    }

    public Cidade buscarPorNome(String nome) {
        
        Cidade cidade = new Cidade();
        String sql = "select * from cidade where nome = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, nome);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                EstadoDAO estadoDAO = new EstadoDAO();
                
                cidade.setId(rs.getInt("id"));
                cidade.setNome(rs.getString("nome"));
                cidade.setEstado(estadoDAO.buscarPorId(rs.getInt("estado")));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cidade;
        
    }

    public List<Cidade> listar() {
        
        List<Cidade> lista = new ArrayList<Cidade>();
        String sql = "select * from cidade";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                EstadoDAO estadoDAO = new EstadoDAO();
                
                Cidade cidade = new Cidade();
                cidade.setId(rs.getInt("id"));
                cidade.setNome(rs.getString("nome"));
                cidade.setEstado(estadoDAO.buscarPorId(rs.getInt("estado")));

                lista.add(cidade);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
        
    }
    
}
