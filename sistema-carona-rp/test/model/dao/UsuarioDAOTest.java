/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import jdbc.ConnectionFactory;
import model.entity.Usuario;
import static org.junit.Assert.*;
import org.junit.*;

/**
 *
 * @author renanmarceluchoa
 */
public class UsuarioDAOTest {

    private static Connection connection;
    private static Usuario usuario;
    private static List<Usuario> usuarios;
    private static Usuario novoUsuario;

    public UsuarioDAOTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {

        try {
            connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        usuario = new Usuario();
        String sql1 = "select * from usuario where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setInt(1, 2);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                TipoUsuarioDAO tipoUsuarioDAO = new TipoUsuarioDAO();
                CidadeDAO cidadeDAO = new CidadeDAO();

                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setLogin(rs.getString("login"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setTipoUsuario(tipoUsuarioDAO.buscarPorId(rs.getInt("tipo_usuario")));
                usuario.setEmail(rs.getString("email"));
                usuario.setTelefone(rs.getString("telefone"));
                usuario.setCelular(rs.getString("celular"));
                usuario.setRg(rs.getString("rg"));
                usuario.setSiape(rs.getInt("siape"));
                usuario.setNumeroCnh(rs.getLong("numero_cnh"));
                usuario.setValidadeCnh(rs.getDate("validade_cnh"));
                usuario.setCategoriaCnh(rs.getString("categoria_cnh"));
                usuario.setRua(rs.getString("rua"));
                usuario.setNumero(rs.getInt("numero"));
                usuario.setComplemento(rs.getString("complemento"));
                usuario.setCep(rs.getString("cep"));
                usuario.setCidade(cidadeDAO.buscarPorId(rs.getInt("cidade")));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        usuarios = new ArrayList<Usuario>();
        String sql2 = "select * from usuario";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql2);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                TipoUsuarioDAO tipoUsuarioDAO = new TipoUsuarioDAO();
                CidadeDAO cidadeDAO = new CidadeDAO();

                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setLogin(rs.getString("login"));
                u.setSenha(rs.getString("senha"));
                u.setTipoUsuario(tipoUsuarioDAO.buscarPorId(rs.getInt("tipo_usuario")));
                u.setEmail(rs.getString("email"));
                u.setTelefone(rs.getString("telefone"));
                u.setCelular(rs.getString("celular"));
                u.setRg(rs.getString("rg"));
                u.setSiape(rs.getInt("siape"));
                u.setNumeroCnh(rs.getLong("numero_cnh"));
                u.setValidadeCnh(rs.getDate("validade_cnh"));
                u.setCategoriaCnh(rs.getString("categoria_cnh"));
                u.setRua(rs.getString("rua"));
                u.setNumero(rs.getInt("numero"));
                u.setComplemento(rs.getString("complemento"));
                u.setCep(rs.getString("cep"));
                u.setCidade(cidadeDAO.buscarPorId(rs.getInt("cidade")));

                usuarios.add(u);

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
     * Test of buscarPorId method, of class UsuarioDAO.
     */
    @Test
    public void testBuscarPorId() {
        System.out.println("buscarPorId");
        int id = usuario.getId();
        UsuarioDAO dao = new UsuarioDAO();
        Usuario resultUsuario = dao.buscarPorId(id);
        assertEquals(usuario.getId(), resultUsuario.getId());
        assertEquals(usuario.getNome(), resultUsuario.getNome());
        assertEquals(usuario.getLogin(), resultUsuario.getLogin());
        assertEquals(usuario.getSenha(), resultUsuario.getSenha());
        assertEquals(usuario.getTipoUsuario().getId(), resultUsuario.getTipoUsuario().getId());
        assertEquals(usuario.getEmail(), resultUsuario.getEmail());
        assertEquals(usuario.getTelefone(), resultUsuario.getTelefone());
        assertEquals(usuario.getCelular(), resultUsuario.getCelular());
        assertEquals(usuario.getRg(), resultUsuario.getRg());
        assertEquals(usuario.getSiape(), resultUsuario.getSiape());
        assertEquals(usuario.getNumeroCnh(), resultUsuario.getNumeroCnh());
        assertEquals(usuario.getValidadeCnh(), resultUsuario.getValidadeCnh());
        assertEquals(usuario.getCategoriaCnh(), resultUsuario.getCategoriaCnh());
        assertEquals(usuario.getRua(), resultUsuario.getRua());
        assertEquals(usuario.getNumero(), resultUsuario.getNumero());
        assertEquals(usuario.getComplemento(), resultUsuario.getComplemento());
        assertEquals(usuario.getCep(), resultUsuario.getCep());
        assertEquals(usuario.getCidade().getId(), resultUsuario.getCidade().getId());
    }

    /**
     * Test of inserir method, of class UsuarioDAO.
     */
    @Test
    public void testInserir() throws ParseException {
        System.out.println("inserir");
        novoUsuario = new Usuario();
        novoUsuario.setNome("teste");
        novoUsuario.setLogin("teste");
        novoUsuario.setSenha("teste");
        novoUsuario.setTipoUsuario(new TipoUsuarioDAO().buscarPorId(1));
        novoUsuario.setEmail("teste@teste");
        novoUsuario.setTelefone("teste");
        novoUsuario.setCelular("teste");
        novoUsuario.setRg("teste");
        novoUsuario.setSiape(111111);
        novoUsuario.setNumeroCnh(1111111L);
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        novoUsuario.setValidadeCnh(dateFormat.parse(dateFormat.format(new Date())));
        novoUsuario.setCategoriaCnh("tst");
        novoUsuario.setRua("teste");
        novoUsuario.setNumero(1);
        novoUsuario.setComplemento("teste");
        novoUsuario.setCep("teste");
        novoUsuario.setCidade(new CidadeDAO().buscarPorId(1));
        UsuarioDAO dao = new UsuarioDAO();
        dao.inserir(novoUsuario);
        
        Usuario u = new Usuario();
        String sql1 = "select * from usuario where nome = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql1);
            stmt.setString(1, novoUsuario.getNome());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                TipoUsuarioDAO tipoUsuarioDAO = new TipoUsuarioDAO();
                CidadeDAO cidadeDAO = new CidadeDAO();

                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setLogin(rs.getString("login"));
                u.setSenha(rs.getString("senha"));
                u.setTipoUsuario(tipoUsuarioDAO.buscarPorId(rs.getInt("tipo_usuario")));
                u.setEmail(rs.getString("email"));
                u.setTelefone(rs.getString("telefone"));
                u.setCelular(rs.getString("celular"));
                u.setRg(rs.getString("rg"));
                u.setSiape(rs.getInt("siape"));
                u.setNumeroCnh(rs.getLong("numero_cnh"));
                u.setValidadeCnh(new Date(rs.getDate("validade_cnh").getTime()));
                u.setCategoriaCnh(rs.getString("categoria_cnh"));
                u.setRua(rs.getString("rua"));
                u.setNumero(rs.getInt("numero"));
                u.setComplemento(rs.getString("complemento"));
                u.setCep(rs.getString("cep"));
                u.setCidade(cidadeDAO.buscarPorId(rs.getInt("cidade")));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        assertEquals(novoUsuario.getNome(), u.getNome());
        assertEquals(novoUsuario.getLogin(), u.getLogin());
        assertEquals(novoUsuario.getSenha(), u.getSenha());
        assertEquals(novoUsuario.getTipoUsuario().getId(), u.getTipoUsuario().getId());
        assertEquals(novoUsuario.getEmail(), u.getEmail());
        assertEquals(novoUsuario.getTelefone(), u.getTelefone());
        assertEquals(novoUsuario.getCelular(), u.getCelular());
        assertEquals(novoUsuario.getRg(), u.getRg());
        assertEquals(novoUsuario.getSiape(), u.getSiape());
        assertEquals(novoUsuario.getNumeroCnh(), u.getNumeroCnh());
        assertEquals(novoUsuario.getValidadeCnh(), u.getValidadeCnh());
        assertEquals(novoUsuario.getCategoriaCnh(), u.getCategoriaCnh());
        assertEquals(novoUsuario.getRua(), u.getRua());
        assertEquals(novoUsuario.getNumero(), u.getNumero());
        assertEquals(novoUsuario.getComplemento(), u.getComplemento());
        assertEquals(novoUsuario.getCep(), u.getCep());
        assertEquals(novoUsuario.getCidade().getId(), u.getCidade().getId());
        
        if(novoUsuario.getNome().equals(u.getNome())) {
            novoUsuario.setId(u.getId());
        }
        
    }

    /**
     * Test of alterar method, of class UsuarioDAO.
     */
    @Test
    public void testAlterar() {
        System.out.println("alterar");
        novoUsuario.setLogin("novoLogin");
        novoUsuario.setSenha("novaSenha");
        UsuarioDAO dao = new UsuarioDAO();
        dao.alterar(novoUsuario);
        Usuario u = dao.buscarPorId(novoUsuario.getId());
        assertEquals(novoUsuario.getLogin(), u.getLogin());
        assertEquals(novoUsuario.getSenha(), u.getSenha());
    }

    /**
     * Test of remover method, of class UsuarioDAO.
     */
    @Test
    public void testRemover() {
        System.out.println("remover");
        UsuarioDAO dao = new UsuarioDAO();
        dao.remover(novoUsuario);
        Usuario u = dao.buscarPorId(novoUsuario.getId());
        assertTrue(u == null);
        //assertNull(u);
    }

    /**
     * Test of removerPorId method, of class UsuarioDAO.
     */
    @Test
    public void testRemoverPorId() {
        System.out.println("removerPorId");
        int id = novoUsuario.getId();
        UsuarioDAO dao = new UsuarioDAO();
        dao.removerPorId(id);
        Usuario u = dao.buscarPorId(id);
        assertNull(u);
    }

    /**
     * Test of listar method, of class UsuarioDAO.
     */
    @Test
    public void testListar() {
        System.out.println("listar");
        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> resultUsuarios = dao.listar();
        assertEquals(usuarios.size(), resultUsuarios.size());
        if (usuarios.size() == resultUsuarios.size()) {
            for (int i=0; i<usuarios.size(); i++) {
                assertEquals(usuarios.get(i).getId(), resultUsuarios.get(i).getId());
                assertEquals(usuarios.get(i).getNome(), resultUsuarios.get(i).getNome());
                assertEquals(usuarios.get(i).getLogin(), resultUsuarios.get(i).getLogin());
                assertEquals(usuarios.get(i).getSenha(), resultUsuarios.get(i).getSenha());
                assertEquals(usuarios.get(i).getTipoUsuario().getId(), resultUsuarios.get(i).getTipoUsuario().getId());
                assertEquals(usuarios.get(i).getEmail(), resultUsuarios.get(i).getEmail());
                assertEquals(usuarios.get(i).getTelefone(), resultUsuarios.get(i).getTelefone());
                assertEquals(usuarios.get(i).getCelular(), resultUsuarios.get(i).getCelular());
                assertEquals(usuarios.get(i).getRg(), resultUsuarios.get(i).getRg());
                assertEquals(usuarios.get(i).getSiape(), resultUsuarios.get(i).getSiape());
                assertEquals(usuarios.get(i).getNumeroCnh(), resultUsuarios.get(i).getNumeroCnh());
                assertEquals(usuarios.get(i).getValidadeCnh(), resultUsuarios.get(i).getValidadeCnh());
                assertEquals(usuarios.get(i).getCategoriaCnh(), resultUsuarios.get(i).getCategoriaCnh());
                assertEquals(usuarios.get(i).getRua(), resultUsuarios.get(i).getRua());
                assertEquals(usuarios.get(i).getNumero(), resultUsuarios.get(i).getNumero());
                assertEquals(usuarios.get(i).getComplemento(), resultUsuarios.get(i).getComplemento());
                assertEquals(usuarios.get(i).getCep(), resultUsuarios.get(i).getCep());
                assertEquals(usuarios.get(i).getCidade().getId(), resultUsuarios.get(i).getCidade().getId());
            }
        } else {
            fail("Não encontrou a lista correta!");
        }
    }
}
