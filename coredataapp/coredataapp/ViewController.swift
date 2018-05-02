//
//  ViewController.swift
//  coredataapp
//
//  Created by DocAdmin on 5/2/18.
//  Copyright © 2018 ipvc.estg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var delegate:AppDelegate?
    
    @IBOutlet var paisUnew: UITextField!
    @IBOutlet var paisU: UITextField!
    @IBOutlet var labelAP: UITextField!
    @IBOutlet var labeladdcidadeC: UITextField!
    @IBOutlet var labeladdcidadeP: UITextField!
    @IBOutlet weak var labeladdpais: UITextField!
    @IBOutlet weak var label3: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = UIApplication.shared.delegate as? AppDelegate
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    @IBAction func allPaises(_ sender: Any) {
        var result: String! = ""
        if let arr = Pais.getAll(appDel: delegate!) {
            for p:Pais in arr {
                result = result + ";" + p.nome!
            }
        }
        label3.text = result
    }
    @IBAction func addPais(_ sender: Any) {
        Pais.insert(nome: labeladdpais.text!, appDel: delegate!)
    }
    @IBAction func addCidade(_ sender: Any) {
        Cidade.insert(nome: labeladdcidadeC.text!, nomePais: labeladdcidadeP.text!, populacao: 123, appDel: delegate!)
    }
    

    @IBAction func atualizarPais(_ sender: Any) {
         Pais.update(nomeAntigo: paisU.text!, nomeNovo: paisUnew.text!, appDel: delegate!)
    }
    
    @IBAction func allCidades(_ sender: Any) {
        var result: String! = ""
        if let arr = Cidade.getAll(appDel: delegate!) {
            for c:Cidade in arr {
                result = result + ";" + c.nome!
                if let p:Pais = c.temPais {
                    result = result + "(" + p.nome! + ")"
                }
            }
        }
        label3.text = result
    }
    @IBAction func apagarPais(_ sender: Any) {
        Pais.delete(nome: labelAP.text!, appDel: delegate!)
    }
}

