//
//  ViewController.swift
//  simitExampleApp
//
//  Created by Batuhan iOS Foreks on 17.01.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let Url = String(format: "https://cat-fact.herokuapp.com/facts")
            guard let serviceUrl = URL(string: Url) else { return }
//            let parameters: [String: Any] = nil
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "GET"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: [], options: []) else {
                return
            }
//            request.httpBody = httpBody
            request.timeoutInterval = 20
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
//                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
//                        print(json)
                    } catch {
//                        print(error)
                    }
                }
            }.resume()
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let photoURL = URL(string: "https://jxccsa.bn1.livefilestore.com/y2m5XyfjXFW78kXvn3-McCXl5926JSzKH-n7hysppnCZxn_hnMPjwWA2dT11K_pInOZYJArvCzlh0_Aozw2ZK_4sBMspJx23DN1kNX8IfRW4_cBuasM9pEUvOTup6p9KCCm/AE1.jpg?psid=1")!
//
//        URLSession.shared.dataTask(with: photoURL) { data, response, error in
//            print(response)
//        }.resume()
    }
    }




