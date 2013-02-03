/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jdbc.ConnectionFactory;
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
    
    public void inserir(SolicitacaoViagem  solicitacaoViagem){
        String sql = "insert into solicitacao_viagem (usuario_id,data_saida,local_saida,"
                + "data_retorno,local_retorno,justificativa,observacoes,origem,destino,"
                + "nr_pessoas,percurso,situacao_solicitacao_id,eh_servidor)"
                + " values (?,?,?,?,?,?,?,?,?,?,?,?,?)";
             
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            System.out.println("id user"+solicitacaoViagem.getUsuario().getId()+" data saida "+solicitacaoViagem.getData_saida()+
                    "LocalSaida: "+solicitacaoViagem.getLogal_saida()+" data retorno "+solicitacaoViagem.getData_retorno()+" origem:"+solicitacaoViagem.getOrigem()+" Destino:"+solicitacaoViagem.getDestino());
            stmt.setInt(1, solicitacaoViagem.getUsuario().getId());
            stmt.setString(2, solicitacaoViagem.getData_saida());
            stmt.setString(3, solicitacaoViagem.getLogal_saida());
            stmt.setString(4, solicitacaoViagem.getData_retorno());
            stmt.setString(5, solicitacaoViagem.getLocal_retorno());
            stmt.setString(6, solicitacaoViagem.getJustificativa());
            stmt.setString(7, solicitacaoViagem.getObservacoes());
            stmt.setInt(8, solicitacaoViagem.getOrigem());
            stmt.setInt(9, solicitacaoViagem.getDestino());
            stmt.setInt(10, solicitacaoViagem.getNumero_pessoas());
            stmt.setString(11, solicitacaoViagem.getPercurso());
            stmt.setInt(12, 1);
            stmt.setBoolean(13, solicitacaoViagem.getEhservidor());
            stmt.execute();
            stmt.close();
            
            
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
}
