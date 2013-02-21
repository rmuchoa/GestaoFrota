/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import model.dao.PassageiroDAO;
import model.dao.SolicitacaoViagemDAO;
import model.dao.UsuarioDAO;
import model.entity.Passageiro;
import model.entity.SolicitacaoViagem;
import model.entity.Usuario;

/**
 *
 * @author renanmarceluchoa
 */
public class PassageiroController {

    private Passageiro passageiro = new Passageiro();
    private PassageiroDAO passageiroDAO = new PassageiroDAO();

    public List<Passageiro> buscarPorSolicitacaoId(Integer id) {
        return passageiroDAO.buscarPorSolicitacaoId(id);
    }

    public void adicionarPassageiro(HttpServletRequest request) {

        passageiro.setNome(request.getParameter("nome"));
        passageiro.setRg(request.getParameter("rg"));
        passageiro.setEmail(request.getParameter("email"));
        passageiro.setEndereco(request.getParameter("endereco"));
        passageiro.setServidor(Boolean.parseBoolean(request.getParameter("servidor")));

        this.manterPassageiro((SolicitacaoViagem) request.getAttribute("solicitacao"));

    }
//
//    public void adicionarSolicitantePassageiro(HttpServletRequest request) {
//
//        Usuario solicitante = new UsuarioDAO().buscarPorId(Integer.parseInt(request.getParameter("solicitante")));
//
//        passageiro.setNome(solicitante.getNome());
//        passageiro.setRg(solicitante.getRg());
//        passageiro.setEmail(solicitante.getEmail());
//        passageiro.setEndereco("R. " + solicitante.getRua() + ", "
//                + solicitante.getNumero() + " " + solicitante.getComplemento() + " - "
//                + "CEP: " + solicitante.getCep() + " - "
//                + solicitante.getCidade().getNome() + "/" + solicitante.getCidade().getEstado().getSigla());
//        passageiro.setServidor(Boolean.TRUE);
//
//        this.manterPassageiro((SolicitacaoViagem) request.getAttribute("solicitacao"));
//
//    }

    private void manterPassageiro(SolicitacaoViagem solicitacao) {

        Passageiro encontrado = passageiroDAO.buscarPorRg(passageiro.getRg());

        if (encontrado == null) {
            
            Passageiro inserido = passageiroDAO.inserir(passageiro);
            passageiroDAO.adicionarPassageiro(solicitacao, inserido);
            
        } else {
            if (new SolicitacaoViagemDAO().naoEhRepetido(solicitacao, passageiro.getRg())) {
                
                if (!passageiro.getNome().equals(encontrado.getNome())
                        || passageiro.isServidor() != encontrado.isServidor()
                        || !passageiro.getEmail().equals(encontrado.getEmail())
                        || !passageiro.getEndereco().equals(encontrado.getEndereco())) {
                    encontrado.setNome(passageiro.getNome());
                    encontrado.setEmail(passageiro.getEmail());
                    encontrado.setEndereco(passageiro.getEndereco());
                    encontrado.setServidor(passageiro.isServidor());
                    passageiroDAO.alterar(encontrado);
                }
                
                passageiroDAO.adicionarPassageiro(solicitacao, encontrado);
                
            }
        }

    }
}
