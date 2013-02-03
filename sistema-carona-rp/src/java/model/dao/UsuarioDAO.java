/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.*;
import jdbc.ConnectionFactory;
import java.util.ArrayList;
import java.util.List;
import javax.jms.JMSException;
import model.entity.Usuario;

/**
 *
 * @author Marcelo Maia
 */
public class UsuarioDAO {

    private Connection connection;

    public UsuarioDAO() {
        try {
            this.connection = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void inserir(Usuario usuario) {
        String sql = "insert into usuario (nome, login, senha, tipo_usuario, email, telefone, celular, "
                + "rg, siape, numero_cnh, validade_cnh, categoria_cnh, rua, numero, complemento, cep, cidade) "
                + "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getLogin());
            stmt.setString(3, usuario.getSenha());
            stmt.setInt(4, usuario.getTipoUsuario().getId());
            stmt.setString(5, usuario.getEmail());
            stmt.setString(6, usuario.getTelefone());
            stmt.setString(7, usuario.getCelular());
            stmt.setString(8, usuario.getRg());
            stmt.setInt(9, usuario.getSiape());
            stmt.setLong(10, usuario.getNumeroCnh());
            stmt.setDate(11, new Date(usuario.getValidadeCnh().getTime()));
            stmt.setString(12, usuario.getCategoriaCnh());
            stmt.setString(13, usuario.getRua());
            stmt.setInt(14, usuario.getNumero());
            stmt.setString(15, usuario.getComplemento());
            stmt.setString(16, usuario.getCep());
            stmt.setInt(17, usuario.getCidade().getId());
            stmt.execute();
            stmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void alterar(Usuario usuario) {
        String sql = "update usuario set nome = ?, login = ?, senha = ?, tipo_usuario = ?, "
                + "email = ?, telefone = ?, celular = ?, rg = ?, siape = ?, "
                + "numero_cnh = ?, validade_cnh = ?, categoria_cnh = ?, "
                + "rua = ?, numero = ?, complemento = ?, cep = ?, cidade = ? where id = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getLogin());
            stmt.setString(3, usuario.getSenha());
            stmt.setInt(4, usuario.getTipoUsuario().getId());
            stmt.setString(5, usuario.getEmail());
            stmt.setString(6, usuario.getTelefone());
            stmt.setString(7, usuario.getCelular());
            stmt.setString(8, usuario.getRg());
            stmt.setInt(9, usuario.getSiape());
            stmt.setLong(10, usuario.getNumeroCnh());
            stmt.setDate(11, new Date(usuario.getValidadeCnh().getTime()));
            stmt.setString(12, usuario.getCategoriaCnh());
            stmt.setString(13, usuario.getRua());
            stmt.setInt(14, usuario.getNumero());
            stmt.setString(15, usuario.getComplemento());
            stmt.setString(16, usuario.getCep());
            stmt.setInt(17, usuario.getCidade().getId());
            stmt.setInt(18, usuario.getId());

            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void remover(Usuario usuario) {

        String sql = "delete from usuario where id = ? ";

        try {
            PreparedStatement stmt = this.connection.prepareStatement(sql);
            stmt.setInt(1, usuario.getId());

            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removerPorId(int id) {

        String sql = "delete from usuario where id = ? ";

        try {
            PreparedStatement stmt = this.connection.prepareStatement(sql);
            stmt.setInt(1, id);

            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Usuario> listar() {

        List<Usuario> lista = new ArrayList<Usuario>();
        String sql = "select * from usuario";
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                TipoUsuarioDAO tipoUsuarioDAO = new TipoUsuarioDAO();
                CidadeDAO cidadeDAO = new CidadeDAO();

                Usuario usuario = new Usuario();
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

                lista.add(usuario);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;

    }

    public Usuario buscarPorId(int id) {

        Usuario usuario = new Usuario();
        String sql = "select * from usuario where id = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
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
        
        return usuario;
        
    }
    
    
    public Usuario buscarPorNome(String  nome) {

        Usuario usuario = new Usuario();
        String sql = "select * from usuario where nome = ?";

        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, nome);
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
        
        return usuario;
        
    }
}
