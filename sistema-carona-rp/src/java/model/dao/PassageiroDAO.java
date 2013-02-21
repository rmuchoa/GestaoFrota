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
import model.entity.Passageiro;
import model.entity.SolicitacaoViagem;
import model.entity.Usuario;

/**
 *
 * @author renanmarceluchoa
 */
public class PassageiroDAO {
    
    private Connection connection;
  
    
    public PassageiroDAO(){
       try {
            this.connection = ConnectionFactory.getConnection();
    } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Passageiro buscarPorRg(String rg) {
        
        Passageiro passageiro = null;
        String sql = "select * from passageiro where rg = ?";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, rg);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                passageiro = new Passageiro();
                passageiro.setId(rs.getInt("id"));
                passageiro.setNome(rs.getString("nome"));
                passageiro.setRg(rs.getString("rg"));
                passageiro.setEmail(rs.getString("email"));
                passageiro.setEndereco(rs.getString("endereco"));
                passageiro.setServidor(rs.getBoolean("eh_servidor"));
                
            }
            
        } catch(SQLException e) {
            e.printStackTrace();
        }
        
        return passageiro;
        
    }
    
    public Passageiro inserir(Passageiro passageiro) {
        
        String sql = "insert into passageiro ("
                + "nome, rg, email, endereco, eh_servidor) values (?,?,?,?,?)";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, passageiro.getNome());
            stmt.setString(2, passageiro.getRg());
            stmt.setString(3, passageiro.getEmail());
            stmt.setString(4, passageiro.getEndereco());
            stmt.setBoolean(5, passageiro.isServidor());
            stmt.execute();
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return buscarPorRg(passageiro.getRg());
        
    }
    
    public Passageiro inserir(Usuario passageiro) {
        
        String sql = "insert into passageiro ("
                + "nome, rg, email, endereco, eh_servidor) values (?,?,?,?,?)";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, passageiro.getNome());
            stmt.setString(2, passageiro.getRg());
            stmt.setString(3, passageiro.getEmail());
            stmt.setString(4, "Rua "+passageiro.getRua()+", "+passageiro.getNumero()+", "+passageiro.getComplemento()+" - CEP "+passageiro.getCep()+", "+passageiro.getCidade().getNome()+"/"+passageiro.getCidade().getEstado().getSigla());
            stmt.setBoolean(5, Boolean.TRUE);
            stmt.execute();
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return buscarPorRg(passageiro.getRg());
        
    }

    public Passageiro alterar(Passageiro passageiro) {
        
        String sql = "update passageiro set nome = ?, rg = ?, email = ?, endereco = ?, eh_servidor = ? where id = ?;";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, passageiro.getNome());
            stmt.setString(2, passageiro.getRg());
            stmt.setString(3, passageiro.getEmail());
            stmt.setString(4, passageiro.getEndereco());
            stmt.setBoolean(5, passageiro.isServidor());
            stmt.setInt(6, passageiro.getId());
            stmt.execute();
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return buscarPorRg(passageiro.getRg());
        
    }

    public Passageiro alterar(Usuario passageiro) {
        
        String sql = "update passageiro set nome = ?, rg = ?, email = ?, endereco = ?, eh_servidor = ? where id = ?;";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, passageiro.getNome());
            stmt.setString(2, passageiro.getRg());
            stmt.setString(3, passageiro.getEmail());
            stmt.setString(4, "Rua "+passageiro.getRua()+", "+passageiro.getNumero()+", "+passageiro.getComplemento()+" - CEP "+passageiro.getCep()+", "+passageiro.getCidade().getNome()+"/"+passageiro.getCidade().getEstado().getSigla());
            stmt.setBoolean(5, Boolean.TRUE);
            stmt.setInt(6, passageiro.getId());
            stmt.execute();
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return buscarPorRg(passageiro.getRg());
        
    }
    
    public List<Passageiro> buscarPorSolicitacaoId(Integer id) {
    
        List<Passageiro> passageiros = new ArrayList<Passageiro>();
        String sql = "select p.id, p.nome, p.rg, p.email, p.endereco, p.eh_servidor "
                + "from passageiro p, solicitacao_viagem_passageiro svp "
                + "where svp.solicitacao_viagem = ? and p.id = svp.passageiro";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                Passageiro passageiro = new Passageiro();
                passageiro.setId(rs.getInt("p.id"));
                passageiro.setNome(rs.getString("p.nome"));
                passageiro.setRg(rs.getString("p.rg"));
                passageiro.setEmail(rs.getString("p.email"));
                passageiro.setEndereco(rs.getString("p.endereco"));
                passageiro.setServidor(rs.getBoolean("p.eh_servidor"));
                
                passageiros.add(passageiro);
                
            }
            
        } catch(SQLException e) {
            e.printStackTrace();
        }
        
        return passageiros;
    
    }
    
    public void adicionarPassageiro(SolicitacaoViagem solicitacao, Passageiro passageiro) {
        
        String sql = "insert into solicitacao_viagem_passageiro values (?, ?);";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, solicitacao.getId());
            stmt.setInt(2, passageiro.getId());
            stmt.execute();
            stmt.close();
           
        } catch(SQLException e) {
            e.printStackTrace();
        }
        
    }
    
}
