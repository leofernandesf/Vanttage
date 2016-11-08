//
//  HomeTableViewCell.swift
//  Vanttage
//
//  Created by leo on 27/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var starimage: UIImageView!
    @IBOutlet weak var backGround: UIView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var lbFone: UILabel!
    @IBOutlet weak var lbEndereco: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    //var mostrar: MostrarMapa?
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var btLayout: UIButton!
    let latitude3 = -3.135774 as Double
    let longitude3 = -60.021162 as Double
    let defaults = UserDefaults.standard
    @IBOutlet weak var lbDescontMaximo: UILabel!
    @IBOutlet weak var lbDescontMinimo: UILabel!
    @IBOutlet weak var lbPoint: UILabel!
    @IBOutlet weak var pointImage: UIImageView!
    
    
    var companie: Companies? {
        didSet {
            self.nome.text = companie?.nome
            self.lbFone.text = companie?.phone
            self.lbEndereco.text = companie?.addres
            
            let x = defaults.object(forKey: "tipoCartao") as! Int
            if x == 1 {
                if let valor = companie?.multiplyGold {
                    self.lbPoint.text = "x\(valor)"
                }
            } else {
                if let valor = companie?.multiplyExclusive {
                    self.lbPoint.text = "x\(valor)"
                }
            }
            let tipoCartao = defaults.object(forKey: "tipoCartao")
            print(tipoCartao)
            setUpImageThumbNail()
            setUpImageProfile()
            setUpPromocoes()

        }
    }
    
    func setUpPromocoes() {
//        if let id = companie?.id {
//            var request = URLRequest(url: URL(string: "http://vanttage.com.br:3000/api/Companies/\(id)/promotions")!)
//            request.httpMethod = "GET"
////            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                    print("error=\(error)")
//                    return
//                }
//                
//                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                    print("response = \(response)")
//                    
//                }else {
//                    
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                        let dic:[[String:AnyObject]] = json as! [[String : AnyObject]]
//                        
//                        if let
//                        
//                    } catch let jsonError {
//                        print(jsonError)
//                    }
//                }
//            }
//            task.resume()
//        }
    }
    func setUpImageProfile()  {
        if let image = companie?.thumbnail {
            
            //imageProfile.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/companies/\(image)")
            imageProfile.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/companies/\(image)", completion: { (resposta) in
                DispatchQueue.main.async {
                    self.myLayout.imageLayout(image: self.imageProfile, recognizer: nil)
                }
                
                print(resposta)
            })
            
        }
    }
    
    func setUpImageThumbNail() {
        if let image = companie?.banner1 {
            //thumbImage.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/companies/\(image)")
            DispatchQueue.main.async {
                
                self.thumbImage.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/\(image)", completion: { (resposta) in
                    print(resposta)
                })
                print("olha aqui")
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rectShape = CAShapeLayer()
        rectShape.frame = self.thumbImage.bounds
        rectShape.path = UIBezierPath(roundedRect: self.thumbImage.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //self.thumbImage.layer.backgroundColor = UIColor.greenColor().CGColor
        self.thumbImage.layer.mask = rectShape
        print(thumbImage.frame.width)
        
    }
    
    
    let myLayout = layout()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGround.layer.masksToBounds = true
        backGround.clipsToBounds = true
        backGround.layer.cornerRadius = 5
        backGround.layer.shadowOffset = CGSize.zero
        backGround.layer.shadowColor = UIColor.black.cgColor
        backGround.layer.shadowRadius = 5.0
        backGround.layer.shadowOpacity = 0.3
        backGround.layer.masksToBounds = false
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func click(_ sender: AnyObject) {
        //mostrar?.mostrar(lat: latitude3, long: longitude3)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.btLayout.backgroundColor = UIColor.clear
//    }
    
}

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingURL(urlString: String, completion: @escaping (_ result: UIImage) -> Void)  {
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            self.image = imageFromCache
            let myLayout = layout()
            completion(self.image!)
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                self.image = imageToCache
                //print(self.image)
                completion(self.image!)
            }
        }).resume()
        
    }
}
