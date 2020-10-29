//
//  DrawViewController.swift
//  Walk2Draw
//
//  Created by Singkorn Dhepyasuvan on 26/10/2563 BE.
//

import UIKit
import LogStore
import CoreLocation
import MapKit

class DrawViewController: UIViewController {

    private var locationProvider: LocationProvider?
    private var locations:[CLLocation] = []
    private var contentView: DrawView {
        view as! DrawView
    }
    
    override func loadView() {
        let contentView = DrawView(frame: .zero)
        
        contentView.startStopButton.addTarget(self, action: #selector(startStop(_:)), for: .touchUpInside)
        
        contentView.clearButton.addTarget(self, action: #selector(clear(_:)), for: .touchUpInside)
        
        contentView.shareButton.addTarget(self, action: #selector(share(_:)), for: .touchUpInside)
        
        view = contentView
    }
    
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
    
    @objc func clear(_ sender: UIButton) {
        locations.removeAll()
        contentView.addOverlay(with: locations)
    }
    
    @objc func share(_ sender: UIButton) {
        if locations.isEmpty {
            return
        }
        
        let options = MKMapSnapshotter.Options()
        options.region = contentView.mapView.region
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            
            guard let snapshot = snapshot else {
                return
            }
            
            let image = self.imageByAddingPath(with: self.locations, to: snapshot)
            
            let activity = UIActivityViewController(activityItems: [image, "#walk2draw"], applicationActivities: nil)
            
            self.present(activity, animated: true, completion: nil)
        }
    }
    
    func imageByAddingPath(with locations: [CLLocation], to snapshot: MKMapSnapshotter.Snapshot) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(snapshot.image.size, true, snapshot.image.scale)
        
        snapshot.image.draw(at: .zero)
        
        let bezierPath = UIBezierPath()
        guard let firstCoordinate = locations.first?.coordinate else {
            fatalError("locations array is empty")
        }
        
        let firstPoint = snapshot.point(for: firstCoordinate)
        bezierPath.move(to: firstPoint)
        
        for location in locations.dropFirst() {
            let point = snapshot.point(for: location.coordinate)
            bezierPath.addLine(to: point)
        }
        
        UIColor.red.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            fatalError("could not get image from context")
        }
        UIGraphicsEndImageContext()
        
        return image
    }

}
