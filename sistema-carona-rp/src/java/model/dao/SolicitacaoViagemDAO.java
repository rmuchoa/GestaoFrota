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
import java.util.Date;
import java.util.List;
import jdbc.ConnectionFactory;
import model.entity.SolicitacaoViagem;
import model.entity.Usuario;

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
                solicitacao.setLogalSaida(rs.getString("local_saida"));
                solicitacao.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                solicitacao.setLocalRetorno(rs.getString("local_retorno"));
                solicitacao.setJustificativa(rs.getString("justificativa"));
                solicitacao.setObservacoes(rs.getString("observacoes"));
                solicitacao.setOrigem(new CidadeDAO().buscarPorId(rs.getInt("origem")));
                solicitacao.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacao.setPercurso(rs.getString("percurso"));
                solicitacao.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao")));
                solicitacao.setPassageiro(Boolean.parseBoolean("eh_passageiro"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        solicitacao.setPassageiros(new PassageiroDAO().buscarPorSolicitacaoId(solicitacao.getId()));
        return solicitacao;

    }

    public SolicitacaoViagem inserir(SolicitacaoViagem solicitacaoViagem) {

        String sql = "insert into solicitacao_viagem (solicitante, data_saida, local_saida, "
                + "data_retorno, local_retorno, justificativa, observacoes, "
                + "origem, destino, percurso, situacao, eh_passageiro )"
                + " values (?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, solicitacaoViagem.getSolicitante().getId());
            stmt.setDate(2, new java.sql.Date(solicitacaoViagem.getDataSaida().getTime()));
            stmt.setString(3, solicitacaoViagem.getLogalSaida());
            stmt.setDate(4, new java.sql.Date(solicitacaoViagem.getDataRetorno().getTime()));
            stmt.setString(5, solicitacaoViagem.getLocalRetorno());
            stmt.setString(6, solicitacaoViagem.getJustificativa());
            stmt.setString(7, solicitacaoViagem.getObservacoes());
            stmt.setInt(8, solicitacaoViagem.getOrigem().getId());
            stmt.setInt(9, solicitacaoViagem.getDestino().getId());
            stmt.setString(10, solicitacaoViagem.getPercurso());
            stmt.setInt(11, solicitacaoViagem.getSituacao().getId());
            stmt.setBoolean(12, solicitacaoViagem.isPassageiro());
            stmt.execute();
            stmt.close();


        } catch (SQLException e) {
            e.printStackTrace();
        }

        return buscarPorDataSaida(solicitacaoViagem.getDataSaida(), solicitacaoViagem.getSolicitante());

    }

    public SolicitacaoViagem buscarPorDataSaida(java.util.Date dataSaida, Usuario solicitante) {

        SolicitacaoViagem solicitacao = null;
        String sql = "select * from solicitacao_viagem where data_saida = ? and solicitante = ?;";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setDate(1, new java.sql.Date(dataSaida.getTime()));
            stmt.setInt(2, solicitante.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                solicitacao = new SolicitacaoViagem();
                solicitacao.setId(rs.getInt("id"));
                solicitacao.setSolicitante(new UsuarioDAO().buscarPorId(rs.getInt("solicitante")));
                solicitacao.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                solicitacao.setLogalSaida(rs.getString("local_saida"));
                solicitacao.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                solicitacao.setLocalRetorno(rs.getString("local_retorno"));
                solicitacao.setJustificativa(rs.getString("justificativa"));
                solicitacao.setObservacoes(rs.getString("observacoes"));
                solicitacao.setOrigem(new CidadeDAO().buscarPorId(rs.getInt("origem")));
                solicitacao.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacao.setPercurso(rs.getString("percurso"));
                solicitacao.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao")));
                solicitacao.setPassageiro(Boolean.parseBoolean("eh_passageiro"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return solicitacao;

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
                solicitacao.setLogalSaida(rs.getString("local_saida"));
                solicitacao.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacao.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                solicitacao.setLocalRetorno(rs.getString("local_retorno"));
                solicitacao.setPercurso(rs.getString("percurso"));
                solicitacao.setJustificativa(rs.getString("justificativa"));
                solicitacao.setObservacoes(rs.getString("observacoes"));
                solicitacao.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao")));
                solicitacao.setPassageiros(new PassageiroDAO().buscarPorSolicitacaoId(solicitacao.getId()));

                solicitacoes.add(solicitacao);

            }
            
            return solicitacoes;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;

    }
}
