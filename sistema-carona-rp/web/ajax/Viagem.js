
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
    $('#form').submit(function() {
//        
//        var veiculo = $('#veiculo').val();
//        var motorista = $('#motorista').val();
//        var estadoOrigem = ('#estadoOrigem').val();
//       var cidadeOrigem = ('#cidadeOrigem').val();
//        var data_saida = ('#data_saida').val();
//        var horario_saida = ('#horario_saida').val();
//       var  localSaida = ('#localSaida').val();
//       var  estadoRetorno = ('#estadoRetorno').val();
//       var  cidadeRetorno = ('#cidadeRetorno').val();
//       var  data_retorno = ('#data_retorno').val();
//      var   horario_retorno = ('#horario_retorno').val();
//      var  localRetorno = ('#localRetorno').val();
//      var   percurso = ('#percurso').val();
//      var   observacao = ('#observacao').val();
        
//        alert(veiculo,motorista,estadoOrigem,cidadeOrigem,data_retorno)
        alert('i')
        return false;
    });
}
