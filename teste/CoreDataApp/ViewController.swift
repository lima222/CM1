//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Hugo Pereira on 21/04/18.
//  Copyright © 2018 Hugo Pereira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var delegate:AppDelegate?
    
    var cidades: [Cidade] = []
    
    var paises: [Pais] = []
    
    @IBOutlet weak var CidadeEliminar: UITextField!
    
    @IBAction func EliminarCidade(_ sender: UIButton) {
        Cidade.delete(nome: CidadeEliminar.text!, appDel: delegate!)
    }
    
    
    @IBOutlet weak var NomeNovoPais: UITextField!
    
    @IBAction func CriarPais(_ sender: UIButton) {
        Pais.insert(nome: NomeNovoPais.text!, appDel: delegate!)
    }
    @IBOutlet weak var TodosPaises: UILabel!
    
    @IBOutlet weak var TodasCidades: UILabel!
    
    @IBOutlet weak var NomeNovaCidade: UITextField!
    
    @IBOutlet weak var PaisNovaCidade: UITextField!
    
    @IBAction func CriarCidade(_ sender: UIButton) {
        Cidade.insert(nome: NomeNovaCidade.text!, nomePais: PaisNovaCidade.text!, populacao: 123, appDel: delegate!)
    }
    
    @IBAction func GetAllCidades(_ sender: UIButton) {
        cidades = Cidade.getAll(appDel: delegate!)!
        
        TodasCidades.text = ""
        
        for i in cidades {
            TodasCidades.text = TodasCidades.text! + i.nome! + ", "
        }
    }
    
    @IBAction func GetAllPaises(_ sender: UIButton) {
        paises = Pais.getAll(appDel: delegate!)!
        
        TodosPaises.text = ""
        
        for i in paises {
            TodosPaises.text = TodosPaises.text! + i.nome! + ", "
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        delegate = UIApplication.shared.delegate as? AppDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var nomeAntigoCidade: UITextField!
    
    @IBOutlet weak var nomeNovoCidade: UITextField!
    
    @IBAction func atualizarCidade(_ sender: UIButton) {
        Cidade.update(nomeAntigo: nomeAntigoCidade.text!, nomeNovo: nomeNovoCidade.text!, appDel: delegate!)
    }
    
}

