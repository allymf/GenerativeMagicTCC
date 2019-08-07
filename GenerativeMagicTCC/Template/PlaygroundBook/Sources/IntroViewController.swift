//
//  IntroViewController.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 23/03/19.
//

import UIKit

@objc(Book_Sources_IntroViewController)
class IntroViewController: UIViewController {

    var ivMe: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let me = (self.view.subviews.filter {$0.restorationIdentifier == "ivMe"}).first as? UIImageView else { fatalError("Carai Burracha") }
        self.ivMe = me
        
        self.ivMe.layer.cornerRadius = self.ivMe.frame.width/2
        
        // Do any additional setup after loading the view.
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
