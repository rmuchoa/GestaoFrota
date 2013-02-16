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
import java.util.Date;
import java.util.List;
import jdbc.ConnectionFactory;
import model.entity.Passageiro;
import model.entity.SolicitacaoViagem;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;
import org.junit.*;

/**
 *
 * @author renanmarceluchoa
 */
public class PassageiroDAOTest {
    
    private static Connection connection;
    private static Passageiro passageiro;
    private static List<Passageiro> passageiros;
    private static List<Passageiro> passageirosPorNome;
    private static Passageiro novoPassageiro;
    private static SolicitacaoViagem solicitacaoViagem;
    
    public PassageiroDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
        
        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        passageiro = new Passageiro();
        String sql1 = "select * from passageiro where id = ?";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, 2);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                passageiro.setId(rs.getInt("id"));
                passageiro.setNome(rs.getString("nome"));
                passageiro.setRg(rs.getString("rg"));
                passageiro.setEmail(rs.getString("email"));
                passageiro.setEndereco(rs.getString("endereco"));
                passageiro.setServidor(rs.getBoolean("eh_servidor"));
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        passageiros = new ArrayList<Passageiro>();
        String sql2 = "select * from passageiro";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql2);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                Passageiro p = new Passageiro();
                p.setId(rs.getInt("id"));
                p.setNome(rs.getString("nome"));
                p.setRg(rs.getString("rg"));
                p.setEmail(rs.getString("email"));
                p.setEndereco(rs.getString("endereco"));
                p.setServidor(rs.getBoolean("eh_servidor"));

                passageiros.add(p);
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        passageirosPorNome = new ArrayList<Passageiro>();
        for (Passageiro p : passageiros) {
            if (p.getNome().equals(passageiro.getNome())) {
                passageirosPorNome.add(p);
            }
        }
        
        solicitacaoViagem = new SolicitacaoViagem();
        String sql3 = "select * from solicitacao_viagem where id = ?";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql3);
            stmt.setInt(1, 2);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                solicitacaoViagem.setId(rs.getInt("id"));
                solicitacaoViagem.setSolicitante(new UsuarioDAO().buscarPorId(rs.getInt("solicitante")));
                solicitacaoViagem.setDataSaida(new Date(rs.getDate("data_saida").getTime()));
                solicitacaoViagem.setLogalSaida(rs.getString("local_saida"));
                solicitacaoViagem.setDataRetorno(new Date(rs.getDate("data_retorno").getTime()));
                solicitacaoViagem.setLocalRetorno(rs.getString("local_saida"));
                solicitacaoViagem.setOrigem(new CidadeDAO().buscarPorId(rs.getInt("origem")));
                solicitacaoViagem.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacaoViagem.setPercurso(rs.getString("percurso"));
                solicitacaoViagem.setJustificativa(rs.getString("justificativa"));
                solicitacaoViagem.setObservacoes(rs.getString("observacoes"));
                solicitacaoViagem.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao")));
                solicitacaoViagem.setPassageiros(new ArrayList<Passageiro>());
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        String sql4 = "select p.id, p.nome, p.rg, p.email, p.endereco, p.eh_servidor "
                + "from passageiro p, solicitacao_viagem_passageiro svp "
                + "where svp.solicitacao_viagem = ? and svp.passageiro = p.id";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql4);
            stmt.setInt(1, solicitacaoViagem.getId());
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                
                Passageiro p = new Passageiro();
                p.setId(rs.getInt("p.id"));
                p.setNome(rs.getString("p.nome"));
                p.setRg(rs.getString("p.rg"));
                p.setEmail(rs.getString("p.email"));
                p.setEndereco(rs.getString("p.endereco"));
                p.setServidor(rs.getBoolean("p.eh_servidor"));
                solicitacaoViagem.getPassageiros().add(p);
                
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
        
        String sql1 = "delete from solicitacao_viagem_passageiro where solicitacao_viagem = ? and passageiro = ?";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, solicitacaoViagem.getId());
            stmt.setInt(2, novoPassageiro.getId());
            stmt.execute();
            stmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        String sql2 = "delete from passageiro where id = ?";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql2);
            stmt.setInt(1, novoPassageiro.getId());
            stmt.execute();
            stmt.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of buscarPorRg method, of class PassageiroDAO.
     */
    @Test
    public void testBuscarPorRg() {
        System.out.println("buscarPorRg");
        String rg = passageiro.getRg();
        PassageiroDAO dao = new PassageiroDAO();
        Passageiro resultPassageiro = dao.buscarPorRg(rg);
        assertEquals(passageiro.getId(), resultPassageiro.getId());
        assertEquals(passageiro.getNome(), resultPassageiro.getNome());
        assertEquals(passageiro.getRg(), resultPassageiro.getRg());
        assertEquals(passageiro.getEmail(), resultPassageiro.getEmail());
        assertEquals(passageiro.getEndereco(), resultPassageiro.getEndereco());
        assertEquals(passageiro.isServidor(), resultPassageiro.isServidor());
    }

    /**
     * Test of inserir method, of class PassageiroDAO.
     */
    @Test
    public void testInserir() {
        System.out.println("inserir");
        novoPassageiro = new Passageiro();
        novoPassageiro.setNome("teste");
        novoPassageiro.setRg("teste");
        novoPassageiro.setEmail("teste");
        novoPassageiro.setEndereco("teste");
        novoPassageiro.setServidor(Boolean.FALSE);
        PassageiroDAO dao = new PassageiroDAO();
        Passageiro resultPassageiro = dao.inserir(novoPassageiro);
        assertEquals(novoPassageiro.getNome(), resultPassageiro.getNome());
        assertEquals(novoPassageiro.getRg(), resultPassageiro.getRg());
        assertEquals(novoPassageiro.getEmail(), resultPassageiro.getEmail());
        assertEquals(novoPassageiro.getEndereco(), resultPassageiro.getEndereco());
        assertEquals(novoPassageiro.isServidor(), resultPassageiro.isServidor());
        novoPassageiro.setId(resultPassageiro.getId());
    }

    /**
     * Test of alterar method, of class PassageiroDAO.
     */
    @Test
    public void testAlterar() {
        System.out.println("alterar");
        novoPassageiro.setNome("novo teste");
        novoPassageiro.setEmail("novo teste");
        PassageiroDAO dao = new PassageiroDAO();
        Passageiro resultPassageiro = dao.alterar(novoPassageiro);
        assertEquals(novoPassageiro.getId(), resultPassageiro.getId());
        assertEquals(novoPassageiro.getNome(), resultPassageiro.getNome());
        assertEquals(novoPassageiro.getRg(), resultPassageiro.getRg());
        assertEquals(novoPassageiro.getEmail(), resultPassageiro.getEmail());
        assertEquals(novoPassageiro.getEndereco(), resultPassageiro.getEndereco());
        assertEquals(novoPassageiro.isServidor(), resultPassageiro.isServidor());
    }

    /**
     * Test of buscarPorSolicitacaoId method, of class PassageiroDAO.
     */
    @Test
    public void testBuscarPorSolicitacaoId() {
        System.out.println("buscarPorSolicitacaoId");
        Integer id = solicitacaoViagem.getId();
        PassageiroDAO dao = new PassageiroDAO();
        List<Passageiro> resultPassageiros = dao.buscarPorSolicitacaoId(id);
        assertEquals(solicitacaoViagem.getPassageiros().size(), resultPassageiros.size());
        if (solicitacaoViagem.getPassageiros().size() == resultPassageiros.size()) {
            for (int i=0; i<solicitacaoViagem.getPassageiros().size(); i++) {
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getId(), resultPassageiros.get(i).getId());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getNome(), resultPassageiros.get(i).getNome());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getRg(), resultPassageiros.get(i).getRg());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getEmail(), resultPassageiros.get(i).getEmail());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getEndereco(), resultPassageiros.get(i).getEndereco());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).isServidor(), resultPassageiros.get(i).isServidor());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }

    /**
     * Test of adicionarPassageiro method, of class PassageiroDAO.
     */
    @Test
    public void testAdicionarPassageiro() {
        System.out.println("adicionarPassageiro");
        PassageiroDAO dao = new PassageiroDAO();
        solicitacaoViagem.getPassageiros().add(novoPassageiro);
        dao.adicionarPassageiro(solicitacaoViagem, novoPassageiro);
        List<Passageiro> resultPassageiros = dao.buscarPorSolicitacaoId(solicitacaoViagem.getId());
        assertEquals(solicitacaoViagem.getPassageiros().size(), resultPassageiros.size());
        if (solicitacaoViagem.getPassageiros().size() == resultPassageiros.size()) {
            for (int i=0; i<solicitacaoViagem.getPassageiros().size(); i++) {
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getId(), resultPassageiros.get(i).getId());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getNome(), resultPassageiros.get(i).getNome());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getRg(), resultPassageiros.get(i).getRg());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getEmail(), resultPassageiros.get(i).getEmail());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).getEndereco(), resultPassageiros.get(i).getEndereco());
                assertEquals(solicitacaoViagem.getPassageiros().get(i).isServidor(), resultPassageiros.get(i).isServidor());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }
}
