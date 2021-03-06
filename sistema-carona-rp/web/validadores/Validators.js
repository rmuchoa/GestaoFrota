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
                minlength: 7,
                maxlength: 7
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
                minlength: "A placa deve seguir o modelo GGG5454",
                maxlength: "A placa deve seguir o modelo GGG5454"
            },
            renavan:{
                required: "Digite um Renavam",
                minlength: "O renavam deve seguir o modelo 1234567890",
                maxlength: "O renavam deve seguir o modelo 1234567890"
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
                digits: "Digite apenas número"
            },
            capacidade_passageiros:{
                required:" Informe a capacidade de passageiros",
                digits: "Digite apenas números"
            },
            capacidade_carga:{
                required:" Informe a capacidade de carga em kg do veiculo",
                digits: "Digite apenas número"
            }
        }
    });
}

function validaFormularioUsuario(){
   
    $("#formularioUsuario").validate({

        rules:{
            nome:{
                required: true,
                minlength: 6
            },
            login:{
                required: true,
                minlength: 6
            },
            senha:{
                required: true,
                minlength: 6
            },
            tipo:{
                required: true
            },
            email:{
                required: true,
                email: true
            },
            telefone:{
                required: true,
                maxlength: 10,
                minlength: 10,
                number: true
            },
            celular:{
                maxlength: 10,
                minlength: 10,
                number: true
            },
            rg:{
                required: true,
                maxlength: 20,
                number: true
            },
            siape:{
                
                required: true,
                number: true
            },
            numero_cnh:{
                number: true,
                maxlength: 11,
                minlength: 11
            },
            validade_cnh:{
                date: true
            },
            categoria_cnh:{
                maxlength: 3,
                minlength: 1
            },
            rua:{
                required: true
            },
            numero:{
                required: true,
                number: true
            },
            cep:{
                required: true,
                maxlength: 8,
                minlength: 8,
                number: true
            },
            estado:{
                required: true
            },
            cidade:{
                required: true
            }
        },

        messages:{
            nome:{
                required: "Campo obrigatorio",
                minlength: "Mínimo 6 caracteres"
            },
            login:{
                required: "Campo obrigatório",
                minlength: "Mínimo 6 caracteres"
            },
            senha:{
                required: "Campo obrigatório",
                minlength: "Mínimo 6 caracteres"
            },
            tipo:{
                required: "Campo obrigatório"
            },
            email:{
                required: "Campo obrigatório",
                email: "Formato de e-mail incorreto"
            },
            telefone:{
                required: "Campo obrigatório",
                maxlength: "Número inválido",
                minlength: "Número inválido",
                number: "Digite apenas números"
            },
            celular:{
                maxlength: "Número inválido",
                minlength: "Número inválido",
                number: "Digite apenas números"
            },
            rg:{
                required: "Campo obrigatório",
                maxlength: "Tamanho inválido",
                number: "Digite apenas números"
            },
            siape:{
                required: "Campo obrigatório",
                number: "Digite apenas números"
            },
            numero_cnh:{
                number: "Digite apenas números",
                maxlength: "Tamanho inválido",
                minlength: "Tamanho inválido"
            },
            validade_cnh:{
                date: "Data inválida"
            },
            categoria_cnh:{
                maxlength: "Tamanho inválido",
                minlength: "Tamanho inválido"
            },
            rua:{
                required: "Campo obrigatório"
            },
            numero:{
                required: "Campo obrigatório",
                number: "Digite apenas números"
            },
            cep:{
                required: "Campo obrigatório",
                maxlength: "CEP inválido",
                minlength: "CEP inválido",
                number: "Digite apenas números"
            },
            estado:{
                required: "Selecione um estado"
            },
            cidade:{
                required: "Selecione uma cidade"
            }
        }
    });
}

function validaSolicitacaoViagem(){
  
    $("#formularioSolicitacao").validate({

        rules:{
            solicitante:{
                required: true
                
            },
            cidadeOrigem:{
                required: true 
            },
            dataSaida:{
                //date: true,
                required: true
            },
            horaSaida:{
                required: true
            },
            localSaida:{
                required: true
            },
            cidadeRetorno:{
                required: true
            },
            dataRetorno:{
               // date: true,
                required: true
            },
            horaRetorno:{
                required: true
            },
            localRetorno:{
                required: true
            },
            percurso:{
                required: true
            }
        },

        messages:{
            solicitante:{
                required: "Selecione um solicitante"
                
            },
            cidadeOrigem:{
                required: "Selecione uma cidade" 
            },
            dataSaida:{
              //  date: "Data inválida",
                required: "Digite uma data"
            },
            horaSaida:{
                required: "Digite um horário"
            },
            localSaida:{
                required: "Digite um local de saída"
            },
            cidadeRetorno:{
                required: "Selecione uma cidade"
            },
            dataRetorno:{
              //  date: "Data inválida",
                required: "Digite uma data"
            },
            horaRetorno:{
                required: "Digite um horário"
            },
            localRetorno:{
                required: "Digite um local de retorno"
            },
            percurso:{
                required: "Digite um percurso a ser seguido"
            }
        }
    });
}


function validaFormularioPassageiros(){
   
    $("#cadastroPassageiros").validate({

        rules:{
            nome:{
                required: true,
                minlength: 6
            },
            
            rg:{
                required: true,
                maxlength: 20,
                number: true
            },
            rua:{
                required: true
            },
            email:{
                required: true,
                email: true
            }
            
        },

        messages:{
            nome:{
                required: "Campo obrigatório",
                minlength: "Tamanho inválido"
            },
            
            rg:{
                required: "Campo obrigatório",
                maxlength: "Número inválido",
                number: "Digite apenas números"
            },
            rua:{
                required: "Campo obrigatório"
            },
            email:{
                required: "Campo obrigatório",
                email: "Digite um e-mail válido"
            }
        }
    });
}

function verificaCamposNumericos(){
    
    
    
    
}


