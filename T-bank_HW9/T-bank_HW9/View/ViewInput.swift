//
//  ViewInput.swift
//  T-bank_HW9
//
//  Created by Dmitrii Eselidze on 07.05.2025.
//

import Foundation

protocol ViewInput: AnyObject {
    func showDownloadedImages(_ images: [Data])
    func setDownloadButton(enabled: Bool)
    func showLoading()
    func hideLoading()
}
