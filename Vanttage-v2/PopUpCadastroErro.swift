//
//  PopUpViewController.swift
//  Vanttage
//
//  Created by leo on 23/09/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class PopUpCadastroErro: UIViewController {
    
    let myLayout = layout()
    
    @IBOutlet weak var lbPrimeiraMensagem: UITextView!
    @IBOutlet weak var lbSegundaMensagem: UITextView!
    @IBOutlet weak var popUpview: UIView!
    @IBOutlet weak var btBack: UIButton!
    var tipoErro : Int?
    var primeiraMensagem = "nada"
    var segundaMensagem = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("foi")
        
        showMensage()
        
        self.view.showAnimation(view: self.view)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.popUpview.layer.cornerRadius = 5
        myLayout.buttonLayout(objeto: [btBack], color: UIColor.white, borderWidth: 1,corner: 0.1)
    }
    
    func showMensage() {
        if tipoErro == 1 {
            primeiraMensagem = "Codigo do cartao esta incorreto ou esta invalido"
            segundaMensagem = "Verifique os numeros ou tenta mais tarde"
        } else if tipoErro == 2 {
            primeiraMensagem = "Preencha todos os campos em laranja para finalizar o cadastro"
            segundaMensagem = "Por favor verifique se todos os campos foram preenchidos corretamente"
        } else if tipoErro == 3{
            primeiraMensagem = "CPF ja cadastrado"
            segundaMensagem = "Por favor verifique se todos os campos foram preenchidos corretamente"
        } else if tipoErro == 4 {
            primeiraMensagem = "Email ja cadastrado"
            segundaMensagem = "Por favor verifique se todos os campos foram preenchidos corretamente"
        } else {
            primeiraMensagem = "Senhas diferentes"
            segundaMensagem = "Por favor digite novamente as senhas"
        }
        
        self.lbPrimeiraMensagem.text = primeiraMensagem
        self.lbSegundaMensagem.text = segundaMensagem
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func voltar(_ sender: AnyObject) {
        self.view.removeAnimate(view: self.view)
//        self.willMove(toParentViewController: nil)
//        self.view.removeFromSuperview()
//        self.removeFromParentViewController()
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
