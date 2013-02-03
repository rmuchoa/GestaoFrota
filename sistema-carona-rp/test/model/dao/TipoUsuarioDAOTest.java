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
import model.entity.TipoUsuario;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author renanmarceluchoa
 */
public class TipoUsuarioDAOTest {
    
    private static Connection connection;
    private static TipoUsuario tipoUsuario;
    private static ArrayList<TipoUsuario> tiposUsuario;

    public TipoUsuarioDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {

        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        tipoUsuario = new TipoUsuario();
        String sql1 = "select * from tipo_usuario where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, 1);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                tipoUsuario.setId(rs.getInt("id"));
                tipoUsuario.setDescricao(rs.getString("descricao"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        tiposUsuario = new ArrayList<TipoUsuario>();
        String sql2 = "select * from tipo_usuario";
        try {

            PreparedStatement stmt = connection.prepareStatement(sql2);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                TipoUsuario tipo = new TipoUsuario();
                tipo.setId(rs.getInt("id"));
                tipo.setDescricao(rs.getString("descricao"));

                tiposUsuario.add(tipo);
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
     * Test of buscarPorId method, of class TipoUsuarioDAO.
     */
    @Test
    public void testBuscarPorId() {
        System.out.println("buscarPorId");
        int id = tipoUsuario.getId();
        TipoUsuarioDAO dao = new TipoUsuarioDAO();
        TipoUsuario resultTipo = dao.buscarPorId(id);
        assertEquals(tipoUsuario.getId(), resultTipo.getId());
        assertEquals(tipoUsuario.getDescricao(), resultTipo.getDescricao());
    }

    /**
     * Test of buscarPorDescricao method, of class TipoUsuarioDAO.
     */
    @Test
    public void testBuscarPorDescricao() {
        System.out.println("buscarPorDescricao");
        String descricao = tipoUsuario.getDescricao();
        TipoUsuarioDAO dao = new TipoUsuarioDAO();
        TipoUsuario resultTipo = dao.buscarPorDescricao(descricao);
        assertEquals(tipoUsuario.getId(), resultTipo.getId());
        assertEquals(tipoUsuario.getDescricao(), resultTipo.getDescricao());
    }

    /**
     * Test of listar method, of class TipoUsuarioDAO.
     */
    @Test
    public void testListar() {
        System.out.println("listar");
        TipoUsuarioDAO dao = new TipoUsuarioDAO();
        List<TipoUsuario> resultTipos = dao.listar();
        assertEquals(tiposUsuario.size(), resultTipos.size());
        if(tiposUsuario.size() == resultTipos.size()) {
            for(int i=0; i<tiposUsuario.size(); i++) {
                assertEquals(tiposUsuario.get(i).getId(), resultTipos.get(i).getId());
                assertEquals(tiposUsuario.get(i).getDescricao(), resultTipos.get(i).getDescricao());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }
}
