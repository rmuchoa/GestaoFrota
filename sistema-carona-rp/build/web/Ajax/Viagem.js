
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
        
//        $.ajax({
//            type: 'GET',
//            url: '../ajax/solicitacoesIntervaloDatas.jsp?dataInicial='+dataInicial+'&dataFinal?='+dataFinal,
//            dataType: 'html',
//            data:{
//                dataInicial:dataInicial,
//                dataFinal:dataFinal
//            },
//            success: function(data) {
//                $('#myModal').html(data);
//            }
//        });
        
    });
}
