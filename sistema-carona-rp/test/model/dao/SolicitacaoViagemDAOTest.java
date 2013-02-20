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
import model.entity.Usuario;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author renanmarceluchoa
 */
public class SolicitacaoViagemDAOTest {
    
    private static Connection connection;
    private static SolicitacaoViagem solicitacao;
    private static SolicitacaoViagem novaSolicitacao;
    
    public SolicitacaoViagemDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
        
        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        solicitacao = new SolicitacaoViagem();
        String sql1 = "select * from solicitacao_viagem where id = ?";
        
        try {

            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, 2);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                solicitacao.setId(rs.getInt("id"));
                solicitacao.setSolicitante(new UsuarioDAO().buscarPorId(rs.getInt("solicitante")));
                solicitacao.setDataSaida(rs.getDate("data_saida"));
                solicitacao.setLocalSaida(rs.getString("local_saida"));
                solicitacao.setDataRetorno(rs.getDate("data_retorno"));
                solicitacao.setLocalRetorno(rs.getString("local_retorno"));
                solicitacao.setJustificativa(rs.getString("justificativa"));
                solicitacao.setObservacoes(rs.getString("observacoes"));
                solicitacao.setOrigem(new CidadeDAO().buscarPorId(rs.getInt("origem")));
                solicitacao.setDestino(new CidadeDAO().buscarPorId(rs.getInt("destino")));
                solicitacao.setPercurso(rs.getString("percurso"));
                solicitacao.setSituacao(new SituacaoDAO().buscarPorId(rs.getInt("situacao")));
                solicitacao.setPassageiro(Boolean.parseBoolean("eh_passageiro"));
                
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        solicitacao.setPassageiros(new ArrayList<Passageiro>());
        String sql2 = "select p.id, p.nome. p.rg, p.email, p.endereco, p.eh_servidor "
                + "from passageiro p, solicitacao_viagem_passageiro svp "
                + "where svp.solicitacao_viagem = ? and p.id = svp.passageiro";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql2);
            stmt.setInt(1, solicitacao.getId());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                Passageiro passageiro = new Passageiro();
                passageiro.setId(rs.getInt("p.id"));
                passageiro.setNome(rs.getString("p.nome"));
                passageiro.setRg(rs.getString("p.rg"));
                passageiro.setEmail(rs.getString("p.email"));
                passageiro.setEndereco(rs.getString("p.endereco"));
                passageiro.setServidor(rs.getBoolean("p.eh_servidor"));
                
                solicitacao.getPassageiros().add(passageiro);
                
            }
            
        } catch(SQLException e) {
            e.printStackTrace();
        }
        
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
        
        String sql1 = "delete from solicitacao_viagem where id = ?";
        
        try {
            
            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, novaSolicitacao.getId());
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
     * Test of buscarPorId method, of class SolicitacaoViagemDAO.
     */
    @Test
    public void testBuscarPorId() {
        System.out.println("buscarPorId");
        Integer id = solicitacao.getId();
        SolicitacaoViagemDAO dao = new SolicitacaoViagemDAO();
        SolicitacaoViagem resultSolicitacao = dao.buscarPorId(id);
        assertEquals(solicitacao.getId(), resultSolicitacao.getId());
        assertEquals(solicitacao.getSolicitante().getId(), resultSolicitacao.getSolicitante().getId());
        assertEquals(solicitacao.isPassageiro(), resultSolicitacao.isPassageiro());
        assertEquals(solicitacao.getDataSaida(), resultSolicitacao.getDataSaida());
        assertEquals(solicitacao.getLocalSaida(), resultSolicitacao.getLocalSaida());
        assertEquals(solicitacao.getDataRetorno(), resultSolicitacao.getDataRetorno());
        assertEquals(solicitacao.getLocalRetorno(), resultSolicitacao.getLocalRetorno());
        assertEquals(solicitacao.getOrigem().getId(), resultSolicitacao.getOrigem().getId());
        assertEquals(solicitacao.getPercurso(), resultSolicitacao.getPercurso());
        assertEquals(solicitacao.getDestino().getId(), resultSolicitacao.getDestino().getId());
        assertEquals(solicitacao.getJustificativa(), resultSolicitacao.getJustificativa());
        assertEquals(solicitacao.getObservacoes(), resultSolicitacao.getObservacoes());
        assertEquals(solicitacao.getSituacao().getId(), resultSolicitacao.getSituacao().getId());
        assertEquals(solicitacao.getPassageiros().size(), resultSolicitacao.getPassageiros().size());
        
        if (solicitacao.getPassageiros().size() == resultSolicitacao.getPassageiros().size()) {
            List<Passageiro> p1 = solicitacao.getPassageiros();
            List<Passageiro> p2 = resultSolicitacao.getPassageiros();
            for (int i=0; i<p1.size(); i++) {
                assertEquals(p1.get(i).getId(), p2.get(i).getId());
                assertEquals(p1.get(i).getNome(), p2.get(i).getNome());
                assertEquals(p1.get(i).getRg(), p2.get(i).getRg());
                assertEquals(p1.get(i).getEmail(), p2.get(i).getEmail());
                assertEquals(p1.get(i).getEndereco(), p2.get(i).getEndereco());
                assertEquals(p1.get(i).isServidor(), p2.get(i).isServidor());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
        
    }

    /**
     * Test of buscarPorDataSaida method, of class SolicitacaoViagemDAO.
     */
    @Test
    public void testBuscarPorDataSaida() {
        System.out.println("buscarPorDataSaida");
        Date dataSaida = solicitacao.getDataSaida();
        Usuario solicitante = solicitacao.getSolicitante();
        SolicitacaoViagemDAO dao = new SolicitacaoViagemDAO();
        SolicitacaoViagem resultSolicitacao = dao.buscarPorDataSaida(dataSaida, solicitante);
        assertEquals(solicitacao.getId(), resultSolicitacao.getId());
        assertEquals(solicitacao.getSolicitante().getId(), resultSolicitacao.getSolicitante().getId());
        assertEquals(solicitacao.isPassageiro(), resultSolicitacao.isPassageiro());
        assertEquals(solicitacao.getDataSaida(), resultSolicitacao.getDataSaida());
        assertEquals(solicitacao.getLocalSaida(), resultSolicitacao.getLocalSaida());
        assertEquals(solicitacao.getDataRetorno(), resultSolicitacao.getDataRetorno());
        assertEquals(solicitacao.getLocalRetorno(), resultSolicitacao.getLocalRetorno());
        assertEquals(solicitacao.getOrigem().getId(), resultSolicitacao.getOrigem().getId());
        assertEquals(solicitacao.getPercurso(), resultSolicitacao.getPercurso());
        assertEquals(solicitacao.getDestino().getId(), resultSolicitacao.getDestino().getId());
        assertEquals(solicitacao.getJustificativa(), resultSolicitacao.getJustificativa());
        assertEquals(solicitacao.getObservacoes(), resultSolicitacao.getObservacoes());
        assertEquals(solicitacao.getSituacao().getId(), resultSolicitacao.getSituacao().getId());
        assertEquals(solicitacao.getPassageiros().size(), resultSolicitacao.getPassageiros().size());
        
        if (solicitacao.getPassageiros().size() == resultSolicitacao.getPassageiros().size()) {
            List<Passageiro> p1 = solicitacao.getPassageiros();
            List<Passageiro> p2 = resultSolicitacao.getPassageiros();
            for (int i=0; i<p1.size(); i++) {
                assertEquals(p1.get(i).getId(), p2.get(i).getId());
                assertEquals(p1.get(i).getNome(), p2.get(i).getNome());
                assertEquals(p1.get(i).getRg(), p2.get(i).getRg());
                assertEquals(p1.get(i).getEmail(), p2.get(i).getEmail());
                assertEquals(p1.get(i).getEndereco(), p2.get(i).getEndereco());
                assertEquals(p1.get(i).isServidor(), p2.get(i).isServidor());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }

    /**
     * Test of inserir method, of class SolicitacaoViagemDAO.
     */
    @Test
    public void testInserir() {
        System.out.println("inserir");
        novaSolicitacao = new SolicitacaoViagem();
        novaSolicitacao.setSolicitante(new UsuarioDAO().buscarPorId(1));
        novaSolicitacao.setPassageiro(Boolean.FALSE);
        novaSolicitacao.setDataSaida(new Date());
        novaSolicitacao.setLocalSaida("teste");
        novaSolicitacao.setDataRetorno(new Date());
        novaSolicitacao.setDestino(new CidadeDAO().buscarPorId(1));
        novaSolicitacao.setPercurso("teste");
        novaSolicitacao.setOrigem(new CidadeDAO().buscarPorId(2));
        novaSolicitacao.setLocalRetorno("teste");
        novaSolicitacao.setJustificativa("teste");
        novaSolicitacao.setObservacoes("teste");
        novaSolicitacao.setPassageiros(new ArrayList<Passageiro>());
        novaSolicitacao.setSituacao(new SituacaoDAO().buscarPorId(1));
        novaSolicitacao.getPassageiros().add(new PassageiroDAO().inserir(new Passageiro("teste1", "teste1", "teste1","teste1",Boolean.FALSE)));
        novaSolicitacao.getPassageiros().add(new PassageiroDAO().inserir(new Passageiro("teste2", "teste2", "teste2","teste2",Boolean.FALSE)));
        SolicitacaoViagemDAO dao = new SolicitacaoViagemDAO();
        SolicitacaoViagem resultSolicitacao = dao.inserir(novaSolicitacao);
        assertEquals(novaSolicitacao.getSolicitante().getId(), resultSolicitacao.getSolicitante().getId());
        assertEquals(novaSolicitacao.isPassageiro(), resultSolicitacao.isPassageiro());
        assertEquals(novaSolicitacao.getDataSaida(), resultSolicitacao.getDataSaida());
        assertEquals(novaSolicitacao.getLocalSaida(), resultSolicitacao.getLocalSaida());
        assertEquals(novaSolicitacao.getDataRetorno(), resultSolicitacao.getDataRetorno());
        assertEquals(novaSolicitacao.getLocalRetorno(), resultSolicitacao.getLocalRetorno());
        assertEquals(novaSolicitacao.getOrigem().getId(), resultSolicitacao.getOrigem().getId());
        assertEquals(novaSolicitacao.getPercurso(), resultSolicitacao.getPercurso());
        assertEquals(novaSolicitacao.getDestino().getId(), resultSolicitacao.getDestino().getId());
        assertEquals(novaSolicitacao.getJustificativa(), resultSolicitacao.getJustificativa());
        assertEquals(novaSolicitacao.getObservacoes(), resultSolicitacao.getObservacoes());
        assertEquals(novaSolicitacao.getSituacao().getId(), resultSolicitacao.getSituacao().getId());
        assertEquals(novaSolicitacao.getPassageiros().size(), resultSolicitacao.getPassageiros().size());
        if (novaSolicitacao.getPassageiros().size() == resultSolicitacao.getPassageiros().size()) {
            List<Passageiro> p1 = novaSolicitacao.getPassageiros();
            List<Passageiro> p2 = resultSolicitacao.getPassageiros();
            for (int i=0; i<p1.size(); i++) {
                assertEquals(p1.get(i).getId(), p2.get(i).getId());
                assertEquals(p1.get(i).getNome(), p2.get(i).getNome());
                assertEquals(p1.get(i).getRg(), p2.get(i).getRg());
                assertEquals(p1.get(i).getEmail(), p2.get(i).getEmail());
                assertEquals(p1.get(i).getEndereco(), p2.get(i).getEndereco());
                assertEquals(p1.get(i).isServidor(), p2.get(i).isServidor());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
        
        if (novaSolicitacao.getDataSaida().equals(resultSolicitacao.getDataSaida()) &&
                novaSolicitacao.getSolicitante().getId() == resultSolicitacao.getSolicitante().getId()) {
            novaSolicitacao.setId(resultSolicitacao.getId());
        }
        
    }
    
}
