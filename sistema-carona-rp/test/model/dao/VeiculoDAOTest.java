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
import model.entity.Veiculo;
import static org.junit.Assert.*;
import org.junit.*;

/**
 *
 * @author renanmarceluchoa
 */
public class VeiculoDAOTest {

    private static Connection connection;
    private static Veiculo veiculo;
    private static List<Veiculo> veiculos;
    private static Veiculo novoVeiculo;

    public VeiculoDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {

        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        veiculo = new Veiculo();
        String sql1 = "select * from veiculo where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, 1);
            ResultSet rs = stmt.executeQuery();

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

        veiculos = new ArrayList<Veiculo>();
        String sql2 = "select * from veiculo";
        try {

            PreparedStatement stmt = connection.prepareStatement(sql2);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                TipoVeiculoDAO tipoVeiculoDAO = new TipoVeiculoDAO();
                Veiculo v = new Veiculo();
                v.setId(rs.getInt("id"));
                v.setAno(rs.getInt("ano"));
                v.setCapacidadeCarga(rs.getInt("capacidade_carga"));
                v.setCapacidadePassageiros(rs.getInt("capacidade_passageiros"));
                v.setCor(rs.getString("cor"));
                v.setMarca(rs.getString("marca"));
                v.setModelo(rs.getString("modelo"));
                v.setPlaca(rs.getString("placa"));
                v.setRenavam(rs.getLong("renavam"));
                v.setTipoVeiculo(tipoVeiculoDAO.getTipoPorId(rs.getInt("tipo_veiculo")));
                veiculos.add(v);
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
     * Test of getVeiculoPorId method, of class VeiculoDAO.
     */
    @Test
    public void testGetVeiculoPorId() {
        System.out.println("getVeiculoPorId");
        int id = veiculo.getId();
        VeiculoDAO dao = new VeiculoDAO();
        Veiculo resultVeiculo = dao.getVeiculoPorId(id);
        assertEquals(veiculo.getId(), resultVeiculo.getId());
        assertEquals(veiculo.getAno(), resultVeiculo.getAno());
        assertEquals(veiculo.getCapacidadePassageiros(), resultVeiculo.getCapacidadePassageiros());
        assertEquals(veiculo.getCapacidadeCarga(), resultVeiculo.getCapacidadeCarga());
        assertEquals(veiculo.getCor(), resultVeiculo.getCor());
        assertEquals(veiculo.getMarca(), resultVeiculo.getMarca());
        assertEquals(veiculo.getModelo(), resultVeiculo.getModelo());
        assertEquals(veiculo.getPlaca(), resultVeiculo.getPlaca());
        assertEquals(veiculo.getRenavam(), resultVeiculo.getRenavam());
        assertEquals(veiculo.getTipoVeiculo().getId(), resultVeiculo.getTipoVeiculo().getId());
    }

    /**
     * Test of getVeiculoPorPlaca method, of class VeiculoDAO.
     */
    @Test
    public void testGetVeiculoPorPlaca() {
        System.out.println("getVeiculoPorPlaca");
        String placa = veiculo.getPlaca();
        VeiculoDAO dao = new VeiculoDAO();
        Veiculo resultVeiculo = dao.getVeiculoPorPlaca(placa);
        assertEquals(veiculo.getId(), resultVeiculo.getId());
        assertEquals(veiculo.getAno(), resultVeiculo.getAno());
        assertEquals(veiculo.getCapacidadePassageiros(), resultVeiculo.getCapacidadePassageiros());
        assertEquals(veiculo.getCapacidadeCarga(), resultVeiculo.getCapacidadeCarga());
        assertEquals(veiculo.getCor(), resultVeiculo.getCor());
        assertEquals(veiculo.getMarca(), resultVeiculo.getMarca());
        assertEquals(veiculo.getModelo(), resultVeiculo.getModelo());
        assertEquals(veiculo.getPlaca(), resultVeiculo.getPlaca());
        assertEquals(veiculo.getRenavam(), resultVeiculo.getRenavam());
        assertEquals(veiculo.getTipoVeiculo().getId(), resultVeiculo.getTipoVeiculo().getId());
    }

    /**
     * Test of inserir method, of class VeiculoDAO.
     */
    @Test
    public void testInserir() {
        System.out.println("inserir");
        novoVeiculo = new Veiculo();
        novoVeiculo.setAno(1000);
        novoVeiculo.setCapacidadePassageiros(1);
        novoVeiculo.setCapacidadeCarga(1);
        novoVeiculo.setCor("teste");
        novoVeiculo.setMarca("teste");
        novoVeiculo.setModelo("teste");
        novoVeiculo.setPlaca("teste");
        novoVeiculo.setRenavam(1000L);
        novoVeiculo.setTipoVeiculo(new TipoVeiculoDAO().getTipoPorId(1));
        VeiculoDAO dao = new VeiculoDAO();
        Veiculo v = dao.inserir(novoVeiculo);
        
        assertEquals(novoVeiculo.getAno(), v.getAno());
        assertEquals(novoVeiculo.getCapacidadePassageiros(), v.getCapacidadePassageiros());
        assertEquals(novoVeiculo.getCapacidadeCarga(), v.getCapacidadeCarga());
        assertEquals(novoVeiculo.getCor(), v.getCor());
        assertEquals(novoVeiculo.getMarca(), v.getMarca());
        assertEquals(novoVeiculo.getModelo(), v.getModelo());
        assertEquals(novoVeiculo.getPlaca(), v.getPlaca());
        assertEquals(novoVeiculo.getRenavam(), v.getRenavam());
        assertEquals(novoVeiculo.getTipoVeiculo().getId(), v.getTipoVeiculo().getId());
        
        if (novoVeiculo.getPlaca().equals(v.getPlaca())) {
            novoVeiculo.setId(v.getId());
        }
    }

    /**
     * Test of alterarVeiculo method, of class VeiculoDAO.
     */
    @Test
    public void testAlterarVeiculo() {
        System.out.println("alterarVeiculo");
        novoVeiculo.setCor("outra cor");
        novoVeiculo.setMarca("outra marca");
        novoVeiculo.setModelo("outro modelo");
        VeiculoDAO dao = new VeiculoDAO();
        Veiculo resultVeiculo = dao.alterarVeiculo(novoVeiculo);
        assertEquals(novoVeiculo.getCor(), resultVeiculo.getCor());
        assertEquals(novoVeiculo.getMarca(), resultVeiculo.getMarca());
        assertEquals(novoVeiculo.getModelo(), resultVeiculo.getModelo());
    }

    /**
     * Test of removerVeicupoPorId method, of class VeiculoDAO.
     */
    @Test
    public void testRemoverVeicupoPorId() {
        System.out.println("removerVeicupoPorId");
        int id = novoVeiculo.getId();
        VeiculoDAO dao = new VeiculoDAO();
        dao.removerVeicupoPorId(id);
        Veiculo v = dao.getVeiculoPorId(id);
        assertTrue(v == null);
        assertNull(v);
        List<Veiculo> lista = dao.getTodosVeiculos();
        for (Veiculo v2 : lista) {
            assertFalse(v2.getId() == novoVeiculo.getId());
        }
    }

    /**
     * Test of getTodosVeiculos method, of class VeiculoDAO.
     */
    @Test
    public void testGetTodosVeiculos() {
        System.out.println("getTodosVeiculos");
        VeiculoDAO dao = new VeiculoDAO();
        List<Veiculo> resultVeiculos = dao.getTodosVeiculos();
        assertEquals(veiculos.size(), resultVeiculos.size());
        if (veiculos.size() == resultVeiculos.size()) {
            for (int i=0; i<veiculos.size(); i++) {
                assertEquals(veiculos.get(i).getId(), resultVeiculos.get(i).getId());
                assertEquals(veiculos.get(i).getAno(), resultVeiculos.get(i).getAno());
                assertEquals(veiculos.get(i).getCapacidadePassageiros(), resultVeiculos.get(i).getCapacidadePassageiros());
                assertEquals(veiculos.get(i).getCapacidadeCarga(), resultVeiculos.get(i).getCapacidadeCarga());
                assertEquals(veiculos.get(i).getCor(), resultVeiculos.get(i).getCor());
                assertEquals(veiculos.get(i).getMarca(), resultVeiculos.get(i).getMarca());
                assertEquals(veiculos.get(i).getModelo(), resultVeiculos.get(i).getModelo());
                assertEquals(veiculos.get(i).getPlaca(), resultVeiculos.get(i).getPlaca());
                assertEquals(veiculos.get(i).getRenavam(), resultVeiculos.get(i).getRenavam());
                assertEquals(veiculos.get(i).getTipoVeiculo().getId(), resultVeiculos.get(i).getTipoVeiculo().getId());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }
    
}
