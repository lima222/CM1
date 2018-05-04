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
    
    
    @IBOutlet var lista: UILabel!
    @IBOutlet var labelPais: UITextField!
    @IBOutlet var labelCC: UITextField!
    @IBOutlet var labelCP: UITextField!
    @IBOutlet var labelU: UITextField!
    @IBOutlet var labelUN: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        delegate = UIApplication.shared.delegate as? AppDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPais(_ sender: Any) {
        Pais.insert(nome: labelPais.text!, appDel: delegate!)
    }

    @IBAction func addCidade(_ sender: Any) {
        Cidade.insert(nome: labelCC.text!, nomePais: labelCP.text!, populacao: 123, appDel: delegate!)
    }
    
    @IBAction func allPais(_ sender: Any) {
        var result: String! = ""
        if let arr = Pais.getAll(appDel: delegate!) {
            for p: Pais in arr {
                result = result + "," + p.nome!
                Pais.delete(nome: p.nome!, appDel: delegate!)
            }
        }
        lista.text = result
    }
    
    @IBAction func allCidade(_ sender: Any) {
        var result: String! = ""
        if let arr = Cidade.getAll(appDel: delegate!) {
            for c: Cidade in arr {
                result = result + "," + c.nome!
                Cidade.delete(nome: c.nome!, appDel: delegate!)
                if let p: Pais = c.temPais {
                    result = result + "(" + p.nome! + ")"
                }
            }
        }
        lista.text = result
    }
    
    @IBAction func updatePais(_ sender: Any) {
        Pais.update(nomeAntigo: labelU.text!, nomeNovo: labelUN.text!, appDel: delegate!)
    }
}

