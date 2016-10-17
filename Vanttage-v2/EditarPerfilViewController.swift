//
//  EditarPerfilViewController.swift
//  Vanttage
//
//  Created by leo on 28/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class EditarPerfilViewController: UIViewController {
    
    @IBOutlet weak var btBack: UIButton!
    var verificador = false
    var cont = 0
    let recognizer = UITapGestureRecognizer()
    var informacoes:Cadastro?
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var ivImage: UIImageView!
    let mylayout = layout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.acaoMenu(botao: btBack, vc: self)
        mylayout.imageLayout(image: ivImage, recognizer: recognizer)
        recognizer.addTarget(self, action: #selector(EditarPerfilViewController.profileImage))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("teste")
        
    }
    @IBAction func foto(_ sender: AnyObject) {
        profileImage()
    }
    
    
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
    
}

extension EditarPerfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        print("foto antes ",ivImage.image)
        ivImage.image = chosenImage
        print("foto depois ",ivImage.image)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//extension EditarPerfilViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = UITableViewCell()
//        
//        
//        if indexPath.row < 8 {
//            let customCell: cell1TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! cell1TableViewCell
////            customCell.ivImage.image = UIImage(named: images[indexPath.row])
////            customCell.tfText.placeholder = stringstf[indexPath.row]
//            if indexPath.row == 1 {
//                customCell.tfText.isSecureTextEntry = true
//            }
//            customCell.index = indexPath.row
//            //customCell.informacao = self.informacoes
//            if verificador {
//                customCell.tfText.text = ""
//            }
//            cell = customCell
//        } else if indexPath.row == 8 {
//            let customCell: cell2TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! cell2TableViewCell
////            customCell.ivImage.image = UIImage(named: images[indexPath.row])
////            customCell.tfCartao.placeholder = stringstf[indexPath.row]
//            if verificador {
//                customCell.tfCartao.text = ""
//            }
//            
//            cell = customCell
//        } else {
//            let customCell: cell3TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! cell3TableViewCell
//            customCell.atualizar = self
//            cell = customCell
//        }
//        cont += 1
//        if cont == 10 {
//            verificador = false
//        }
//        return cell
//    }
//    
//}
//
//extension EditarPerfilViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 8 {
//            return 	143
//        } else if indexPath.row == 9 {
//            return 175
//        } else {
//            return 84
//        }
//    }
//}
//
//
//extension EditarPerfilViewController: Atualizar {
//    func limparTable() {
//        verificador = true
//        cont = 0
//        self.myTable.reloadData()
//        self.ivImage.image = UIImage(named: "profile_photo")
//    }
//    func mostrar() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "popUpCadastroErro") as! PopUpCadastroErro
//        self.addChildViewController(controller)
//        controller.view.frame = self.view.frame
//        self.view.addSubview(controller.view)
//        controller.didMove(toParentViewController: self)
//    }
//}
