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
import util.ConnectionFactory;
import model.entity.OpcionalVeiculo;
import model.entity.Veiculo;

/**
 *
 * @author Marcelo Maia
 */
public class OpcionalVeiculoDAO {

    private Connection connection;
    private OpcionalVeiculo opcionalVeiculo;
    private List<OpcionalVeiculo> lista;

    public OpcionalVeiculoDAO() {
        try {
            this.connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<OpcionalVeiculo> getTodosOpcionais() {
        
        lista = new ArrayList<OpcionalVeiculo>();
        String sql = "select * from opcional_veiculo;";

        try {

            PreparedStatement stmt = this.connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OpcionalVeiculo opicionalVeiculo = new OpcionalVeiculo();
                opicionalVeiculo.setId(rs.getInt("id"));
                opicionalVeiculo.setDescricao(rs.getString("descricao"));
                lista.add(opicionalVeiculo);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return lista;
    }

    public OpcionalVeiculo getOpcionalPorId(int id) {

        OpcionalVeiculo opcionalVeiculo = null;
        String sql = "select * from opcional_veiculo where id=?;";

        try {

            PreparedStatement stmt = this.connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {

                opcionalVeiculo = new OpcionalVeiculo();
                opcionalVeiculo.setId(rs.getInt("id"));
                opcionalVeiculo.setDescricao(rs.getString("descricao"));
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return opcionalVeiculo;
        
    }
}
