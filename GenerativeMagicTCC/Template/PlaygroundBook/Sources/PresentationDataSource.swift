//
//  PresentationDatasource.swift
//  Book_Sources
//
//  Created by Alysson Moreira on 23/03/19.
//

import UIKit

protocol PresentationDataSource {

    func size(for: UIPresentationController) -> CGRect
}
