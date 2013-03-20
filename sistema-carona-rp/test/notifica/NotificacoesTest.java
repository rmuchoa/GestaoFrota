/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package notifica;

import java.util.List;
import model.dao.SolicitacaoViagemDAO;
import model.dao.ViagemDAO;
import model.entity.SolicitacaoViagem;
import model.entity.Usuario;
import model.entity.Viagem;
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
    public void testSendMailConfirmaViagem(){
        Viagem viagem = new Viagem();
        ViagemDAO vd = new ViagemDAO();
        viagem = vd.buscarPorId(3);
        Notificacoes instance2 = new Notificacoes();
        instance2.notificaAutorizacaoViagem(viagem);
    
    
    }
    
    
    
    
}
