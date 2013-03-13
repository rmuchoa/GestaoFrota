/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.entity.Usuario;

/**
 *
 * @author renanmarceluchoa
 */
public class Autenticacao {
    
    private String page;
    
    public Autenticacao () {
        this.page = "index.jsp";
    }
    
    public Autenticacao (String page) {
        this.page = page;
    }
    
    public void valida(HttpSession session, HttpServletResponse response, String[] tiposUsuario) throws IOException {
        
        Usuario usuario = null;
        
        if (session.getAttribute("usuario") == null) {
            usuario = (Usuario) session.getAttribute("usuario");
            response.sendRedirect(page);
            return;
        }
        
        for (String tipo : tiposUsuario) {
            
            if (!usuario.getTipoUsuario().getDescricao().equals(tipo)) {
                response.sendRedirect(page);
            }
            
        }
        
    }
    
}
