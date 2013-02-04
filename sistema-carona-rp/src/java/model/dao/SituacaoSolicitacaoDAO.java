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
import jdbc.ConnectionFactory;
import model.entity.SituacaoSolicitacao;

/**
 *
 * @author Marcelo Maia
 */
public class SituacaoSolicitacaoDAO {

    private Connection connection;

    public SituacaoSolicitacaoDAO() {
        try {
            this.connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public SituacaoSolicitacao buscarPorId(Integer id) {
        
        SituacaoSolicitacao situacao = null;
        String sql = "select * from situacao_solicitacao where id = ?";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                situacao = new SituacaoSolicitacao();
                situacao.setId(rs.getInt("id"));
                situacao.setDescricao(rs.getString("descricao"));
                
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(SituacaoSolicitacaoDAO.class.getName()).log(Level.SEVERE, null, ex);
        }    
        
        return situacao;
    
    }
    
}
