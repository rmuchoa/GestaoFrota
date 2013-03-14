
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