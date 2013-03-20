function detalheViagem(id){
   $.ajax({
        type: 'POST',
        url: '/sistema-carona-rp/ajax/detalheViagem.jsp',
        dataType: 'html',
        
        data:{
            id:id
        },
        success: function(data) {
           $('#detalheViagem').html(data); 
           $( "#detalheViagem" ).dialog({
                modal: true,
                width: 700 ,
                height: 500,
                buttons: {
                    Ok: function() {


                        $( this ).dialog( "close" );
                    }
        }
    });
        },
        error:function(status,error) {
             $('#conteudoTable').html(error+"-"+status);
             console.log(error)
        }
    }) 
}


function postCancelaViagem(id,justificativa){
    
    $.ajax({
        type: 'POST',
        url: '/sistema-carona-rp/ajax/cancelaViagem.jsp',
        dataType: 'html',
        
        data:{
            id:id,
            justificativa:justificativa
        },
        success: function(data) {
            $('#conteudoTable').html(data);
        },
        error:function(status,error) {
             $('#conteudoTable').html(error+"-"+status);
             console.log(error)
        }
    })
}


function cancelarViagem(id){
      $( "#modalJustificativa" ).dialog({
        modal: true,
        width: 400 ,
        height: 300,
        buttons: {
            Ok: function() {
               var justificativa =  $('#justificativa').val();
                postCancelaViagem(id, justificativa);
                $( this ).dialog( "close" );
            },
            Cancelar: function() {
                
                $( this ).dialog( "close" );
            }
        }
    });
}


function autorizarViagem(id){
    
    $.ajax({
        type: 'POST',
        url: '/sistema-carona-rp/ajax/autorizaViagem.jsp',
        dataType: 'html',
        
        data:{
            id:id
        },
        success: function(data) {
            $('#conteudoTable').html(data);
        },
        error:function(status,error) {
             $('#conteudoTable').html(error+"-"+status);
             console.log(error)
        }
    }) 
}


function buscaViagensAjax(pesquisa,valor_pesquisa){
   $.ajax({
        type: 'POST',
        url: '/sistema-carona-rp/ajax/viagens.jsp',
        dataType: 'html',
        
        data:{
            pesquisa:pesquisa,
            valor_pesquisa:valor_pesquisa
        },
        success: function(data) {
            $('#conteudoTable').html(data);
        },
        error:function(status,error) {
            alert(error)
        }
    }) 
}

function listaViagens(){
    
    $('#formBuscaViagem').submit(function() {
    
    var pesquisa= $('#pesquisa').val();
    var valor_pesquisa = $('#valor_pesquisa').val();
    buscaViagensAjax(pesquisa, valor_pesquisa);
    return false;
   });
}
function preencheTabela(dataInicial,dataFinal){
       
    $.ajax({
        type: 'GET',
        url: '../ajax/solicitacoesIntervaloDatas.jsp?dataInicial='+dataInicial+'&dataFinal?='+dataFinal,
        dataType: 'html',
        data:{
            dataInicial:dataInicial,
            dataFinal:dataFinal
        },
        success: function(data) {
            $('#conteudoForm').html(data);
        }
    });
    
}

function adicionarNovasSolicitacoes(){

    buscarSolicitacoes();
    $('#tabela1 tbody tr #identificador').each(function()
    {
        var id = $(this).text();
        alert(id)
        removerItemTabela2(id)
               
    });
    
   setTimeout(function(){
       
   
    $( "#myModal" ).dialog({
        modal: true,
        width: 700 ,
        height: 500,
        buttons: {
            Ok: function() {
                $('#tabela2 tbody tr #codigo').each(function()
                {
                    var id = $(this).text();
                    $("#cbx_checked").is(":checked")
                    if( $("#solicitacao"+id).is(":checked")){
                        inserirLinhaEscolhidaDoModalNaTabela2(id)
                    }
                         
                });
                $( this ).dialog( "close" );
            }
        }
    });
    },1000);
       
       
}     
function removerItemTabela2(id){
    $('#tabela2'+id).remove();
}
function removerItemTabela(id){
    $("tr#"+id).remove();
}

function exibirDetalhesItemDaTabela(texto){
   
   
    $('#ModalItemTabela').html(texto);
    $(function() {
        $( "#ModalItemTabela").dialog({
            modal: true,
            width: 700 ,
            height: 500,
            buttons: {
                Ok: function() {
                    $( this ).dialog( "close" );
                }
            }
        });
        
    });
}

function buscarSolicitacoes(){
    $.ajax({
        type: 'POST',
        url: '../ajax/solicitacoesAjax.jsp',
        dataType: 'html',
        
        success: function(data) {
            $('#ResultTabela').html(data);
        }
    });
}

function inserirLinhaEscolhidaDoModalNaTabela2(id){
    $.ajax({
        type: 'GET',
        url: '../ajax/inserirLinhaNaTabelaModal.jsp?id='+id,
        dataType: 'html',
        data:{
            id:id
        },
        success: function(data) {
            var html =  $('#escolhadomodal').html();
            $('#escolhadomodal').html(html+data);
        }
    });
}


function criarViagemForm(){
    $('#formViagem').submit(function() {
        
        var veiculo = $('#veiculo').val();
        var motorista = $('#motorista').val();
        var estadoOrigem = $('#estadoOrigem').val();
        var cidadeOrigem = $('#cidadeOrigem').val();
        var data_saida = $("#data_saida").val();
        var horario_saida = $('#horario_saida').val();
        var localSaida = $('#localSaida').val();
        var estadoRetorno = $('#estadoRetorno').val();
        var cidadeRetorno = $('#cidadeRetorno').val();
        var data_retorno = $('#data_retorno').val();
        var horario_retorno = $('#horario_retorno').val();
        var localRetorno = $('#localRetorno').val();
        var percurso = $('#percurso').val();
        var observacao = $('#observacao').val();
        var lista = getSolicitacoesTabela();
        cadastraViagem(lista,veiculo, motorista, estadoOrigem, cidadeOrigem, data_saida, horario_saida, localSaida, estadoRetorno, cidadeRetorno, data_retorno, horario_retorno, localRetorno, percurso, observacao);
        return false;
    });
}

function cadastraViagem(lista,veiculo,motorista,estadoOrigem,cidadeOrigem,data_saida,horario_saida,
    localSaida,estadoRetorno,cidadeRetorno,data_retorno,horario_retorno,localRetorno,percurso,observacao){
        
    $.ajax({
        type: 'POST',
        url: '../ajax/ViagemAjax.jsp',
        dataType: 'html',
        data:{
            lista:lista,
            veiculo:veiculo,
            motorista:motorista,
            estadoOrigem:estadoOrigem,
            cidadeOrigem:cidadeOrigem,
            data_saida:data_saida,
            horario_saida:horario_saida,
            localSaida:localSaida,
            estadoRetorno:estadoRetorno,
            cidadeRetorno:cidadeRetorno,
            data_retorno:data_retorno,
            horario_retorno:horario_retorno,
            localRetorno:localRetorno,
            percurso:percurso,
            observacao:observacao
        },
        success: function(data) {
             //$('#MensagemDeCadastro').html(data);
             $(function() {
                $( "#ModalItemTabela").dialog({
                    modal: true,
                    width: 400 ,
                    height: 300,
                    buttons: {
                        Ok: function() {
                            $( this ).dialog( "close" );
                        }
                    }
                });
        
    });
        }
    });
}

function getSolicitacoesTabela(){
    var listaSolicitacoes = new Array();
     
    $('#tabela1 tbody tr #identificador').each(function()
    {
        var id = $(this).text();
        listaSolicitacoes[listaSolicitacoes.length]=id;
                
    });
    
    var str='';
    for(var i=0;i<listaSolicitacoes.length;i++){
     str +=  listaSolicitacoes[i];
    }
    
    return str;
}
