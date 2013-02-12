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
import model.entity.OpcionalVeiculo;
import model.entity.Veiculo;
import model.entity.VeiculoOpcionalVeiculo;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author renanmarceluchoa
 */
public class VeiculoOpcionalVeiculoDAOTest {
    
    private static Connection connection;
    private static Veiculo veiculo;
    private static List<OpcionalVeiculo> opcionais;
    
    public VeiculoOpcionalVeiculoDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
        
        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        VeiculoDAO veiculoDAO = new VeiculoDAO();
        OpcionalVeiculoDAO opcionalVeiculoDAO = new OpcionalVeiculoDAO();
        
        veiculo = new Veiculo();
        veiculo.setAno(1000);
        veiculo.setMarca("teste");
        veiculo.setModelo("teste");
        veiculo.setCor("teste");
        veiculo.setPlaca("teste");
        veiculo.setRenavam(1000L);
        veiculo.setCapacidadePassageiros(1);
        veiculo.setCapacidadeCarga(10);
        veiculo.setTipoVeiculo(new TipoVeiculoDAO().getTipoPorId(1));
        veiculo = veiculoDAO.inserir(veiculo);
        
        opcionais = opcionalVeiculoDAO.getTodosOpcionais();
        int numOp = 2;
        
        for (OpcionalVeiculo opcional : opcionais) {
        
            if (numOp >=0) break;
            else numOp--;
            
            String sql = "insert into veiculo_opcionais_veiculo (id_veiculo,id_opcionais_veiculo) values (?,?)";
            
            try {
                
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setInt(1,veiculo.getId());
                stmt.setInt(2,opcional.getId());
                stmt.execute();
                stmt.close();
                
            } catch(SQLException e){
                e.printStackTrace();
            }
            
        }
        
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
        VeiculoDAO dao = new VeiculoDAO();
        dao.removerVeicupoPorId(veiculo.getId());
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of inserir method, of class VeiculoOpcionalVeiculoDAO.
     */
    @Test
    public void testInserir() {
        System.out.println("inserir");
        int id = veiculo.getId();
        OpcionalVeiculo opcionalVeiculo = new OpcionalVeiculoDAO().getOpcionalPorId(4);
        VeiculoOpcionalVeiculoDAO dao = new VeiculoOpcionalVeiculoDAO();
        dao.inserir(id, opcionalVeiculo);
        
        String sql = "select * from veiculo_opcionais_veiculo where id_veiculo = ?;";
        List<VeiculoOpcionalVeiculo> lista = new ArrayList<VeiculoOpcionalVeiculo>();
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                VeiculoOpcionalVeiculo vov = new VeiculoOpcionalVeiculo();
                vov.setVeiculo(new VeiculoDAO().getVeiculoPorId(rs.getInt("id_veiculo")));
                vov.setOpicionalVeiculo(new OpcionalVeiculoDAO().getOpcionalPorId(rs.getInt("id_opcionais_veiculo")));
                lista.add(vov);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        int i = 0;
        for (VeiculoOpcionalVeiculo vov : lista) {
            if (vov.getVeiculo().getId() == veiculo.getId() && 
                    vov.getOpicionalVeiculo().getId() == opcionalVeiculo.getId()) {
                assertEquals(vov.getVeiculo().getId(), veiculo.getId());
                assertEquals(vov.getOpicionalVeiculo().getId(), opcionalVeiculo.getId());
                i++;
            }
        }
        if (i > 1) {
            fail("Este opcional foi duplicado para esse veículo!");
        }
        
    }

    /**
     * Test of getPorIdVeiculo method, of class VeiculoOpcionalVeiculoDAO.
     */
    @Test
    public void testGetPorIdVeiculo() {
        System.out.println("getPorIdVeiculo");
        int id = veiculo.getId();
        VeiculoOpcionalVeiculoDAO dao = new VeiculoOpcionalVeiculoDAO();
        List<Integer> resultOpcionalIds = dao.getPorIdVeiculo(id);
        
        List<VeiculoOpcionalVeiculo> lista = new ArrayList<VeiculoOpcionalVeiculo>();
        String sql = "select * from veiculo_opcionais_veiculo where id_veiculo = ?;";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                VeiculoOpcionalVeiculo vov = new VeiculoOpcionalVeiculo();
                vov.setVeiculo(new VeiculoDAO().getVeiculoPorId(rs.getInt("id_veiculo")));
                vov.setOpicionalVeiculo(new OpcionalVeiculoDAO().getOpcionalPorId(rs.getInt("id_opcionais_veiculo")));
                lista.add(vov);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        assertEquals(lista.size(), resultOpcionalIds.size());
        if (lista.size() == resultOpcionalIds.size()) {
            for (int i=0; i<lista.size(); i++) {
                assertEquals(lista.get(i).getOpicionalVeiculo().getId(), resultOpcionalIds.get(i));
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }

    /**
     * Test of remover method, of class VeiculoOpcionalVeiculoDAO.
     */
    @Test
    public void testRemover() {
        System.out.println("remover");
        int id = veiculo.getId();
        OpcionalVeiculo opcionalVeiculo = new OpcionalVeiculoDAO().getOpcionalPorId(4);
        VeiculoOpcionalVeiculoDAO dao = new VeiculoOpcionalVeiculoDAO();
        dao.remover(id);
        List<Integer> lista = dao.getPorIdVeiculo(id);
        for (int i=0; i<lista.size(); i++) {
            assertFalse(lista.get(i) == opcionalVeiculo.getId());
        }
    }
}
