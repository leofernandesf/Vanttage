//
//  HomeTableViewCell.swift
//  Vanttage
//
//  Created by leo on 27/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbUmaPromocao: UILabel!
    
    @IBOutlet weak var maisPromocoes: UIImageView!
    @IBOutlet weak var umaPromocao: UIImageView!
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
            print(companie?.nome)
            self.nome.text = companie?.nome
            self.lbFone.text = companie?.phone
            self.lbEndereco.text = companie?.addres
            
            
            if let valor = companie?.multiply {
                if valor > 1 {
                    self.lbPoint.isHidden = false
                    self.pointImage.isHidden = false
                    self.starimage.isHidden = false
                    self.lbPoint.text = "x\(valor)"
                } else {
                    self.lbPoint.isHidden = true
                    self.pointImage.isHidden = true
                    self.starimage.isHidden = true
                }
                
            }
            
            
            if let imagens = companie?.comapniesImages {
                setUpImages(imagens: imagens)
            }
            
            if let promocoes = companie?.promotions {
                setUpPromocoes(promocoes: promocoes)
            }
            
            setUpImageThumbNail()
            setUpImageProfile()
//            setUpPromocoes()

        }
    }
    
    func setUpImages(imagens: [[String:Any]]) {
        //var cont = 0
        print(imagens.count)
        var images = [String]()
        for im in imagens {
            if let imageFile = im["img"] as? String {
                images.append(imageFile)
//                if cont == 0 {
//                    companie?.perfil = imageFile
//                } else if cont == 1 {
//                    companie?.logo = imageFile
//                } else if cont == 2 {
//                    companie?.banner1 = imageFile
//                } else if cont == 3 {
//                    companie?.banner2 = imageFile
//                } else if cont == 4 {
//                    companie?.banner3 = imageFile
//                } else if cont == 5 {
//                    companie?.banner4 = imageFile
//                }
               // cont += 1
            }
        }
        companie?.images = images
    }
    
    func setUpPromocoes(promocoes: [[String : Any]]) {
        print(promocoes.count)
        if promocoes.count == 1 {
            self.maisPromocoes.isHidden = true
            self.lbDescontMaximo.isHidden = true
            self.lbDescontMinimo.isHidden = true
            self.lbUmaPromocao.isHidden = false
            self.umaPromocao.isHidden = false
            
            
            if let valor = promocoes[0]["value"] {
                self.lbUmaPromocao.text = "\(valor)%"
            }
        } else {
            var maior = 0
            var menor = 0
            self.maisPromocoes.isHidden = false
            self.lbDescontMaximo.isHidden = false
            self.lbDescontMinimo.isHidden = false
            self.lbUmaPromocao.isHidden = true
            self.umaPromocao.isHidden = true
            
            if let valor = promocoes[0]["value"] as? String {
                maior = Int(valor)!
                menor = Int(valor)!
            }
            
            for promocao in promocoes {
                if let valor = promocao["value"] as? String {
                    let value = Int(valor)!
                    if value > maior {
                        maior = value
                    } else if value < menor {
                        menor = value
                    }
                }
            }
            
            self.lbDescontMinimo.text = "\(menor)%"
            self.lbDescontMaximo.text = "\(maior)%"
            print("mais de uma promocao")
        }
        
    }
    func setUpImageProfile()  {
        if let image = companie?.images?[0] {
            print(image)
            //imageProfile.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/companies/\(image)")
            imageProfile.loadImageUsingURL(urlString: "http://testbed.tap4.com.br:3000/\(image)", completion: { (resposta) in
                DispatchQueue.main.async {
                    self.myLayout.imageLayout(image: self.imageProfile, recognizer: nil)
                }
                
                print(resposta)
            })
            
        }
    }
    
    func setUpImageThumbNail() {
        
        if let image = companie?.images?[2] {
            //thumbImage.loadImageUsingURL(urlString: "http://vanttage.com.br:3000/companies/\(image)")
            DispatchQueue.main.async {
                
                self.thumbImage.loadImageUsingURL(urlString: "http://testbed.tap4.com.br:3000/\(image)", completion: { (resposta) in
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
