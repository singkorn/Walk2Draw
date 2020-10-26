//
//  DrawViewController.swift
//  Walk2Draw
//
//  Created by Singkorn Dhepyasuvan on 26/10/2563 BE.
//

import UIKit

class DrawViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    
    override func loadView() {
        let contentView = DrawView(frame: .zero)
        
        view = contentView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
