//
//  Helper.swift
//  Vanttage-v2
//
//  Created by leo on 22/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class Helper {
    

    static func POST(urlString: String, postString: [String : Any],completion: @escaping (_ result: Dictionary<String, AnyObject>)-> Void) {
        
        print(postString)
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = postString.data(using: String.Encoding.utf8)
        do {
            let json = try JSONSerialization.data(withJSONObject: postString, options: [])
            request.httpBody = json
        } catch let jsonError {
            print(jsonError)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
            } else {
//                let responseString = String(data: data, encoding: .utf8)
//                print(responseString!)
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
                    
                    //                    let success = json["success"] as! Int
                    //                    var userData = Dictionary<String, AnyObject>()
                    //                    if success == 1 {
                    //                        userData = json["data"] as! Dictionary<String, AnyObject>
                    //                        //print(userData)
                    //                    }
                    
                    completion(json)
                    
                } catch let jsonError {
                    print(jsonError)
                }
            }
            
            
            
            //            let responseString = String(data: data, encoding: .utf8)
            //
            //            print("responseString = \(responseString)")
            //            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
            //                print("statusCode should be 200, but is \(httpStatus.statusCode)")
            //                print("response = \(response)")
            //
            //            }else {
            //                print(response)
            //                print(data)
            //                do {
            //                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, AnyObject>
            //                    print(json)
            //
            //
            //                } catch let jsonError {
            //                    print(jsonError)
            //                }
            //            }
            
        }
        task.resume()
    }
    
    
    static func GET(urlString: String,completion: @escaping (_ result: Dictionary<String, AnyObject> )-> Void) {
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
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
                    //                    let x = json["data"] as! [[String: Any]]
                    //                    for y in x {
                    //                        if let query = y["query"] as? Int {
                    //                            if query == 1 {
                    //                                chamadas.append(y)
                    //                            } else {
                    //                                consultas.append(y)
                    //                            }
                    //                        }
                    //                    }
                    //                    print(consultas.count)
                    //                    print(chamadas.count)
                    completion(json)
                    
                    
                    
                    
                    
                } catch let jsonError {
                    print(jsonError)
                }
            }
            
        }
        task.resume()
        
    }
}
