//
//  HalfViewController.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 23/03/19.
//

import UIKit

class PresentationViewController: UIPresentationController {

    var dataSource: PresentationDataSource?
    
    override var frameOfPresentedViewInContainerView: CGRect {
        return (dataSource?.size(for: self))!
    }
    

}
