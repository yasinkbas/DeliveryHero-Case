//
//  ViewController.swift
//  DeliveryHero-Case
//
//  Created by Yasin Akbas on 10.08.2022.
//

import UIKit
import NetworkManagerKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        MovieAPI().popular().onData { response in
            response.results.forEach {
                print("--> \($0.title)")
            }
        }.onError { error in
            print("--> error \(error.localizedDescription)")
        }
        .onResponse { response in
            print("--> response \(response)")
        }
        .start()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .red
    }

}

