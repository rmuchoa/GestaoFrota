/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package notifica;

import java.util.List;
import model.dao.SolicitacaoViagemDAO;
import model.entity.SolicitacaoViagem;
import model.entity.Usuario;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Nasser
 */
public class NotificacoesTest {
    //SolicitacaoViagem sv;
    public NotificacoesTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
        
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    
    @Test
    public void testSendmailSV() {
        SolicitacaoViagem sv = new SolicitacaoViagem();
        SolicitacaoViagemDAO svdao = new SolicitacaoViagemDAO();
        sv = svdao.buscarPorId(6);
        System.out.println("sendmailSolicita");
        String template = Notificacoes.SOLICITACAO_RECUSADA_TEMPLATE;
        Notificacoes instance = new Notificacoes();
        instance.notificaRecusa(sv);
        instance.notificaViagemCriada(sv);
        instance.notificaViagemCancelada(sv);
    }

    
   
}
