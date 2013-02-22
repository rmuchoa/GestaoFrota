/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import jdbc.ConnectionFactory;
import model.entity.SolicitacaoViagem;
import model.entity.Viagem;

/**
 *
 * @author renanmarceluchoa
 */
public class ViagemDAO {
    
    private Connection connection;
    
    public ViagemDAO() {
        try {
            this.connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Viagem buscarPorId(Integer id) {
        
        Viagem viagem = null;
        String sql = "select * from viagem where id = ?";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                
                viagem = new Viagem();
                viagem.setId(rs.getInt("id"));
                viagem.setVeiculo(new VeiculoDAO().getVeiculoPorId(rs.getInt("veiculo")));
                viagem.setMotorista(new UsuarioDAO().buscarPorId(rs.getInt("motorista")));
                viagem.setCidadeOrigem(new CidadeDAO().buscarPorId(rs.getInt("cidade_origem")));
                viagem.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                viagem.setLocalSaida(rs.getString("local_saida"));
                viagem.setCidadeRetorno(new CidadeDAO().buscarPorId(rs.getInt("cidade_retorno")));
                viagem.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                viagem.setLocalRetorno(rs.getString("local_retorno"));
                viagem.setPercurso(rs.getString("percurso"));
                viagem.setObservacoes(rs.getString("observacoes"));
                viagem.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao_viagem")));
                viagem.setSolicitacoes(new SolicitacaoViagemDAO().buscarPorViagemId(viagem.getId()));
                
                return viagem;
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public List<Viagem> buscarPorDataSaida(Date dataSaida) {
        
        List<Viagem> viagens = new ArrayList<Viagem>();
        String sql = "select * from viagem where data_saida >= ?";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setDate(1, new java.sql.Date(dataSaida.getTime()));
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                Viagem viagem = new Viagem();
                viagem.setId(rs.getInt("id"));
                viagem.setVeiculo(new VeiculoDAO().getVeiculoPorId(rs.getInt("veiculo")));
                viagem.setMotorista(new UsuarioDAO().buscarPorId(rs.getInt("motorista")));
                viagem.setCidadeOrigem(new CidadeDAO().buscarPorId(rs.getInt("cidade_origem")));
                viagem.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                viagem.setLocalSaida(rs.getString("local_saida"));
                viagem.setCidadeRetorno(new CidadeDAO().buscarPorId(rs.getInt("cidade_retorno")));
                viagem.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                viagem.setLocalRetorno(rs.getString("local_retorno"));
                viagem.setPercurso(rs.getString("percurso"));
                viagem.setObservacoes(rs.getString("observacoes"));
                viagem.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao_viagem")));
                viagem.setSolicitacoes(new SolicitacaoViagemDAO().buscarPorViagemId(viagem.getId()));
                
                viagens.add(viagem);
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
                
        return null;
    }
    
    public List<Viagem> listarViagens() {
        
        List<Viagem> viagens = new ArrayList<Viagem>();
        String sql = "select * from viagem";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                Viagem viagem = new Viagem();
                viagem.setId(rs.getInt("id"));
                viagem.setVeiculo(new VeiculoDAO().getVeiculoPorId(rs.getInt("veiculo")));
                viagem.setMotorista(new UsuarioDAO().buscarPorId(rs.getInt("motorista")));
                viagem.setCidadeOrigem(new CidadeDAO().buscarPorId(rs.getInt("cidade_origem")));
                viagem.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                viagem.setLocalSaida(rs.getString("local_saida"));
                viagem.setCidadeRetorno(new CidadeDAO().buscarPorId(rs.getInt("cidade_retorno")));
                viagem.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                viagem.setLocalRetorno(rs.getString("local_retorno"));
                viagem.setPercurso(rs.getString("percurso"));
                viagem.setObservacoes(rs.getString("observacoes"));
                viagem.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao_viagem")));
                viagem.setSolicitacoes(new SolicitacaoViagemDAO().buscarPorViagemId(viagem.getId()));
                
                viagens.add(viagem);
                
            }
            
            stmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public Viagem abrirViagem(Viagem viagem) {
        
        String sql = "insert into viagem (veiculo, motorista, cidade_origem, data_saida, local_saida, "
                + "cidade_retorno, data_retorno, local_retorno, percurso, observacoes, situacao_viagem)"
                + " values (?,?,?,?,?,?,?,?,?,?,?)";
             
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, viagem.getVeiculo().getId());
            stmt.setInt(2, viagem.getMotorista().getId());
            stmt.setInt(3, viagem.getCidadeOrigem().getId());
            stmt.setDate(4, new java.sql.Date(viagem.getDataSaida().getTime()));
            stmt.setString(5, viagem.getLocalSaida());
            stmt.setInt(6, viagem.getCidadeRetorno().getId());
            stmt.setDate(7, new java.sql.Date(viagem.getDataRetorno().getTime()));
            stmt.setString(8, viagem.getLocalRetorno());
            stmt.setString(9, viagem.getPercurso());
            stmt.setString(10, viagem.getObservacoes());
            stmt.setInt(11, viagem.getSituacao().getId());
            stmt.executeUpdate();
            
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                
                viagem.setId(rs.getInt(1));
                if (!viagem.getSolicitacoes().isEmpty()) {
                    for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {

                        try {
                        
                            String sql2 = "update solicitacao_viagem set viagem = ?, situacao_solicitacao = ? where id = ?";
                            stmt = connection.prepareStatement(sql2);
                            stmt.setInt(1, viagem.getId());
                            stmt.setInt(2, solicitacao.getSituacao().getId());
                            stmt.setInt(3, solicitacao.getId());
                            stmt.executeUpdate();
                            
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        
                    }
                }
                stmt.close();
                return viagem;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
        
    }
    
    public Boolean alterarSituacaoViagem(Viagem viagem) {
        
        String sql = "update viagem set situacao_viagem = ? where id = ?";
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, viagem.getSituacao().getId());
            stmt.setInt(2, viagem.getId());
            stmt.executeUpdate();
            stmt.close();
            return Boolean.TRUE;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return Boolean.FALSE;
        
    }
    
}
