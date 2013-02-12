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
import model.entity.TipoVeiculo;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author renanmarceluchoa
 */
public class TipoVeiculoDAOTest {
    
    private static Connection connection;
    private static TipoVeiculo tipoVeiculo;
    private static List<TipoVeiculo> tiposVeiculo;
    
    public TipoVeiculoDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
        
        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        tipoVeiculo = new TipoVeiculo();
        String sql = "select * from tipo_veiculo where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, 1);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                tipoVeiculo.setId(rs.getInt("id"));
                tipoVeiculo.setDescricao(rs.getString("descricao"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        tiposVeiculo = new ArrayList<TipoVeiculo>();
        String sql2 = "select * from tipo_veiculo";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql2);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                TipoVeiculo tipo = new TipoVeiculo();
                tipo.setId(rs.getInt("id"));
                tipo.setDescricao(rs.getString("descricao"));
                tiposVeiculo.add(tipo);

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getTipoPorID method, of class TipoVeiculoDAO.
     */
    @Test
    public void testGetTipoPorID() {
        System.out.println("getTipoPorID");
        int id = tipoVeiculo.getId();
        TipoVeiculoDAO dao = new TipoVeiculoDAO();
        TipoVeiculo resultTipo = dao.getTipoPorId(id);
        assertEquals(tipoVeiculo.getId(), resultTipo.getId());
        assertEquals(tipoVeiculo.getDescricao(), resultTipo.getDescricao());
    }

    /**
     * Test of getTipoPorDescricao method, of class TipoVeiculoDAO.
     */
    @Test
    public void testGetTipoPorDescricao() {
        System.out.println("getTipoPorDescricao");
        String descricao = tipoVeiculo.getDescricao();
        TipoVeiculoDAO dao = new TipoVeiculoDAO();
        TipoVeiculo resultTipo = dao.getTipoPorDescricao(descricao);
        assertEquals(tipoVeiculo.getId(), resultTipo.getId());
        assertEquals(tipoVeiculo.getDescricao(), resultTipo.getDescricao());
    }

    /**
     * Test of listarTodos method, of class TipoVeiculoDAO.
     */
    @Test
    public void testListarTodos() {
        System.out.println("listarTodos");
        TipoVeiculoDAO dao = new TipoVeiculoDAO();
        List<TipoVeiculo> resultTipos = dao.listarTodos();
        assertEquals(tiposVeiculo.size(), resultTipos.size());
        if (tiposVeiculo.size() == resultTipos.size()) {
            for (int i=0; i<tiposVeiculo.size(); i++) {
                assertEquals(tiposVeiculo.get(i).getId(), resultTipos.get(i).getId());
                assertEquals(tiposVeiculo.get(i).getDescricao(), resultTipos.get(i).getDescricao());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }
    
}
