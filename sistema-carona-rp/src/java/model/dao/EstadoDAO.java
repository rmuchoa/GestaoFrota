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
import model.entity.Estado;

/**
 *
 * @author renanmarceluchoa
 */
public class EstadoDAO {
    
    private Connection connection;
    
    public EstadoDAO(){
       try {
            this.connection = ConnectionFactory.getConnection();
    } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Estado buscarPorId(Integer id) {
        
        Estado estado = null;
        String sql = "select * from estado where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                estado = new Estado();
                estado.setId(rs.getInt("id"));
                estado.setNome(rs.getString("nome"));
                estado.setSigla(rs.getString("sigla"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return estado;
        
    }

    public Estado buscarPorNome(String nomeEstado) {
        
        Estado estado = null;
        String sql = "select * from estado where nome = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, nomeEstado);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                estado = new Estado();
                estado.setId(rs.getInt("id"));
                estado.setNome(rs.getString("nome"));
                estado.setSigla(rs.getString("sigla"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return estado;
        
    }

    public Estado buscarPorSigla(String siglaEstado) {
        
        Estado estado = null;
        String sql = "select * from estado where sigla = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, siglaEstado);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                estado = new Estado();
                estado.setId(rs.getInt("id"));
                estado.setNome(rs.getString("nome"));
                estado.setSigla(rs.getString("sigla"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return estado;
        
    }

    public List<Estado> listar() {
        
        List<Estado> lista = new ArrayList<Estado>();
        String sql = "select * from estado";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                Estado estado = new Estado();
                estado.setId(rs.getInt("id"));
                estado.setNome(rs.getString("nome"));
                estado.setSigla(rs.getString("sigla"));

                lista.add(estado);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
        
    }
    
}
