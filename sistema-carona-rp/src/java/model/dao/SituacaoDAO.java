/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.ConnectionFactory;
import model.entity.Situacao;

/**
 *
 * @author Marcelo Maia
 */
public class SituacaoDAO {

    private Connection connection;

    public SituacaoDAO() {
        try {
            this.connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Situacao buscarPorId(Integer id) {
        
        Situacao situacao = null;
        String sql = "select * from situacao where id = ?";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                situacao = new Situacao();
                situacao.setId(rs.getInt("id"));
                situacao.setDescricao(rs.getString("descricao"));
                
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(SituacaoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        
        return situacao;
    
    }

    public Situacao buscarPorDescricao(String descricao) {
        
        Situacao situacao = null;
        String sql = "select * from situacao where descricao = ?";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, descricao);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                situacao = new Situacao();
                situacao.setId(rs.getInt("id"));
                situacao.setDescricao(rs.getString("descricao"));
                
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(SituacaoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        
        return situacao;
        
    }
    
}
