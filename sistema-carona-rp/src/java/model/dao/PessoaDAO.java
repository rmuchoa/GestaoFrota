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
import model.entity.Pessoa;

/**
 *
 * @author Marcelo Maia
 */
public class PessoaDAO {
    
   private Connection connection;
    
   public PessoaDAO() {
   try {
            this.connection = new ConnectionFactory() {

       }.getConnection();
    } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }
   
    public void inserir(Pessoa pessoa) {
        String sql = "insert into pessoa (id_pessoa, "
                + "nome, idade) values (?,?,?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            
            stmt.setInt(1, pessoa.getId_pessoa());
            stmt.setString(2, pessoa.getNome());
            stmt.setInt(3, pessoa.getIdade());
            stmt.execute();
            stmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
