//
//  CriarContaViewController.swift
//  Vanttage
//
//  Created by leo on 21/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit
import Foundation

protocol Atualizar {
    func limparTable()
    func mostrar()
    
}

struct Cidades {
    var nome : String!
    var stateID: Int!
    var id: Int!
}

class CriarContaViewController: UIViewController {
    
    @IBOutlet weak var btBack: UIButton!
    @IBOutlet weak var ivPerfil: UIImageView!
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    @IBOutlet weak var tfConfirmarSenha: UITextField!
    @IBOutlet weak var tfData: UITextField!
    @IBOutlet weak var tfCPF: UITextField!
    @IBOutlet weak var tfCidade: UITextField!
    @IBOutlet weak var tfCEP: UITextField!
    @IBOutlet weak var tfNumero: UITextField!
    @IBOutlet weak var tfEndereco: UITextField!
    @IBOutlet weak var tfProfissao: UITextField!
    @IBOutlet weak var tfCartao: UITextField!
    @IBOutlet weak var btLimparCampos: UIButton!
    @IBOutlet weak var btConfirmar: UIButton!
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var visulaEfect: UIVisualEffectView!
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var cadastroFace: UIButton!
    
    var mytfs = [UITextField]()
    var faceManager: FBSDKLoginManager?
    var informacoes:Cadastro?
    let recognizer = UITapGestureRecognizer()
    let mylayout = layout()
    var pickOption: [String] = []
    let pickerView = UIPickerView()
    var cidades: [Cidades] = []
    var row: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.visulaEfect.isHidden = false
        self.load.startAnimating()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setarValores()
        
        mytfs = [tfNome,tfEmail,tfSenha,tfConfirmarSenha,tfData,tfCPF,tfCidade,tfCEP,tfNumero,tfEndereco,tfProfissao,tfCartao]
        pickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("entrou no will")
        
        if (navigationController?.viewControllers[0].isKind(of: LoginViewController.self))! {
            print("login")
            self.cadastroFace.isHidden = false
            btBack.addTarget(self, action: #selector(CriarContaViewController.back), for: .touchUpInside)
            if let _ = FBSDKAccessToken.current() {
                self.visulaEfect.isHidden = false
                self.load.startAnimating()
                self.graphRequest()
            }
        } else {
            layout.acaoMenu(botao: btBack, vc: self)
            print("de outro lugar")
            self.cadastroFace.isHidden = true
        }
        
    }
    
    func setarValores() {
        faceManager = FBSDKLoginManager()
        recognizer.addTarget(self, action: #selector(CriarContaViewController.profileImage))
        mylayout.imageLayout(image: ivPerfil, recognizer: recognizer)
        mylayout.buttonLayout(objeto: [btLimparCampos, btConfirmar], color: UIColor.white.laranja, borderWidth: 1.2,corner: 0.1)
        self.hideKeyboardWhenTappedAround()
        let image = layout.sizeImage(width: 24, height: 24, image: #imageLiteral(resourceName: "back_ic"))
        btBack.setImage(image, for: .normal)
        
        
        pickerView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        tfCidade.inputView = pickerView
        let date: UIDatePicker = UIDatePicker()
        date.datePickerMode = .date
        date.addTarget(self, action: #selector(CriarContaViewController.onDidChangeDate(sender:)), for: .valueChanged)
        tfData.inputView = date
        get()
        self.myScroll.delegate = self
    }
    
     func back() {
        print("apertou")
        faceManager?.logOut()
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    func onDidChangeDate(sender: UIDatePicker) {
        print("entrou")
        let myDateFormater: DateFormatter = DateFormatter()
        myDateFormater.dateFormat = "yyyy-MM-dd"
        
        let myString: String = myDateFormater.string(from: sender.date)
        tfData.text = myString as String
    }
    
    
    @IBAction func cadastrarFace(_ sender: AnyObject) {
        
        self.visulaEfect.isHidden = false
        self.load.startAnimating()
        faceManager?.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in
            if (error != nil) {
                print("Erro em logar",error)
                self.visulaEfect.isHidden = true
            } else if (result?.isCancelled)! {
                print("CANCELADO")
                self.visulaEfect.isHidden = true
            } else {
                print("logado")
                self.graphRequest()
            }
        }
    }
    
    func post() {
        
        let params = Cadastro.cadastroObjeto(tfs: mytfs, cidadeID: cidades[row], imagemRecebe: self.ivPerfil.image!)
//        let url = "http://testbed.tap4.com.br:3000/api/UserCards"
//        print(params)
//        
//        Helper.POST(urlString: url, postString: params) { (result) in
//            print(result)
//        }
        var request = URLRequest(url: URL(string: "http://testbed.tap4.com.br:3000/api/UserCards/save")!)
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
                var tipoError = Int()
                let responseString = String(data: data, encoding: .utf8)
                if (responseString?.contains("cpf_UNIQUE"))! {
                    tipoError = 3
                } else if (responseString?.contains("email_UNIQUE"))! {
                    tipoError = 4
                }
                
                DispatchQueue.main.async {
                    self.showPopUp(identifier: "popUpCadastroErro", tipo: tipoError)
                }
                print("responseString = \(responseString)")
            } else {
                DispatchQueue.main.async {
                    self.showPopUp(identifier: "popUpCadastroCerto", tipo: 0)
                }
                
            }
            

        }
        task.resume()
    }
    
    
    func get() {
        
        var request = URLRequest(url: URL(string: "http://testbed.tap4.com.br:3000/api/Cities")!)
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
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    for dic in json as! [[String: AnyObject]]{
                        let existe = dic["isVisibled"] as! Int
                        if existe == 1 {
                            let cidade = Cidades(nome: dic["name"] as! String?, stateID: dic["statesId"] as! Int, id: dic["id"] as! Int)
                            
                            self.cidades.append(cidade)
                        }
                    }
                    
                    print(self.cidades)
                    DispatchQueue.main.async {
                        self.tfCidade.text = self.cidades[0].nome
                        self.visulaEfect.isHidden = true
                        self.load.stopAnimating()
                    }
                    

                } catch let jsonError {
                    print(jsonError)
                }
            }
            
        }
        task.resume()
    }
    
    
    
    @IBAction func selecionarFoto(_ sender: AnyObject) {
        profileImage()
    }
    
    func AtualizarInformacoesFace() {
        if let imagem = self.informacoes?.imagem {
            ivPerfil.image = imagem
            
        }
        if let nome = self.informacoes?.nome {
            self.tfNome.text = nome
        }
        
        if let email = self.informacoes?.email {
            self.tfEmail.text = email
        }
    }
    
    @IBAction func limparCampos(_ sender: AnyObject) {
        
        self.limparDados()
    }
    
    @IBAction func confirmar(_ sender: AnyObject) {
        print(row)
        if self.tfSenha.text != self.tfConfirmarSenha.text {
            showPopUp(identifier: "popUpCadastroErro", tipo: 3)
        } else if textFieldVazias() {
            showPopUp(identifier: "popUpCadastroErro", tipo: 2)
        } else {
            post()
            //showPopUp(identifier: "popUpCadastroCerto", tipo: 2)
        }
        
        
        
    }
    
    func showPopUp(identifier: String, tipo : Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var controller = UIViewController()
        if identifier == "popUpCadastroErro" {
            let controller2 = storyboard.instantiateViewController(withIdentifier: identifier) as! PopUpCadastroErro
            controller2.tipoErro = tipo
            controller = controller2
        } else {
            let controller2 = storyboard.instantiateViewController(withIdentifier: identifier) as! PopUpOKViewController
            controller = controller2
        }
        
        self.addChildViewController(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    
    
    
    func textFieldVazias() -> Bool  {
        var verificador = false
        for tf in mytfs {
            if (tf.text?.isEmpty)! && (tf != tfCEP) && (tf != tfNumero)  && (tf != tfEndereco) && (tf != tfCartao){
                tf.attributedPlaceholder = NSAttributedString(string: tf.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.black.laranja])
                verificador = true
            }
        }
        return verificador
    }
    
    
    
    func limparDados() {
        self.ivPerfil.image = UIImage(named: "profile_photo")
        for tfs in mytfs {
            tfs.text = ""
        }
    }
    
    
    //MARK: - CAMERA
    func profileImage() {
        let alert: UIAlertController = UIAlertController(title: "Escolha um foto", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction =  UIAlertAction(title: "Camera", style: .default) { UIAlertAction in
            self.camera()
        }
        
        let gallaryAction =  UIAlertAction(title: "Galeria", style: .default) { UIAlertAction in
            self.galeria()
        }
        
        let cancelAction =  UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func galeria() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func camera() {
        let picker = UIImagePickerController()
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = true
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            galeria()
        }
        
    }
    
    // MARK: - Request Facebook
    func graphRequest() {
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start { (connection, result, error) in
            if error != nil {
                print(error!)
                return
            }
            
            self.informacoes = Cadastro()
            let data:[String:AnyObject] = result as! [String : AnyObject]
            print(data)
            if let email = data["email"] as? String {
                self.informacoes?.email = email
            }
            
            if data["picture"] != nil {
                let pic = data["picture"] as! NSDictionary
                let data = pic["data"] as! NSDictionary
                let url = data["url"] as! String
                
                if let url = NSURL(string: url), let data = NSData(contentsOf: url as URL), let downloadedImage = UIImage(data: data as Data) {
                    self.informacoes?.imagem = downloadedImage
                }
            }
            
            if let name = data["name"] as? String {
                self.informacoes?.nome = name
            }
            
            self.visulaEfect.isHidden = true
            self.AtualizarInformacoesFace()
            
        }
    }
    
}








//MARK: - Extensions

extension CriarContaViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1...2:
            print("do nothing")
        default:
            myScroll.setContentOffset(CGPoint(x: 0, y: self.myScroll.contentOffset.y + 100), animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            tfEmail.becomeFirstResponder()
        case 2:
            tfSenha.becomeFirstResponder()
        case 3:
            tfConfirmarSenha.becomeFirstResponder()
        case 4:
            tfData.becomeFirstResponder()
        case 5:
            tfCPF.becomeFirstResponder()
        case 6:
            tfCidade.becomeFirstResponder()
        case 8:
            tfNumero.becomeFirstResponder()
        case 9:
            tfEndereco.becomeFirstResponder()
        case 10:
            tfProfissao.becomeFirstResponder()
        case 11:
            tfCartao.becomeFirstResponder()
        case 12:
            textField.resignFirstResponder()
        default:
            print("nada")
        }
        return true
    }
    
}

extension CriarContaViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y >= -20 {
//            self.myScroll.isScrollEnabled = true
//        } else {
//            self.myScroll.isScrollEnabled = false
//        }
//    }
    
    
}

extension CriarContaViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.tfCidade.text = cidades[row].nome
        self.row = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cidades[row].nome
    }
}

extension CriarContaViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cidades.count
    }
}


extension CriarContaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        print("foto antes ",ivPerfil.image)
        ivPerfil.image = chosenImage
        print("foto depois ",ivPerfil.image)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}




