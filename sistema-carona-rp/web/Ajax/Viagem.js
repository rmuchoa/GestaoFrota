function preencheTabela(dataInicial,dataFinal){
       
    $.ajax({
        type:'GET',
        url: '/sistema-carona-rp/viagem/ListaSolicitacoesAjax.jsp?dataInicial='+dataInicial+'&dataFinal?='+dataFinal,
        dataType: 'html',
        data:{
            dataInicial:dataInicial,
            dataFinal:dataFinal
        },
        success: function(data) {
          
            $('#tabela').html(data);
           
        }
        
    });
    
}

function adicionarNovasSolicitacoes(){
    $(function() {
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
    });
}
