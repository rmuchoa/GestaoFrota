/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import jdbc.ConnectionFactory;
import model.entity.SolicitacaoViagem;
import model.entity.Usuario;
import model.entity.Viagem;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author renanmarceluchoa
 */
public class ViagemDAOTest {
    
    private static Connection connection;
    private static Viagem viagem;
    
    
    public ViagemDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
        
        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        List<Usuario> motoristas = new UsuarioDAO().buscarMotoristas();
        
        viagem = new Viagem(new VeiculoDAO().getVeiculoPorId(1), motoristas.get(1), 
                new CidadeDAO().buscarPorId(1), new Date(), "teste", 
                new CidadeDAO().buscarPorId(2), new Date(), "teste",
                "teste", "teste", new SituacaoDAO().buscarPorId(2),new ArrayList<SolicitacaoViagem>());
        String sql = "insert into viagem (veiculo, motorista, cidade_origem, data_saida, local_saida, "
                + "cidade_retorno, data_retorno, local_retorno, percurso, observacoes, situacao_viagem)"
                + " values (?,?,?,?,?,?,?,?,?,?,?)";
             
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, viagem.getVeiculo().getId());
            stmt.setInt(2, viagem.getMotorista().getId());
            stmt.setInt(3, viagem.getCidadeOrigem().getId());
            stmt.setDate(4, new java.sql.Date(viagem.getDataSaida().getTime()));
            stmt.setString(5, viagem.getLocalSaida());
            stmt.setInt(6, viagem.getCidadeRetorno().getId());
            stmt.setDate(7, new java.sql.Date(viagem.getDataRetorno().getTime()));
            stmt.setString(8, viagem.getLocalRetorno());
            stmt.setString(9, viagem.getPercurso());
            stmt.setString(10, viagem.getObservacoes());
            stmt.setInt(11, viagem.getSituacao().getId());
            stmt.execute();
            
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                
                viagem.setId(rs.getInt(1));
                viagem.getSolicitacoes().add(new SolicitacaoViagemDAO().buscarPorId(1));
                
                if (!viagem.getSolicitacoes().isEmpty()) {
                    for (SolicitacaoViagem solicitacao : viagem.getSolicitacoes()) {

                        solicitacao.setSituacao(new SituacaoDAO().buscarPorId(2));
                        try {
                        
                            String sql2 = "update solicitacao_viagem set viagem = ?, situacao_solicitacao = ? where id = ?";
                            stmt = connection.prepareStatement(sql2);
                            stmt.setInt(1, viagem.getId());
                            stmt.setInt(2, solicitacao.getSituacao().getId());
                            stmt.setInt(3, solicitacao.getId());
                            stmt.executeUpdate();
                            
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        
                    }
                }
                
            }
            stmt.close();
            
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
     * Test of buscarPorId method, of class ViagemDAO.
     */
    @Test
    public void testBuscarPorId() {
        System.out.println("buscarPorId");
        Integer id = null;
        ViagemDAO instance = new ViagemDAO();
        Viagem expResult = null;
        Viagem result = instance.buscarPorId(id);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of buscarPorDataSaida method, of class ViagemDAO.
     */
    @Test
    public void testBuscarPorDataSaida() {
        System.out.println("buscarPorDataSaida");
        Date dataSaida = null;
        ViagemDAO instance = new ViagemDAO();
        List expResult = null;
        List result = instance.buscarPorDataSaida(dataSaida);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of listarViagens method, of class ViagemDAO.
     */
    @Test
    public void testListarViagens() {
        System.out.println("listarViagens");
        ViagemDAO instance = new ViagemDAO();
        List expResult = null;
        List result = instance.listarViagens();
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of inserir method, of class ViagemDAO.
     */
    @Test
    public void testInserir() {
        System.out.println("inserir");
        Viagem viagem = null;
        ViagemDAO instance = new ViagemDAO();
        Viagem expResult = null;
        Viagem result = instance.abrirViagem(viagem);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
}
