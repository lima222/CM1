//
//  VCDetalhe.swift
//  tabelas
//
//  Created by DocAdmin on 4/27/18.
//  Copyright © 2018 ipvc.estg. All rights reserved.
//

import UIKit

class VCDetalhe: UIViewController {
    
    var cidade: String = ""
    
    
    @IBOutlet weak var txtCidade: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
        print(cidade)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(txtCidade.text == "" ) {
            print("Nome tem de ser preenchido")
            return false
        }
        return true
    }
}
