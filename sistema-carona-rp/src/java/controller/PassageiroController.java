/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import model.dao.PassageiroDAO;
import model.entity.Passageiro;

/**
 *
 * @author renanmarceluchoa
 */
public class PassageiroController {
    
    private Passageiro passageiro = new Passageiro();
    private PassageiroDAO passageiroDAO = new PassageiroDAO();
    
    public List<Passageiro> buscarPorNome(String nome) {
        return passageiroDAO.buscarPorNome(nome);
    }
    
    public List<Passageiro> buscarPorSolicitacaoId(Integer id) {
        return passageiroDAO.buscarPorSolicitacaoId(id);
    }
    
    public void adicionarPassageiro(HttpServletRequest request) {
        passageiro.setNome(request.getParameter("nome"));
        passageiro.setRg(request.getParameter("rg"));
        passageiro.setEhServidor(Boolean.parseBoolean(request.getParameter("servidor")));
        
        Passageiro encontrado = passageiroDAO.buscarPorRg(passageiro.getRg());
        
        if (encontrado == null) {
            passageiroDAO.inserir(passageiro);
        } else {
            if (!passageiro.getNome().equals(encontrado.getNome())
                    || passageiro.getEhServidor() != encontrado.getEhServidor()) {
                encontrado.setNome(passageiro.getNome());
                encontrado.setEhServidor(passageiro.getEhServidor());
                passageiroDAO.alterar(encontrado);
                
            }
            
            passageiroDAO.adicionarPassageiro(Integer.parseInt(request.getParameter("solicitacao")), encontrado);
            
        }
        
    }
    
}
