//
//  Cadastro.swift
//  Vanttage-v2
//
//  Created by leo on 04/10/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class Cadastro: NSObject {
    var nome: String?
    var email: String?
    var senha: String?
    var dataNascimento: String?
    var cpf: String?
    var cidade: NSNumber?
    var cep: String?
    var numero: String?
    var endereco: String?
    var profissao: String?
    var numeroCartao: String?
    var imagem: UIImage?
    
    
    
    static func cadastroObjeto(tfs: [UITextField]) -> Dictionary<String, Any> {
        var params = Dictionary<String, Any>()
        var nome: String?
        var email: String!
        var senha: String!
        var dataNascimento: String!
        var cpf: String!
        var cidade: NSNumber!
        var cep: String!
        var numero: String!
        var endereco: String!
        var profissao: String!
        var numeroCartao: String!
        var imagem: UIImage!
        
        if let nome1 = tfs[0].text {
            nome = nome1
        }
        
        if let email1 = tfs[1].text {
            email = email1
        }
        
        if let senha1 = tfs[2].text {
            senha = senha1
        }
        
        if let data1 = tfs[4].text {
            dataNascimento = data1
        }
        
        if let cpf1 = tfs[5].text {
            cpf = cpf1
        }
        
        if let codeZip1 = tfs[7].text {
            cep = codeZip1
        }
        
        if let profissao1 = tfs[10].text {
            profissao = profissao1
        }
        
        if let cartao1 = tfs[11].text {
            numeroCartao = cartao1
        }
        
        
        
        
       params = ["name":nome!,"id": 0 ,"password":senha, "cardNumber":numeroCartao, "cpf":cpf, "email":email, "birth":dataNascimento, "profession":profissao, "status":1, "codeZip":cep, "pathPhoto":"password", "citiesId":1, "profilesId":1]
        
        return params
    }
    
    
}



