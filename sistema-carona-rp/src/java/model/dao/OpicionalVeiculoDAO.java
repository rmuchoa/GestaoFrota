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
import model.entity.OpicionalVeiculo;
import model.entity.Veiculo;

/**
 *
 * @author Marcelo Maia
 */
public class OpicionalVeiculoDAO {

    private Connection connection;
    private OpicionalVeiculo opicionalVeiculo;
    private List<OpicionalVeiculo> lista;

    public OpicionalVeiculoDAO() {
        try {
            this.connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OpicionalVeiculo> getTodosOpcionais() {
        
        lista = new ArrayList<OpicionalVeiculo>();
        String sql = "select * from opcionais_veiculo;";

        try {

            PreparedStatement stmt = this.connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OpicionalVeiculo opicionalVeiculo = new OpicionalVeiculo();
                opicionalVeiculo.setId(rs.getInt("id"));
                opicionalVeiculo.setDescricao(rs.getString("descricao"));
                lista.add(opicionalVeiculo);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return lista;
    }

    public OpicionalVeiculo getOpcionalPorId(int id) {

        OpicionalVeiculo opcionalVeiculo = null;
        String sql = "select * from opcionais_veiculo where id=?;";

        try {

            PreparedStatement stmt = this.connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {

                opcionalVeiculo = new OpicionalVeiculo();
                opcionalVeiculo.setId(rs.getInt("id"));
                opcionalVeiculo.setDescricao(rs.getString("descricao"));
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return opcionalVeiculo;
        
    }
}
