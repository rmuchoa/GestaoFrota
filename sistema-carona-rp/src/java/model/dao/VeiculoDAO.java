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
import model.entity.TipoVeiculo;
import model.entity.Veiculo;

/**
 *
 * @author Marcelo Maia
 */
public class VeiculoDAO {

    private Connection connection;
    private TipoVeiculo tipoveiculo;

    public VeiculoDAO() {
        try {
            this.connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Veiculo inserir(Veiculo veiculo) {

        String sql = "insert into veiculo ("
                + "placa, renavam,cor,modelo,marca,ano,capacidade_passageiros,"
                + "capacidade_carga,tipo_veiculo) values (?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            System.out.println("Veiculo aqui :" + veiculo.getPlaca());
            stmt.setString(1, veiculo.getPlaca());
            stmt.setLong(2, veiculo.getRenavam());
            stmt.setString(3, veiculo.getCor());
            stmt.setString(4, veiculo.getModelo());
            stmt.setString(5, veiculo.getMarca());
            stmt.setInt(6, veiculo.getAno());
            stmt.setInt(7, veiculo.getCapacidadePassageiros());
            stmt.setInt(8, veiculo.getCapacidadeCarga());
            stmt.setInt(9, veiculo.getTipoVeiculo().getId());
            stmt.execute();
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        Veiculo veiculoCadastrado = this.getVeiculoPorPlaca(veiculo.getPlaca());
        return veiculoCadastrado;

    }

    public List<Veiculo> getTodosVeiculos() {

        List<Veiculo> lista = new ArrayList<Veiculo>();
        String sql = "select * from veiculo";
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            int posicao = 0;
            while (rs.next()) {
                TipoVeiculoDAO tipoVeiculoDAO = new TipoVeiculoDAO();
                Veiculo veiculo = new Veiculo();
                veiculo.setId(rs.getInt("id"));
                veiculo.setAno(rs.getInt("ano"));
                veiculo.setCapacidadeCarga(rs.getInt("capacidade_carga"));
                veiculo.setCapacidadePassageiros(rs.getInt("capacidade_passageiros"));
                veiculo.setCor(rs.getString("cor"));
                veiculo.setMarca(rs.getString("marca"));
                veiculo.setModelo(rs.getString("modelo"));
                veiculo.setPlaca(rs.getString("placa"));
                veiculo.setRenavam(rs.getLong("renavam"));
                veiculo.setTipoVeiculo(tipoVeiculoDAO.getTipoPorId(rs.getInt("tipo_veiculo")));
                lista.add(posicao, veiculo);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Veiculo getVeiculoPorId(int id) {

        List<Veiculo> lista = new ArrayList<Veiculo>();
        Veiculo veiculo = null;
        String sql = "select * from veiculo where id = ?";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                TipoVeiculoDAO tipoVeiculoDAO = new TipoVeiculoDAO();
                veiculo = new Veiculo();

                veiculo.setId(rs.getInt("id"));
                veiculo.setAno(rs.getInt("ano"));
                veiculo.setCapacidadeCarga(rs.getInt("capacidade_carga"));
                veiculo.setCapacidadePassageiros(rs.getInt("capacidade_passageiros"));
                veiculo.setCor(rs.getString("cor"));
                veiculo.setMarca(rs.getString("marca"));
                veiculo.setModelo(rs.getString("modelo"));
                veiculo.setPlaca(rs.getString("placa"));
                veiculo.setRenavam(rs.getLong("renavam"));
                veiculo.setTipoVeiculo(tipoVeiculoDAO.getTipoPorId(rs.getInt("tipo_veiculo")));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return veiculo;
        
    }

    public Veiculo alterarVeiculo(Veiculo veiculo) {
        String sql = "update veiculo set tipo_veiculo=?,placa=?,renavam=?,cor=?,modelo=?,marca=?,ano=?,capacidade_passageiros=?,capacidade_carga=? where id=?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setInt(1, veiculo.getTipoVeiculo().getId());
            stmt.setString(2, veiculo.getPlaca());
            stmt.setLong(3, veiculo.getRenavam());
            stmt.setString(4, veiculo.getCor());
            stmt.setString(5, veiculo.getModelo());
            stmt.setString(6, veiculo.getMarca());
            stmt.setInt(7, veiculo.getAno());
            stmt.setInt(8, veiculo.getCapacidadePassageiros());
            stmt.setInt(9, veiculo.getCapacidadeCarga());
            stmt.setInt(10, veiculo.getId());
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Veiculo veiculoCadastrado = this.getVeiculoPorPlaca(veiculo.getPlaca());

        return veiculoCadastrado;
    }

    public void removerVeicupoPorId(int id_veiculo) {

        String sql = "delete from veiculo where id=?";

        try {
            PreparedStatement stmt = this.connection.prepareStatement(sql);
            stmt.setInt(1, id_veiculo);
            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Veiculo getVeiculoPorPlaca(String placa) {

        List<Veiculo> lista = new ArrayList<Veiculo>();
        Veiculo veiculo = new Veiculo();
        String sql = "select * from veiculo where placa = ?";
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, placa);
            ResultSet rs = stmt.executeQuery();

            int posicao = 0;
            while (rs.next()) {
                TipoVeiculoDAO tipoVeiculoDAO = new TipoVeiculoDAO();

                veiculo.setId(rs.getInt("id"));
                veiculo.setAno(rs.getInt("ano"));
                veiculo.setCapacidadeCarga(rs.getInt("capacidade_carga"));
                veiculo.setCapacidadePassageiros(rs.getInt("capacidade_passageiros"));
                veiculo.setCor(rs.getString("cor"));
                veiculo.setMarca(rs.getString("marca"));
                veiculo.setModelo(rs.getString("modelo"));
                veiculo.setPlaca(rs.getString("placa"));
                veiculo.setRenavam(rs.getLong("renavam"));
                veiculo.setTipoVeiculo(tipoVeiculoDAO.getTipoPorId(rs.getInt("tipo_veiculo")));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return veiculo;
    }
}
