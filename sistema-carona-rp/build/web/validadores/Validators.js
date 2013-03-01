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

function validaFormularioUsuario(){
   
    $("#formularioUsuario").validate({

        rules:{
            nome:{
                required: true
            },
            login:{
                required: true
            },
            senha:{
                required: true
            },
            tipo:{
                required: true
            },
            email:{
                required: true
            },
            telefone:{
                required: true
            },
            celular:{
                required: true
            },
            rg:{
                required: true
            },
            siape:{
                required: true
            }
        },

        messages:{
            nome:{
                required: "Campo obrigatorio"
            },
            login:{
                required: "Campo obrigatorio"
            },
            senha:{
                required: "Campo obrigatorio"
            },
            tipo:{
                required: "Campo obrigatorio"
            },
            email:{
                required: "Campo obrigatorio"
            },
            telefone:{
                required: "Campo obrigatorio"
            },
            celular:{
                required: "Campo obrigatorio"
            }
        }
    });
}

function verificaCamposNumericos(){
    
    
}


