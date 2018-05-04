//
//  ViewController.swift
//  webservices
//
//  Created by DocAdmin on 5/4/18.
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


    @IBAction func get(_ sender: Any) {
        let urlString = "https://jsonplaceholder.typicode.com/posts/1"
        /*guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(EntityReturnBook.self, from: data)
                print("data:")
                let jjsonBodyString = String(data: data, encoding: .utf8)
                print("JSON String: ", jjsonBodyString)
                DispatchQueue.main.async {
                    //add
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()*/
        
        /*let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        
                        //Implement your logic
                        print(json)
                    }
                    
                } catch {
                    print("error in JSONSerialization")
                }
                
                
            }
            
        })
        task.resume()*/
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        let postString = "userId=1&title=123&body=limaamanha"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
}

