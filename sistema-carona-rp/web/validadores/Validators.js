function validaFormularioVeiculo(){
  
//      $("#placa").mask("aaa-9999");
//      $("#renavan").mask("aaa-9999");
//      $("#telefone").mask("(99) 9999-9999");
//      $("#celular").mask("(99) 9999-9999");
//      $("#validade").mask("99/99/9999");
//      $("#categoria").mask("aaa");
//      $("#cep").mask("99999-999");
  
    $("#formularioVeiculo").validate({

        rules:{
            placa:{
                required: true, 
                minlength: 8,
                maxlength: 8
            },
            renavan:{
                required: true, 
                minlength: 10, 
                maxlength:10
            },
            tipo_veiculo:{
                required: true
            },
            marca:{
                required: true
            },
            modelo:{
                required: true
            },
            cor:{
                required: true
            },
            ano:{
                required: true,
                digits: true
            },
            capacidade_passageiros:{
                required: true,
                digits: true
            },
            capacidade_carga:{
                required: true,
                digits: true
            }
        },

        messages:{
            placa:{
                required: "Digite a placa do veiculo",
                minlength: "A placa deve seguir o modelo GGG-5454",
                maxlength: "A placa deve seguir o modelo GGG-5454"
            },
            renavan:{
                required: "Digite um Renavam",
                minLength: "O renavam deve seguir o modelo 6665556566",
                maxLength: "O renavam deve seguir o modelo 6665556566"
            },
            tipo_veiculo:{
                required: "Selecione o tipo de veiculo"
            },
            marca:{
                required: "Informe a marca do veiculo"
            },
            modelo:{
                required: "Informe o modelo do veiculo"
            },
            cor:{
                required: "Informe a cor do veiculo"
            },
            ano:{
                required: "Informe o ano do veiculo",
                digits: "Digite apenas numero"
            },
            capacidade_passageiros:{
                required:" Informe a capacidade de passageiros",
                digits: "Digite apenas numero"
            },
            capacidade_carga:{
                required:" Informe a capacidade de carga em Kg do veiculo",
                digits: "Digite apenas numero"
            }
        }
    });
}

function validaFormularioVeiculo(){

    $("#formularioUsuario").validate({

        rules:{
            tipo:{
                required: true
            },
            telefone: {
                maxLength: 11
            },
            celular: {
                maxLength: 11
            },
            rg: {
                maxLength: 20
            },
            siape:{
                digits: true, 
                maxLength: 11
            },
            cnh:{
                digits: true, 
                maxLength: 20
            },
            categoria: {
                maxLength: 3
            },
            cidade:{
                required: true
            },
            cep: {
                maxLength: 8
            },
            numero: {
                digits: true, 
                maxLength: 11
            }
        },

        messages:{
            telefone:{
                maxLength: "O telefone deve seguir o padrão: '(99) 9999-9999'"
            },
            celular:{
                maxLength: "O celular deve seguir o padrão '(99) 9999-9999'"
            },
            rg:{
                maxLength: "O rg não pode passar de 20 caractéres" 
            },
            cidade:{
                required: "Selecione uma cidade para o usuário"
            },
            tipo:{
                required: "Selecione um tipo para o usuário"
            },
            siape:{
                digits: "Digite apenas números",
                maxLength: "O número de siape não pode ter ultrapassar 11 caractéres"
            },
            cnh: {
                digits: "Digite apenas números",
                maxLength: "O número da carteira de habilitação não pode ultrapassar 20 caractéres"
            },
            cetegoria:{
                maxLength: "A categoria deve ter no máximo 3 caratéres e seguir o padrão: 'ABC'"
            },
            numero: {
                digits: "Digite apenas números",
                maxLength: "O número não pode ultrapassar 11 caractéres"
            },
            cep: {
                maxLength: "O cep não pode ultrapassar 8 caracteres"
            }
        }
    });
}

function verificaCamposNumericos(){
    
    
}


