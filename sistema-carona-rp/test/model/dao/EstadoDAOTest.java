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
import model.entity.Estado;
import static org.junit.Assert.*;
import org.junit.*;

/**
 *
 * @author renanmarceluchoa
 */
public class EstadoDAOTest {
    
    private static Connection connection;
    private static Estado estado;
    private static List<Estado> estados;
    
    public EstadoDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
        
        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        estado = new Estado();
        String sql1 = "select * from estado where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, 1);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                estado.setId(rs.getInt("id"));
                estado.setNome(rs.getString("nome"));
                estado.setSigla(rs.getString("sigla"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        estados = new ArrayList<Estado>();
        String sql = "select * from estado";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                Estado e = new Estado();
                e.setId(rs.getInt("id"));
                e.setNome(rs.getString("nome"));
                e.setSigla(rs.getString("sigla"));

                estados.add(e);
                
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
     * Test of buscarPorId method, of class EstadoDAO.
     */
    @Test
    public void testBuscarPorId() {
        System.out.println("buscarPorId");
        Integer id = estado.getId();
        EstadoDAO dao = new EstadoDAO();
        Estado resultEstado = dao.buscarPorId(id);
        assertEquals(estado.getId(), resultEstado.getId());
        assertEquals(estado.getNome(), resultEstado.getNome());
        assertEquals(estado.getSigla(), resultEstado.getSigla());
    }

    /**
     * Test of buscarPorNome method, of class EstadoDAO.
     */
    @Test
    public void testBuscarPorNome() {
        System.out.println("buscarPorNome");
        String nomeEstado = estado.getNome();
        EstadoDAO dao = new EstadoDAO();
        Estado resultEstado = dao.buscarPorNome(nomeEstado);
        assertEquals(estado.getId(), resultEstado.getId());
        assertEquals(estado.getNome(), resultEstado.getNome());
        assertEquals(estado.getSigla(), resultEstado.getSigla());
    }

    /**
     * Test of buscarPorSigla method, of class EstadoDAO.
     */
    @Test
    public void testBuscarPorSigla() {
        System.out.println("buscarPorSigla");
        String siglaEstado = estado.getSigla();
        EstadoDAO dao = new EstadoDAO();
        Estado resultEstado = dao.buscarPorSigla(siglaEstado);
        assertEquals(estado.getId(), resultEstado.getId());
        assertEquals(estado.getNome(), resultEstado.getNome());
        assertEquals(estado.getSigla(), resultEstado.getSigla());
    }

    /**
     * Test of listar method, of class EstadoDAO.
     */
    @Test
    public void testListar() {
        System.out.println("listar");
        EstadoDAO instance = new EstadoDAO();
        List<Estado> resultEstados = instance.listar();
        assertEquals(estados.size(), resultEstados.size());
        if (estados.size() == resultEstados.size()) {
            for (int i=0; i<estados.size(); i++) {
                assertEquals(estados.get(i).getId(), resultEstados.get(i).getId());
                assertEquals(estados.get(i).getNome(), resultEstados.get(i).getNome());
                assertEquals(estados.get(i).getSigla(), resultEstados.get(i).getSigla());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }
}
