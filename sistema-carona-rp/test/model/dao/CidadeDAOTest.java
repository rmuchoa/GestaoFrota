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
import model.entity.Cidade;
import model.entity.Estado;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author renanmarceluchoa
 */
public class CidadeDAOTest {
    
    private static Connection connection;
    private static Cidade cidade;
    private static List<Cidade> cidades;
    private static List<Cidade> cidadesDoEstado;
    
    public CidadeDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
        
        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        cidade = new Cidade();
        String sql1 = "select * from cidade where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, 1);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                EstadoDAO estadoDAO = new EstadoDAO();
                
                cidade.setId(rs.getInt("id"));
                cidade.setNome(rs.getString("nome"));
                cidade.setEstado(estadoDAO.buscarPorId(rs.getInt("estado")));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        cidades = new ArrayList<Cidade>();
        String sql2 = "select * from cidade";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql2);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                EstadoDAO estadoDAO = new EstadoDAO();
                
                Cidade c = new Cidade();
                c.setId(rs.getInt("id"));
                c.setNome(rs.getString("nome"));
                c.setEstado(estadoDAO.buscarPorId(rs.getInt("estado")));

                cidades.add(c);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        cidadesDoEstado = new ArrayList<Cidade>();
        
        for(Cidade c : cidades) {
            if(c.getEstado().getId().equals(cidade.getEstado().getId())) {
                cidadesDoEstado.add(c);
            }
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
     * Test of buscarPorId method, of class CidadeDAO.
     */
    @Test
    public void testBuscarPorId() {
        System.out.println("buscarPorId");
        int id = cidade.getId();
        CidadeDAO dao = new CidadeDAO();
        Cidade resultCidade = dao.buscarPorId(id);
        assertEquals(cidade.getId(), resultCidade.getId());
        assertEquals(cidade.getNome(), resultCidade.getNome());
        assertEquals(cidade.getEstado().getId(), resultCidade.getEstado().getId());
    }

    /**
     * Test of buscarPorNome method, of class CidadeDAO.
     */
    @Test
    public void testBuscarPorNome() {
        System.out.println("buscarPorNome");
        String nome = cidade.getNome();
        CidadeDAO dao = new CidadeDAO();
        Cidade resultCidade = dao.buscarPorNome(nome);
        assertEquals(cidade.getId(), resultCidade.getId());
        assertEquals(cidade.getNome(), resultCidade.getNome());
        assertEquals(cidade.getEstado().getId(), resultCidade.getEstado().getId());
    }

    /**
     * Test of listar method, of class CidadeDAO.
     */
    @Test
    public void testListar() {
        System.out.println("listar");
        CidadeDAO dao = new CidadeDAO();
        List<Cidade> resultCidades = dao.listar();
        assertEquals(cidades.size(), resultCidades.size());
        if (cidades.size() == resultCidades.size()) {
            for (int i=0; i<cidades.size(); i++) {
                assertEquals(cidades.get(i).getId(), resultCidades.get(i).getId());
                assertEquals(cidades.get(i).getNome(), resultCidades.get(i).getNome());
                assertEquals(cidades.get(i).getEstado().getId(), resultCidades.get(i).getEstado().getId());
            }
        } else {
            fail("não encontrou a lista correta!");
        }
    }

    /**
     * Test of listarPorEstado method, of class CidadeDAO.
     */
    @Test
    public void testListarPorEstado() {
        System.out.println("listarPorEstado");
        Estado estado = cidade.getEstado();
        CidadeDAO instance = new CidadeDAO();
        List<Cidade> resultCidadesPorEstado = instance.listarPorEstado(estado);
        assertEquals(cidadesDoEstado.size(), resultCidadesPorEstado.size());
        if (cidadesDoEstado.size() == resultCidadesPorEstado.size()) {
            for (int i=0; i<cidadesDoEstado.size(); i++) {
                assertEquals(cidadesDoEstado.get(i).getId(), resultCidadesPorEstado.get(i).getId());
                assertEquals(cidadesDoEstado.get(i).getNome(), resultCidadesPorEstado.get(i).getNome());
                assertEquals(cidadesDoEstado.get(i).getEstado().getId(), resultCidadesPorEstado.get(i).getEstado().getId());
            }
        } else {
            fail("não encontrou a lista correta!");
        }
    }
}
