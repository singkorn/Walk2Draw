//
//  DrawViewController.swift
//  Walk2Draw
//
//  Created by Singkorn Dhepyasuvan on 26/10/2563 BE.
//

import UIKit
import LogStore
import CoreLocation

class DrawViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    private var locationProvider: LocationProvider?
    private var locations:[CLLocation] = []
    private var contentView: DrawView {
        view as! DrawView
    }
    
    override func loadView() {
        let contentView = DrawView(frame: .zero)
        
        contentView.startStopButton.addTarget(self, action: #selector(startStop(_:)), for: .touchUpInside)
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationProvider = LocationProvider(updateHandler: {[weak self] location in
            
            guard let self = self else {
                return
            }
            printLog("location: \(location)")
            self.locations.append(location)
            
            self.contentView.addOverlay(with: self.locations)
        })
    }
    
    @objc func startStop(_ sender: UIButton) {
        guard let locationProvider = locationProvider else {
            fatalError()
        }
        
        if locationProvider.updating {
            locationProvider.stop()
            sender.setTitle("Start", for: .normal)
        } else {
            locationProvider.start()
            sender.setTitle("Stop", for: .normal)
        }
    }

}
