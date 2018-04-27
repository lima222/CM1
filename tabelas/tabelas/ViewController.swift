//
//  ViewController.swift
//  tabelas
//
//  Created by DocAdmin on 4/20/18.
//  Copyright © 2018 ipvc.estg. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var array = ["Lisboa", "Porto"]
    var arrayB = [false, false]
    var arrayEntites = [EntityCity]()
    
    //MARK: properties
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: actions
    
 
    @IBAction func butActionValidar(_ sender: Any) {
        verifyChosen()
    }
   
    
    //MARK: ciclovida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createArrayCities()
    }
    
    //MARK: UITABLEVIEWDATASOURCE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = array[indexPath.row]
        cell.detailTextLabel?.text = "info adicional"
        
        cell.accessoryType = UITableViewCellAccessoryType.detailDisclosureButton*/
        
       /* if arrayB[indexPath.row]{
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }else {
            cell.accessoryType = UITableViewCellAccessoryType.none
        }*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableView
        let ec: EntityCity = arrayEntites[indexPath.row]
        cell.othertituo.text = ec.name
        cell.labelSubTitulo.text = ec.country
        cell.labelInfo.text = String(ec.habitantes)
        cell.labelImag.image = UIImage(named: ec.imagem)
       
        return cell
    }
    
    
    
    //MARK: UITABLEVIEWDELEGATE
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editar = UITableViewRowAction(style: .default, title: "Editar"){action,index in
            self.performSegue(withIdentifier: "segue1", sender: indexPath)
        }
        editar.backgroundColor = UIColor.blue
        
        let apagar = UITableViewRowAction(style: .default, title: "Apagar"){action,index in
            
        }
        apagar.backgroundColor = UIColor.red
        
        return [editar, apagar]
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        /*let alert = UIAlertController(title: "Informaçao", message: array[indexPath.row], preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Fechar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)*/
        
        self.performSegue(withIdentifier: "segue1", sender: tableView)
        
        print(indexPath.row)
    }
    
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrayB[indexPath.row]{
            tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
            arrayB[indexPath.row] = false
        }else{
            tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
            arrayB[indexPath.row] = true
        }
        
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segue1", sender: tableView)
    }
    
    private func createArrayCities() {
        let c1: EntityCity = EntityCity()
        c1.name = "Viana"
        c1.country = "Portugal"
        c1.habitantes = 2000
        c1.imagem = "city"
        arrayEntites.append(c1)
        
        
        let c2: EntityCity = EntityCity()
        c2.name = "Porto"
        c2.country = "Portugal"
        c2.habitantes = 3000
        c2.imagem = "city"
        arrayEntites.append(c2)
    }
    
    
    func verifyChosen(){
        print("-----")
        for index in 0...arrayB.count-1{
            if arrayB[index]{
                print(array[index])
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unWindFromDetalheGravar(segue: UIStoryboardSegue) {
        let details = segue.source as! VCDetalhe
        let cidade: String = details.txtCidade.text!
        print(cidade)
        array.append(cidade)
        tableView.reloadData()
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "segue1") {
            let idx = sender as! IndexPath
            let vcdetalhe = (segue.destination as! VCDetalhe)
            vcdetalhe.cidade = array[idx.row]
        }
    }
    
    
}

