//
//  MainViewInput.swift
//  T-bank_HW8
//
//  Created by Dmitrii Eselidze on 15.04.2025.
//

import UIKit

protocol MainViewInput: AnyObject {
    func updateTable()
    func updateImageLoadingProgress(loaded: Int, total: Int)
    func stopActivityIndicator()
//    func indicatorAppear()
//    func indicatorDisappear()
    
}
