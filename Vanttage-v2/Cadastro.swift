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
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    static func cadastroObjeto(tfs: [UITextField], cidadeID: Cidades, imagemRecebe: UIImage) -> Dictionary<String, Any> {
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
        
//        let image_data = UIImageJPEGRepresentation(imagemRecebe, 0.9)
//        let base64String = image_data?.base64EncodedString(options:NSData.Base64EncodingOptions(rawValue: 0))
//        
//        let x: String = base64String!
//        print(x)
//        let body = NSMutableData()
//        
//        let boundary = "Boundary-\(NSUUID().uuidString)"
//        let fname = "test.png"
//        let mimetype = "image/png"
//        
//        //define the data post parameter
//        
//        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
//        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
//        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
//        
//        
//        
//        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
//        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
//        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
//        body.append(image_data!)
//        body.append("\r\n".data(using: String.Encoding.utf8)!)
//        print(image_data!)
//        
//        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
//        print(body)
        cidade = cidadeID.id as NSNumber!
        
        
       params = ["name":nome!,"id": 0 ,"password":senha, "cardNumber":numeroCartao, "cpf":cpf, "email":email, "birth":dataNascimento, "profession":profissao, "status":0, "codeZip":cep, "pathPhoto": "vai", "citiesId":cidade, "profilesId":0]
        
        return params
    }
    
    
    static func verErro(nometf: String?, passwordtf: String?,completion: @escaping (_ error: Bool, _ prifileID: Int)-> Void) {
        var nome: String!
        var password: String!
        
        if let email = nometf {
            nome = email
        }
        
        if let senha = passwordtf {
            password = senha
        }
        let params: Dictionary<String, Any> = ["email": nome, "password": password]
        var request = URLRequest(url: URL(string: "http://testbed.tap4.com.br:3000/appLogin")!)
        request.httpMethod = "POST"
        
        do {
            let json = try JSONSerialization.data(withJSONObject: params, options: [])
            request.httpBody = json
        } catch let jsonError {
            print(jsonError)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
            }else {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
                    print(json)
                    let teste = json["authorized"] as! Bool
                    print(teste)
                    let authorized = json["authorized"] as! Bool
                    var tipoCartao = 1
                    if authorized == true {
//                        let user = json["user"] as! Dictionary<String, AnyObject>
//                        tipoCartao = user["profilesId"] as! Int
                    }
                    
                    completion(authorized, 1)
                    
                } catch let jsonError {
                    print(jsonError)
                }
            }
            
        }
        task.resume()
    }
    


}



