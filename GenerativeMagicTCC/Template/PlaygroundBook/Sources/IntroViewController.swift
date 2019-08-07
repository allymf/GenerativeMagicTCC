//
//  IntroViewController.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 23/03/19.
//

import UIKit

@objc(Book_Sources_IntroViewController)
public class IntroViewController: UIViewController {
    
    var ivMe: UIImageView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.ivMe = UIImageView(image: UIImage(named: "me"))
        self.ivMe.layer.cornerRadius = self.ivMe.frame.width/2
        
        self.view.addSubview(ivMe)
        
        NSLayoutConstraint.activate([
            self.ivMe.widthAnchor.constraint(equalToConstant: 200),
            self.ivMe.heightAnchor.constraint(equalToConstant: 200),
            self.ivMe.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.ivMe.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            ])
        
    }
    
}
