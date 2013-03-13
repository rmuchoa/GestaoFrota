/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.ConnectionFactory;
import model.entity.Situacao;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author renanmarceluchoa
 */
public class SituacaoSolicitacaoDAOTest {
    
    private static Connection connection;
    private static Situacao situacao;
    
    public SituacaoSolicitacaoDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
        
        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        situacao = new Situacao();
        String sql = "select * from situacao_solicitacao where id = ?";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, 1);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                situacao.setId(rs.getInt("id"));
                situacao.setDescricao(rs.getString("descricao"));
                
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
     * Test of buscarPorId method, of class SituacaoDAO.
     */
    @Test
    public void testBuscarPorId() {
        System.out.println("buscarPorId");
        Integer id = situacao.getId();
        SituacaoDAO dao = new SituacaoDAO();
        Situacao resultSituacao = dao.buscarPorId(id);
        assertEquals(situacao.getId(), resultSituacao.getId());
        assertEquals(situacao.getDescricao(), resultSituacao.getDescricao());
    }
}
