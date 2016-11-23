//
//  DAO.swift
//  Vanttage-v2
//
//  Created by leo on 22/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit
import CoreData

class DAO: NSObject {
    
    
    static func saveUser(user: [Any], card: [Any]) {
        let keysUser = ["birth", "citiesId", "codeZip", "cpf", "email", "id", "name", "pathPhoto", "profession"]
        let keysCard = ["dateValidation", "createdAt", "id", "numberCard", "profilesId", "userCardsId"]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        let newCard = NSEntityDescription.insertNewObject(forEntityName: "UserCard", into: context)
        
        for i in 0..<user.count {
            newUser.setValue(user[i], forKey: keysUser[i])
        }
        
        for j in 0..<card.count {
            newCard.setValue(card[j], forKey: keysCard[j])
        }
        
        
        do {
            
            try context.save()
            print("SALVOU")
            
        } catch {
            print("error quando foi salvar no core")
        }
    }
    
    
    
    static func separarPalavras(user: [String : Any]) {
        var palavrasUser = [Any]()
        var palavrasCard = [Any]()
        let cards = user["cards"] as! [[String : Any]]
        print(cards[0]["userCardsId"])
        if let birth = user["birth"] as? String {
            palavrasUser.append(birth)
        }
        if let citiesId = user["citiesId"] as? Int {
            palavrasUser.append(citiesId)
        }
        if let codeZip = user["codeZip"] as? String {
            palavrasUser.append(codeZip)
        }
        if let cpf = user["cpf"] as? String {
            palavrasUser.append(cpf)
        }
        if let email = user["email"] as? String {
            palavrasUser.append(email)
        }
        if let id = user["id"] as? Int {
            palavrasUser.append(id)
        }
        if let name = user["name"] as? String {
            palavrasUser.append(name)
        }
        if let pathPhoto = user["pathPhoto"] as? String {
            palavrasUser.append(pathPhoto)
        } else {
            palavrasUser.append("")
        }
        if let profession = user["profession"] as? String {
            palavrasUser.append(profession)
        }
        
        if let dateValidation = cards[0]["dateValidation"] as? String {
            palavrasCard.append(dateValidation)
        } else {
            palavrasCard.append("")
        }
        
        if let createdAt = cards[0]["createdAt"] as? String {
            palavrasCard.append(createdAt)
        }
        if let id = cards[0]["id"] as? Int {
            palavrasCard.append(id)
        }
        if let numberCard = cards[0]["numberCard"] as? String {
            palavrasCard.append(numberCard)
        }
        if let profilesId = cards[0]["profilesId"] as? Int {
            palavrasCard.append(profilesId)
        }
        if let userCardsId = cards[0]["userCardsId"] as? Int {
            palavrasCard.append(userCardsId)
        }
        
        
        
        print(palavrasUser)
        DAO.saveUser(user: palavrasUser, card: palavrasCard)
    }
    
    
    
    
    static func excluir(entityName: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            let results = try context.execute(request)
            print(results)
            
        } catch {
            print("erro")
        }
        
    }
    static func userSalvos(str: String, entityName: String) -> String{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var retorno = String()
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            print(results)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let aceitar = result.value(forKey: str) as? String {
                        retorno = aceitar
                    }
                }
            }
        } catch {
            print("erro")
        }
        return retorno
    }
    
}
