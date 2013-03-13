
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
        $( "#myModal" ).dialog({
            modal: true,
            width: 700 ,
            height: 500,
            buttons: {
                Ok: function() {
                    $( this ).dialog( "close" );
                }
            }
        });
       $('#tabela1 tbody tr #identificador').each(function()
        {
         var id = $(this).text();
         
         alert($('#tabela2').html());
        }); 
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
