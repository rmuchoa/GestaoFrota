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
import model.entity.TipoUsuario;

/**
 *
 * @author renanmarceluchoa
 */
public class TipoUsuarioDAO {

    private Connection connection;
  
    
    public TipoUsuarioDAO(){
       try {
            this.connection = ConnectionFactory.getConnection();
    } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public TipoUsuario buscarPorId(int id) {
        
        TipoUsuario tipoUsuario = null;
        String sql = "select * from tipo_usuario where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                tipoUsuario = new TipoUsuario();
                tipoUsuario.setId(rs.getInt("id"));
                tipoUsuario.setDescricao(rs.getString("descricao"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return tipoUsuario;
    }

    public TipoUsuario buscarPorDescricao(String descricao) {
        
        TipoUsuario tipoUsuario = null;
        String sql = "select * from tipo_usuario where descricao = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, descricao);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                tipoUsuario = new TipoUsuario();
                tipoUsuario.setId(rs.getInt("id"));
                tipoUsuario.setDescricao(rs.getString("descricao"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return tipoUsuario;
        
    }

    public List<TipoUsuario> listar() {
        
        List<TipoUsuario> lista = new ArrayList<TipoUsuario>();
        String sql = "select * from tipo_usuario";
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                TipoUsuario tipoUsuario = new TipoUsuario();
                tipoUsuario.setId(rs.getInt("id"));
                tipoUsuario.setDescricao(rs.getString("descricao"));

                lista.add(tipoUsuario);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
        
    }
    
}
