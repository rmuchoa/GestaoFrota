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
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author renanmarceluchoa
 */
public class OpicionalVeiculoDAOTest {
    
    private static Connection connection;
    private static OpicionalVeiculo opcionalVeiculo;
    private static List<OpicionalVeiculo> opcionais;
    
    
    public OpicionalVeiculoDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
        
        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        opcionalVeiculo = new OpicionalVeiculo();
        String sql1 = "select * from opcionais_veiculo where id=?;";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, 1);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {

                opcionalVeiculo.setId(rs.getInt("id"));
                opcionalVeiculo.setDescricao(rs.getString("descricao"));
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        opcionais = new ArrayList<OpicionalVeiculo>();
        String sql2 = "select * from opcionais_veiculo;";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql2);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                OpicionalVeiculo op = new OpicionalVeiculo();
                op.setId(rs.getInt("id"));
                op.setDescricao(rs.getString("descricao"));
                opcionais.add(op);
                
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
     * Test of getOpcionalPorId method, of class OpicionalVeiculoDAO.
     */
    @Test
    public void testGetOpcionalPorId() {
        System.out.println("getOpcionalPorId");
        int id = opcionalVeiculo.getId();
        OpicionalVeiculoDAO dao = new OpicionalVeiculoDAO();
        OpicionalVeiculo resultOpcional = dao.getOpcionalPorId(id);
        assertEquals(opcionalVeiculo.getId(), resultOpcional.getId());
        assertEquals(opcionalVeiculo.getDescricao(), resultOpcional.getDescricao());
    }

    /**
     * Test of getTodosOpcionais method, of class OpicionalVeiculoDAO.
     */
    @Test
    public void testGetTodosOpcionais() {
        System.out.println("getTodosOpcionais");
        OpicionalVeiculoDAO dao = new OpicionalVeiculoDAO();
        List<OpicionalVeiculo> resultOpcionais = dao.getTodosOpcionais();
        assertEquals(opcionais.size(), resultOpcionais.size());
        if (opcionais.size() == resultOpcionais.size()) {
            for (int i=0; i<opcionais.size(); i++) {
                assertEquals(opcionais.get(i).getId(), resultOpcionais.get(i).getId());
                assertEquals(opcionais.get(i).getDescricao(), resultOpcionais.get(i).getDescricao());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }
}
