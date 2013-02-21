<%-- 
    Document   : index
    Created on : 27/Jan/2013, 12:44:03
    Author     : Marcelo Maia
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.*" %> 
<%@page import="javax.servlet.http.*" %> 
<!DOCTYPE html>



<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap.css">
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/css/bootstrap-responsive.css">
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/jquery-1.8.0.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/js/bootstrap.min.js"></script>
        
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/bootstrapt/pick/jquery-ui.css">
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery-ui.min.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/bootstrapt/pick/jquery.ui.datepicker-pt-BR.js"></script>
        <script type="text/javascript" src="/sistema-carona-rp/Ajax/Viagem.js"></script>
        
        <link rel=stylesheet type="text/css" href="/sistema-carona-rp/css/style.css">
        <script>
  $(document).ready(function() {
    $("#data_inicial").datepicker();
    $("#data_inicial").datepicker($.datepicker.regional['pt-BR']);
    $("#data_final").datepicker();
    $("#data_final").datepicker($.datepicker.regional['pt-BR']);
  });
 </script>
        <title>Sistema de Caronas Unipampa</title>
    </head>
  <script type="text/javascript">
     $(document).ready(function() {
          $('#form').submit(
          function(){
             var dataInicial =  $('#data_inicial').val();
             var dataFinal =  $('#data_final').val();
             alert(dataInicial+"-"+dataFinal)
             preencheTabela(dataInicial, dataFinal);
             return false;
          }
          
      );      
     });
</script>
    <body style="">
        <h3 style="text-align: center;color: green" class="span12 well">Sistema de Caronas Unipampa</h3>
            
            <div class="offset1 hero-unit span9">
                <div style="font-size: 9px;">Sejá bem vindo pitoco</div>
                <div>Listagem de solicitações de viagens do sistema</div>
                <br/>
                <form id="form">
                    Data Inicial:<input id="data_inicial" class="input-small" value="" type="text">
                    Data Final<input id="data_final" class="input-small" value="" type="text">
                    <input class="btn btn-success" type="submit" value="Filtrar">
                </form>
                <br/>
                <div class="well" >
                    <form id="formTabela">
                        <div id="tabela"></div>
                    </form>
                </div>
            </div>
        <br/>
    </body>
</html>
