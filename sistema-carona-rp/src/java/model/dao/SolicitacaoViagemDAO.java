/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import util.ConnectionFactory;
import model.entity.Passageiro;
import model.entity.Situacao;
import model.entity.SolicitacaoViagem;

/**
 *
 * @author Marcelo Maia
 */
public class SolicitacaoViagemDAO {

    private Connection connection;
    public SolicitacaoViagemDAO() {
        try {
            this.connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public List<SolicitacaoViagem> listar() {

        List<SolicitacaoViagem> solicitacoes = new ArrayList<SolicitacaoViagem>();
        String sql = "select * from solicitacao_viagem ";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                SolicitacaoViagem solicitacao = new SolicitacaoViagem();
                solicitacao.setId(rs.getInt("id"));
                solicitacao.setSolicitante(new UsuarioDAO().buscarPorId(rs.getInt("solicitante")));
                solicitacao.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                solicitacao.setLocalSaida(rs.getString("local_saida"));
                solicitacao.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                solicitacao.setLocalRetorno(rs.getString("local_retorno"));
                solicitacao.setJustificativa(rs.getString("justificativa"));
                solicitacao.setObservacoes(rs.getString("observacoes"));
                solicitacao.setOrigem(new CidadeDAO().buscarPorId(rs.getInt("origem")));
                solicitacao.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacao.setPercurso(rs.getString("percurso"));
                solicitacao.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao_solicitacao")));
                solicitacao.setPassageiro(Boolean.parseBoolean("eh_passageiro"));
                solicitacao.setPassageiros(new PassageiroDAO().buscarPorSolicitacaoId(solicitacao.getId()));
                
                solicitacoes.add(solicitacao);

            }
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return solicitacoes;

    }
    
    public SolicitacaoViagem buscarPorId(Integer id) {

        SolicitacaoViagem solicitacao = null;
        String sql = "select * from solicitacao_viagem where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                solicitacao = new SolicitacaoViagem();
                solicitacao.setId(rs.getInt("id"));
                solicitacao.setSolicitante(new UsuarioDAO().buscarPorId(rs.getInt("solicitante")));
                solicitacao.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                solicitacao.setLocalSaida(rs.getString("local_saida"));
                solicitacao.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                solicitacao.setLocalRetorno(rs.getString("local_retorno"));
                solicitacao.setJustificativa(rs.getString("justificativa"));
                solicitacao.setObservacoes(rs.getString("observacoes"));
                solicitacao.setOrigem(new CidadeDAO().buscarPorId(rs.getInt("origem")));
                solicitacao.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacao.setPercurso(rs.getString("percurso"));
                solicitacao.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao_solicitacao")));
                solicitacao.setPassageiro(Boolean.parseBoolean("eh_passageiro"));
                solicitacao.setPassageiros(new PassageiroDAO().buscarPorSolicitacaoId(solicitacao.getId()));
                solicitacao.setViagem(new ViagemDAO().buscarPorId(rs.getInt("viagem")));
                

            }
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return solicitacao;

    }

    public SolicitacaoViagem inserir(SolicitacaoViagem solicitacaoViagem) {

        String sql = "insert into solicitacao_viagem (solicitante, data_saida, local_saida, "
                + "data_retorno, local_retorno, justificativa, observacoes, "
                + "origem, destino, percurso, situacao_solicitacao, eh_passageiro )"
                + " values (?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, solicitacaoViagem.getSolicitante().getId());
            stmt.setDate(2, new java.sql.Date(solicitacaoViagem.getDataSaida().getTime()));
            stmt.setString(3, solicitacaoViagem.getLocalSaida());
            stmt.setDate(4, new java.sql.Date(solicitacaoViagem.getDataRetorno().getTime()));
            stmt.setString(5, solicitacaoViagem.getLocalRetorno());
            stmt.setString(6, solicitacaoViagem.getJustificativa());
            stmt.setString(7, solicitacaoViagem.getObservacoes());
            stmt.setInt(8, solicitacaoViagem.getOrigem().getId());
            stmt.setInt(9, solicitacaoViagem.getDestino().getId());
            stmt.setString(10, solicitacaoViagem.getPercurso());
            stmt.setInt(11, solicitacaoViagem.getSituacao().getId());
            stmt.setBoolean(12, solicitacaoViagem.isPassageiro());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                solicitacaoViagem.setId(rs.getInt(1));
                if (!solicitacaoViagem.getPassageiros().isEmpty()) {
                    new PassageiroDAO().adicionarPassageiro(solicitacaoViagem, solicitacaoViagem.getPassageiros().get(0));
                }
            }
            stmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return solicitacaoViagem;

    }
    
    public List<SolicitacaoViagem> buscarPorIntervaloDatas(Date dataInicio, Date dataFim) {
        
        List<SolicitacaoViagem> solicitacoes = new ArrayList<SolicitacaoViagem>();
        String sql = "select * from solicitacao_viagem where data_saida between ? and ?";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setDate(1, new java.sql.Date(dataInicio.getTime()));
            stmt.setDate(2, new java.sql.Date(dataFim.getTime()));
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                Integer viagemId = rs.getInt("viagem");
                if (viagemId != null && viagemId != 0) {
                    continue;
                }
                
                SolicitacaoViagem solicitacao = new SolicitacaoViagem();
                
                solicitacao.setId(rs.getInt("id"));
                solicitacao.setSolicitante(new UsuarioDAO().buscarPorId(rs.getInt("solicitante")));
                solicitacao.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                solicitacao.setLocalSaida(rs.getString("local_saida"));
                solicitacao.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                solicitacao.setLocalRetorno(rs.getString("local_retorno"));
                solicitacao.setJustificativa(rs.getString("justificativa"));
                solicitacao.setObservacoes(rs.getString("observacoes"));
                solicitacao.setOrigem(new CidadeDAO().buscarPorId(rs.getInt("origem")));
                solicitacao.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacao.setPercurso(rs.getString("percurso"));
                solicitacao.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao_solicitacao")));
                solicitacao.setPassageiro(Boolean.parseBoolean("eh_passageiro"));
                solicitacao.setViagem(new ViagemDAO().buscarPorId(rs.getInt("viagem")));
                solicitacoes.add(solicitacao);
                
            }
            
            stmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
                
        return solicitacoes;
    }

    public List<SolicitacaoViagem> buscarPorDataSaida(java.util.Date dataSaida) {

        List<SolicitacaoViagem> solicitacoes = new ArrayList<SolicitacaoViagem>();
        String sql = "select * from solicitacao_viagem where data_saida >= ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setDate(1, new java.sql.Date(dataSaida.getTime()));
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                Integer viagemId = rs.getInt("viagem");
                if (viagemId != null) {
                    continue;
                }

                SolicitacaoViagem solicitacao = new SolicitacaoViagem();
                solicitacao.setId(rs.getInt("id"));
                solicitacao.setSolicitante(new UsuarioDAO().buscarPorId(rs.getInt("solicitante")));
                solicitacao.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                solicitacao.setLocalSaida(rs.getString("local_saida"));
                solicitacao.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                solicitacao.setLocalRetorno(rs.getString("local_retorno"));
                solicitacao.setJustificativa(rs.getString("justificativa"));
                solicitacao.setObservacoes(rs.getString("observacoes"));
                solicitacao.setOrigem(new CidadeDAO().buscarPorId(rs.getInt("origem")));
                solicitacao.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacao.setPercurso(rs.getString("percurso"));
                solicitacao.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao_solicitacao")));
                solicitacao.setPassageiro(Boolean.parseBoolean("eh_passageiro"));
                solicitacao.setViagem(new ViagemDAO().buscarPorId(rs.getInt("viagem")));
                
                solicitacoes.add(solicitacao);
                
            }
            
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return solicitacoes;

    }

    public Boolean alterarSituacaoSolicitacao(SolicitacaoViagem solicitacao) {
        
        String sql = "update solicitacao_viagem set situacao_solicitacao = ? where id = ?";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, solicitacao.getSituacao().getId());
            stmt.setInt(2, solicitacao.getId());
            if (stmt.executeUpdate() >= 1) {
                stmt.close();
                return Boolean.TRUE;
            }
            
            stmt.close();
            return Boolean.FALSE;
        
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return Boolean.FALSE;
        
    }

    public List<SolicitacaoViagem> buscarPorViagemId(Integer id) {

        List<SolicitacaoViagem> solicitacoes = new ArrayList<SolicitacaoViagem>();
        String sql = "select * from solicitacao_viagem where viagem = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                SolicitacaoViagem solicitacao = new SolicitacaoViagem();
                solicitacao.setId(rs.getInt("id"));
                solicitacao.setSolicitante(new UsuarioDAO().buscarPorId(rs.getInt("solicitante")));
                solicitacao.setPassageiro(rs.getBoolean("eh_passageiro"));
                solicitacao.setOrigem(new CidadeDAO().buscarPorId(rs.getInt("origem")));
                solicitacao.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                solicitacao.setLocalSaida(rs.getString("local_saida"));
                solicitacao.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacao.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                solicitacao.setLocalRetorno(rs.getString("local_retorno"));
                solicitacao.setPercurso(rs.getString("percurso"));
                solicitacao.setJustificativa(rs.getString("justificativa"));
                solicitacao.setObservacoes(rs.getString("observacoes"));
                solicitacao.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao_solicitacao")));
                solicitacao.setPassageiros(new PassageiroDAO().buscarPorSolicitacaoId(solicitacao.getId()));
               // solicitacao.setViagem(new ViagemDAO().buscarPorId(rs.getInt("viagem")));

                solicitacoes.add(solicitacao);

            }
            
            stmt.close();
            return solicitacoes;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;

    }

    public Boolean naoEhRepetido(SolicitacaoViagem solicitacao, String passageiroRg) {

        List<Passageiro> passageiros = new PassageiroDAO().buscarPorSolicitacaoId(solicitacao.getId());
        for (Passageiro passageiro : passageiros) {
            if (passageiro.getRg().equals(passageiroRg)) {

                return Boolean.TRUE;

            }
        }

        return Boolean.FALSE;

    }
    
}
