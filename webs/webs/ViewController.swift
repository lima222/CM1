//
//  ViewController.swift
//  webs
//
//  Created by DocAdmin on 5/11/18.
//  Copyright © 2018 ipvc.estg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func post(_ sender: Any) {
        var request = URLRequest(url: URL(string: "http://spaiva.000webhostapp.com/myslim/api/cidade")!)
        
        let cidade = "novacidade"
        let pais = "1"
        let json = ["descr": cidade, "pais_id": pais]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            print("err")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url!) { data, respnse, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            let msg = json["MSG"] as! String
            print(msg)
            
        }
        task.resume()
        
            
        
        
        
    }
    @IBAction func delete(_ sender: Any) {
        var request = URLRequest(url: URL(string: "http://spaiva.000webhostapp.com/myslim/api/cidade")!)
        
        let cidade = "novacidade"
        let pais = "1"
        let json = ["descr": cidade, "pais_id": pais]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            print("err")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url!) { data, respnse, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            let msg = json["MSG"] as! String
            print(msg)
            
        }
        task.resume()

    }
    @IBAction func array(_ sender: Any) {
        let url = URL(string: "http://spaiva.000webhostapp.com/myslim/api/cidade")
        
        let task = URLSession.shared.dataTask(with: url!) { data, respnse, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            
            print(json)
            
        }
        task.resume()
    }

    @IBAction func get(_ sender: Any) {
        
        let url = URL(string: "http://spaiva.000webhostapp.com/myslim/api/cidade/1")
        
        let task = URLSession.shared.dataTask(with: url!) { data, respnse, error in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            
            print(json)
            
            let status_id = json["status"] as! Bool
            let dados = json["Data"] as? [[String: String]]
            
            for i in 0 ..< dados!.count {
                let cidade: String = dados![i]["cidade"]
                print(cidade)
            }
            
        }
        task.resume()
    }

}

