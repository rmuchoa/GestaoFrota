/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.sql.SQLException;
import jdbc.ConnectionFactory;

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
    
   
    
}
