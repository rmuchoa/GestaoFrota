package notifica;

import java.util.Date;
import java.util.List;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.entity.SolicitacaoViagem;
import model.entity.Usuario;
import model.entity.Viagem;
import util.Datas;

/**
 *
 * @author Nasser
 */
public class Notificacoes {

    public static final String OBS = "<p>OBS: Este é um e-mail gerado automaticamente pelo Sistema de Controle de Frotas</p>"
            + "<p>Por favor, não responda este e-mail</p>";
    public static final String VIAGEM_AUTORIZADA_TEMPLATE = "<!DOCTYPE html>"
            + "<html lang=\"pt-br\">"
            + "<head>"
            + "<meta charset=\"UTF-8\">"
            + "</head>"
            + "<body>"
            + "<h1>Viagem Confirmada!</h1>"
            + "<p>Olá {{solicitante}}</p> "
            + "<p>A viagem abaixo está confirmada!</p>"
            + "<p>Caso haja algum erro nas informações, </p>"
            + "<p>favor informar ao operador da frota imediatamente.</p>"
            + "<p>Abaixo seguem os dados da viagem:</p>"
            + "<p>Cidade de origem: {{cidadeOrigem}}</p>"
            + "<p>Data de saída: {{dataSaida}}</p>"
            + "<p>Hora de saída: {{horaSaida}}</p>"
            + "<p>Cidade de destino: {{cidadeDestino}}</p>"
            + "<p>Data de retorno: {{dataRetorno}}</p>"
            + "<p>Hora de retorno: {{horaRetorno}}</p>"
            + OBS
            + "</body>"
            + "</html>";
    public static final String VIAGEM_CANCELADA_TEMPLATE = "<!DOCTYPE html>"
            + "<html lang=\"pt-br\">"
            + "<head>"
            + "<meta charset=\"UTF-8\">"
            + "</head>"
            + "<body>"
            + "<h1>Viagem Cancelada</h1>"
            + "<p>Olá {{solicitante}}</p> "
            + "<p>A viagem com o número {{id}} foi cancelada</p>"
            + "<p>Abaixo os dados:</p>"
            + "<p>Cidade de origem: {{cidadeOrigem}}</p>"
            + "<p>Data de saída: {{dataSaida}}</p>"
            + "<p>Hora de saída: {{horaSaida}}</p>"
            + "<p>Cidade de destino: {{cidadeDestino}}</p>"
            + "<p>Data de retorno: {{dataRetorno}}</p>"
            + "<p>Hora de retorno: {{horaRetorno}}</p>"
            + OBS
            + "</body>"
            + "</html>";
    public static final String VIAGEM_CRIADA_TEMPLATE = "<!DOCTYPE html>"
            + "<html lang=\"pt-br\">"
            + "<head>"
            + "<meta charset=\"UTF-8\">"
            + "</head>"
            + "<body>"
            + "<h1>Viagem Criada</h1>"
            + "<p>Olá {{solicitante}}</p> "
            + "<p>A sua solicitação de viagem foi agendada, sob o número {{id}}</p>"
            + "<p>porém ainda não foi confirmada</p>"
            + "<p>Cidade de origem: {{cidadeOrigem}}</p>"
            + "<p>Data de saída: {{dataSaida}}</p>"
            + "<p>Hora de saída: {{horaSaida}}</p>"
            + "<p>Cidade de destino: {{cidadeDestino}}</p>"
            + "<p>Data de retorno: {{dataRetorno}}</p>"
            + "<p>Hora de retorno: {{horaRetorno}}</p>"
            + "<p>Lista de passageiros: {{listaPassageiros}}</p>"
            + OBS
            + "</body>"
            + "</html>";
    public static final String SOLICITACAO_RECUSADA_TEMPLATE = "<!DOCTYPE html>"
            + "<html lang=\"pt-br\">"
            + "<head>"
            + "<meta charset=\"UTF-8\">"
            + "</head>"
            + "<body>"
            + "<h1>Solicitação Recusada</h1>"
            + "<p>Olá {{solicitante}}</p> "
            + "<p>Sua solicitação de viagem foi recusada pelo operador da frota</p>"
            + "<p>Abaixo, seguem os dados da solicitação recusada, juntamente com a justificativa.</p>"
            + "<p>Cidade de origem: {{cidadeOrigem}}</p>"
            + "<p>Data de saída: {{dataSaida}}</p>"
            + "<p>Hora de saída: {{horaSaida}}</p>"
            + "<p>Cidade de destino: {{cidadeDestino}}</p>"
            + "<p>Data de retorno: {{dataRetorno}}</p>"
            + "<p>Hora de retorno: {{horaRetorno}}</p>"
            + "<p>Lista de passageiros: {{listaPassageiros}}</p>"
            + "<p>Justificativa: {{justificativa}}</p>"
            + OBS
            + "</body>"
            + "</html>";

    private Session getSession() {
        Properties props = System.getProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        Authenticator auth = new SMTPAuthenticator("sistemacarona@gmail.com",
                "rpvisistema");
        Session session = Session.getInstance(props, auth);
        return session;
    }

    private void sendMail(String to, Session session, String message) {
        try {

            Message msg = new MimeMessage(session);

            // -- Set the FROM and TO fields --
            msg.setFrom(new InternetAddress("sistemacarona@gmail.com"));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Notificação de Viagem - Unipampa");
            msg.setContent(message, "text/html; charset=utf-8");
            // -- Set some other header information --
            msg.setHeader("Unipampa", "Sistema de Carona");
            msg.setSentDate(new Date());

            // -- Send the message --
            Transport.send(msg);
            System.out.println("Message sent to" + to + " OK.");


        } catch (javax.mail.AuthenticationFailedException e) {

            e.printStackTrace();
        } catch (javax.mail.MessagingException m) {
            m.printStackTrace();
        }


    }

    public void sendmail(String to, String template) {
        String html = template;
        this.sendMail(to, this.getSession(), html);
    }

    /**
     * Envia e-mail informando que a solicitação foi recusada Destinatário:
     * solicitante
     *
     * @param solicitacao
     */
    public void notificaRecusaSolicitacao(SolicitacaoViagem solicitacao) {
        String html = Notificacoes.SOLICITACAO_RECUSADA_TEMPLATE.replace(
                "{{solicitante}}", solicitacao.getSolicitante().getNome());
        html = html.replace("{{cidadeOrigem}}", solicitacao.getOrigem().getNome());
        html = html.replace("{{dataSaida}}", Datas.getDate(solicitacao.getDataSaida()));
        html = html.replace("{{horaSaida}}", Datas.getTime(solicitacao.getDataSaida()));
        html = html.replace("{{cidadeDestino}}", solicitacao.getDestino().getNome());
        html = html.replace("{{dataRetorno}}", solicitacao.getDataRetorno().toString());
        html = html.replace("{{horaRetorno}}", Datas.getTime(solicitacao.getDataRetorno()));
        html = html.replace("{{justificativa}}", solicitacao.getJustificativa());
        this.sendmail(solicitacao.getSolicitante().getEmail(), html);
    }

    /**
     * Envia e-mail informando que foi criada uma viagem para a solicitacao
     * Destinatário: solicitante, motorista
     *
     * @param solicitacao
     */
    public void notificaViagemCriada(SolicitacaoViagem solicitacao) {
        String html = Notificacoes.VIAGEM_CRIADA_TEMPLATE.replace(
                "{{solicitante}}", solicitacao.getSolicitante().getNome());
        html = html.replace("{{cidadeOrigem}}", solicitacao.getOrigem().getNome());
        html = html.replace("{{dataSaida}}", Datas.getDate(solicitacao.getDataSaida()));
         html = html.replace("{{horaSaida}}", Datas.getTime(solicitacao.getDataSaida()));
        html = html.replace("{{cidadeDestino}}", solicitacao.getDestino().getNome());
        html = html.replace("{{dataRetorno}}", Datas.getDate(solicitacao.getDataRetorno()));
        html = html.replace("{{horaRetorno}}", Datas.getTime(solicitacao.getDataRetorno()));
        html = html.replace("{{justificativa}}", solicitacao.getJustificativa());
        if (solicitacao.getViagem() != null) {
            html = html.replace("{{id}}", solicitacao.getViagem().getId().toString());
            String html2 = html;
            //Envia e-mail para o motorista
            html2 = html2.replace("{{solicitante}}", solicitacao.getViagem().getMotorista().getNome());
            this.sendmail(solicitacao.getViagem().getMotorista().getEmail(), html2);
        }
        this.sendmail(solicitacao.getSolicitante().getEmail(), html);
    }

    /**
     * Envia e-mail informando que foi cancelada uma viagem para a solicitacao
     * Destinatário: solicitantes, motorista
     *
     * @param solicitacao
     */
    public void notificaCanceladaViagem(Viagem viagem) {
        String html = Notificacoes.VIAGEM_CANCELADA_TEMPLATE;
        html = html.replace("{{id}}", viagem.getId().toString());
        html = html.replace("{{cidadeOrigem}}", viagem.getCidadeOrigem().getNome());
        html = html.replace("{{dataSaida}}", Datas.getDate(viagem.getDataSaida()));
        html = html.replace("{{horaSaida}}", Datas.getTime(viagem.getDataSaida()));
        html = html.replace("{{cidadeDestino}}", viagem.getCidadeRetorno().getNome());
        html = html.replace("{{dataRetorno}}", Datas.getDate(viagem.getDataRetorno()));
        html = html.replace("{{horaRetorno}}", Datas.getTime(viagem.getDataRetorno()));

        for (int i = 0; i < viagem.getSolicitacoes().size(); i++) {
            for (int j = 0; j < viagem.getSolicitacoes().get(i).getPassageiros().size(); j++) {
                String html2 = html;
                html2 = html2.replace("{{solicitante}}", viagem.getSolicitacoes().get(i).getPassageiros().get(j).getNome());

                this.sendmail(viagem.getSolicitacoes().get(i).getPassageiros().get(j).getEmail(), html2);
            }
        }
        //Envia e-mail para motorista
        this.sendmail(viagem.getMotorista().getEmail(), html);
    }

    /**
     * Envia e-mail de confirmação de viagem 
     * Destinatários: solicitantes, motorista
     *
     * @param viagem
     */
    public void notificaAutorizacaoViagem(Viagem viagem) {
        String html = Notificacoes.VIAGEM_AUTORIZADA_TEMPLATE;
        html = html.replace("{{cidadeOrigem}}", viagem.getCidadeOrigem().getNome());
        html = html.replace("{{dataSaida}}", Datas.getDate(viagem.getDataSaida()));
        html = html.replace("{{horaSaida}}", Datas.getTime(viagem.getDataSaida()));
        html = html.replace("{{cidadeDestino}}", viagem.getCidadeRetorno().getNome());
        html = html.replace("{{dataRetorno}}", Datas.getDate(viagem.getDataRetorno()));
        html = html.replace("{{horaRetorno}}", Datas.getTime(viagem.getDataRetorno()));

        for (int i = 0; i < viagem.getSolicitacoes().size(); i++) {
            for (int j = 0; j < viagem.getSolicitacoes().get(i).getPassageiros().size(); j++) {
                String html2 = html;
                html2 = html2.replace("{{solicitante}}", viagem.getSolicitacoes().get(i).getPassageiros().get(j).getNome());

                this.sendmail(viagem.getSolicitacoes().get(i).getPassageiros().get(j).getEmail(), html2);
            }
        }

        this.sendmail(viagem.getMotorista().getEmail(), html);

    }

    public void sendbatch(List<Usuario> recpts, String template) {
        for (Usuario user : recpts) {
            String fix = template.replace("{{solicitante}}",
                    user.getNome());
            this.sendmail(user.getEmail(), fix);
        }
    }

    private class SMTPAuthenticator extends javax.mail.Authenticator {

        private String user;
        private String psswd;

        public SMTPAuthenticator(String user, String psswd) {
            super();
            this.user = user;
            this.psswd = psswd;
        }

        @Override
        public PasswordAuthentication getPasswordAuthentication() {                             // specify your password here
            return new PasswordAuthentication(user, psswd);
        }
    }
}