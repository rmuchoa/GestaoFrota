/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    
    public Estado buscarPorId(int id) {
        Estado estado = new Estado();
        String sql = "select * from estado where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                estado.setId(rs.getInt("id"));
                estado.setNome(rs.getString("nome"));
                estado.setSigla(rs.getString("sigla"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return estado;
    }
}
