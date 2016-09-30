//
//  CriarContaViewController.swift
//  Vanttage
//
//  Created by leo on 21/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

protocol Atualizar {
    func limparTable()
    func mostrar()
    
}

class CriarContaViewController: UIViewController {
    
    @IBOutlet weak var ivPerfil: UIImageView!
    
    @IBOutlet weak var table: UITableView!
    
    let recognizer = UITapGestureRecognizer()
    let stringstf:[String] = ["Nome Completo","Senha","Data de Nascimento","CPF","Cidade","UF","Profissao", "Numero do Cartao"]
    let images = ["name_ic","password_ic","calendar_ic","cpf_ic","map_ic","location_ic","job_ic","wallet_ic"]
    let mylayout = layout()
    var verificador = false
    var cont = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        recognizer.addTarget(self, action: #selector(CriarContaViewController.profileImage))
        mylayout.imageLayout(image: ivPerfil, recognizer: recognizer)
        self.table.tableFooterView = UIView(frame: CGRect.zero)
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: AnyObject) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selecionarFoto(_ sender: AnyObject) {
        profileImage()
    }
    
    
    
    //Mark: - CAMERA
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension CriarContaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        print("foto antes ",ivPerfil.image)
        ivPerfil.image = chosenImage
        print("foto depois ",ivPerfil.image)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension CriarContaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row < 7 {
            let customCell: cell1TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! cell1TableViewCell
            customCell.ivImage.image = UIImage(named: images[indexPath.row])
            customCell.tfText.placeholder = stringstf[indexPath.row]
            if indexPath.row == 1 {
                customCell.tfText.isSecureTextEntry = true
            }
            if verificador {
                customCell.tfText.text = ""
            }
            cell = customCell
        } else if indexPath.row == 7 {
            let customCell: cell2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! cell2TableViewCell
            customCell.ivImage.image = UIImage(named: images[indexPath.row])
            customCell.tfCartao.placeholder = stringstf[indexPath.row]
            if verificador {
                customCell.tfCartao.text = ""
            }
            
            cell = customCell
        } else {
            let customCell: cell3TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! cell3TableViewCell
            customCell.atualizar = self
            cell = customCell
        }
        cont += 1
        if cont == 9 {
            verificador = false
        }
        return cell
    }
    
}

extension CriarContaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 {
            return 	143
        } else if indexPath.row == 8 {
            return 175
        } else {
            return 84
        }
    }
}


extension CriarContaViewController: Atualizar {
    func limparTable() {
        verificador = true
        cont = 0
        self.table.reloadData()
    }
    func mostrar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "pop1")
        controller.willMove(toParentViewController: self)
        self.view.addSubview(controller.view)
        self.addChildViewController(controller)
        controller.didMove(toParentViewController: self)
    }
}



