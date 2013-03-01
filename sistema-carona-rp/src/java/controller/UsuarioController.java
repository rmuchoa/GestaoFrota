/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import model.dao.CidadeDAO;
import model.dao.TipoUsuarioDAO;
import model.dao.UsuarioDAO;
import model.entity.Usuario;

/**
 *
 * @author renanmarceluchoa
 */
public class UsuarioController {

    private Usuario usuario = new Usuario();
    private UsuarioDAO usuarioDAO = new UsuarioDAO();
    private TipoUsuarioDAO tipoUsuarioDAO = new TipoUsuarioDAO();
    private CidadeDAO cidadeDAO = new CidadeDAO();

    public void inserir(HttpServletRequest request) {

        try {
            usuario.setNome(request.getParameter("nome"));
            usuario.setLogin(request.getParameter("login"));
            usuario.setSenha(request.getParameter("senha"));
            usuario.setTipoUsuario(tipoUsuarioDAO.buscarPorId(Integer.parseInt(request.getParameter("tipo_usuario"))));
            usuario.setEmail(request.getParameter("email"));
            usuario.setTelefone(request.getParameter("telefone"));
            usuario.setCelular(request.getParameter("celular"));
            usuario.setRg(request.getParameter("rg"));
            usuario.setSiape(Integer.parseInt(request.getParameter("siape")));
            
            System.out.println(request.getParameter("numero_cnh").toString());
            
            if(!request.getParameter("numero_cnh").equals("")){
                usuario.setNumeroCnh(Long.parseLong(request.getParameter("numero_cnh")));
            }else{
                usuario.setNumeroCnh(Long.parseLong("0"));
            }
            
            usuario.setValidadeCnh(new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("validade_cnh")));
            usuario.setCategoriaCnh(request.getParameter("categoria_cnh"));
            usuario.setRua(request.getParameter("rua"));
            usuario.setNumero(Integer.parseInt(request.getParameter("numero")));
            usuario.setComplemento(request.getParameter("complemento"));
            usuario.setCep(request.getParameter("cep"));
            usuario.setCidade(cidadeDAO.buscarPorId(Integer.parseInt(request.getParameter("cidade"))));

             System.out.println(usuario.getNumeroCnh().toString());
            usuarioDAO.inserir(usuario);
        } catch (ParseException ex) {
            Logger.getLogger(UsuarioController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void alterar(HttpServletRequest request) {

        try {
            usuario.setId(Integer.parseInt(request.getParameter("id")));
            usuario.setNome(request.getParameter("nome"));
            usuario.setLogin(request.getParameter("login"));
            usuario.setSenha(request.getParameter("senha"));
            usuario.setTipoUsuario(tipoUsuarioDAO.buscarPorId(Integer.parseInt(request.getParameter("tipo_usuario"))));
            usuario.setEmail(request.getParameter("email"));
            usuario.setTelefone(request.getParameter("telefone"));
            usuario.setCelular(request.getParameter("celular"));
            usuario.setRg(request.getParameter("rg"));
            usuario.setSiape(Integer.parseInt(request.getParameter("siape")));
            usuario.setNumeroCnh(Long.parseLong(request.getParameter("numero_cnh")));
            usuario.setValidadeCnh(new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("validade_cnh")));
            usuario.setCategoriaCnh(request.getParameter("categoria_cnh"));
            usuario.setRua(request.getParameter("rua"));
            usuario.setNumero(Integer.parseInt(request.getParameter("numero")));
            usuario.setComplemento(request.getParameter("complemento"));
            usuario.setCep(request.getParameter("cep"));
            usuario.setCidade(cidadeDAO.buscarPorId(Integer.parseInt(request.getParameter("cidade"))));

            usuarioDAO.alterar(usuario);
        } catch (ParseException ex) {
            Logger.getLogger(UsuarioController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void remover(Usuario usuario) {
        usuarioDAO.remover(usuario);
    }

    public List<Usuario> listar() {
        return usuarioDAO.listar();
    }

    public Usuario buscarPorId(int id) {
        return usuarioDAO.buscarPorId(id);
    }
}
