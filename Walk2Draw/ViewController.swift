//
//  ViewController.swift
//  Walk2Draw
//
//  Created by Singkorn Dhepyasuvan on 25/10/2563 BE.
//

import UIKit

class ViewController: UIViewController {

    var locationProvider: LocationProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        locationProvider = LocationProvider()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationProvider?.start()
    }

}

