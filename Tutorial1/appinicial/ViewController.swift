//
//  ViewController.swift
//  appinicial
//
//  Created by DocAdmin on 4/18/18.
//  Copyright © 2018 ipvc.estg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet var label1: UILabel!
    
    
    //actions
    @IBAction func clickButton1(_ sender: Any) {
        label1.text = "Escreva na caixa de texto"
    }
    
    
    
    //lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txt1.delegate = self as UITextFieldDelegate
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        label1.text = txt1.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    


}
