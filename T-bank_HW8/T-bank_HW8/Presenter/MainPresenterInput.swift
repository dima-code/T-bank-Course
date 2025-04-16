//
//  MainPresenterInput.swift
//  T-bank_HW8
//
//  Created by Dmitrii Eselidze on 15.04.2025.
//

protocol MainPresenterInput: AnyObject {
    var itemsCount: Int { get }
    func viewDidLoad()
    func item(at index: Int) -> Item
}
