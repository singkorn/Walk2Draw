//
//  DrawView.swift
//  Walk2Draw
//
//  Created by Singkorn Dhepyasuvan on 25/10/2563 BE.
//

import UIKit
import MapKit

class DrawView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    let mapView: MKMapView
    let clearButton: UIButton
    let startStopButton: UIButton
    let shareButton: UIButton
    
    override init(frame: CGRect) {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        
        clearButton = UIButton(type: .system)
        clearButton.setTitle("Clear", for: .normal)
        
        startStopButton = UIButton(type: .system)
        startStopButton.setTitle("Start", for: .normal)
        
        shareButton = UIButton(type: .system)
        shareButton.setTitle("Share", for: .normal)
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let buttonStackView = UIStackView(arrangedSubviews: [clearButton, startStopButton, shareButton])
        buttonStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [mapView, buttonStackView])
        stackView.axis = .vertical
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: topAnchor), stackView.leadingAnchor.constraint(equalTo: leadingAnchor), stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor), stackView.trailingAnchor.constraint(equalTo: trailingAnchor),])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
