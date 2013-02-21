function preencheTabela(dataInicial,dataFinal){
       
       $.ajax({
        type:'GET',
        url: '/sistema-carona-rp/viagem/ListaSolicitacoesAjax.jsp?dataInicial='+dataInicial+'&dataFinal?='+dataFinal,
        dataType: 'html',
        data:{dataInicial:dataInicial,dataFinal:dataFinal},
        success: function(data) {
          
          $('#tabela').html(data);
           
        }
        
    });
    
}

function adicionarNovasSolicitacoes(){
//      alert($("table#tabela1 tbody td#codigo").html());
}
