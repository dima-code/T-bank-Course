//
//  Presenter.swift
//  T-bank_HW9
//
//  Created by Dmitrii Eselidze on 23.04.2025.
//


import Foundation

class Presenter {
    weak var view: ViewController?

    private let networkClient = NetworkClient()
    
    let queue = DispatchQueue(label: "downloading")
    
    let group = DispatchGroup()
    let lock = NSLock()
    
    let images: [String] = [
        "https://i.pinimg.com/736x/1f/7d/41/1f7d41627a6b4fe7900a0ac14ae06c10.jpg",
        "https://i.pinimg.com/736x/8b/af/23/8baf2349c851bb62cbff216972332747.jpg",
        "https://ih1.redbubble.net/image.5676644126.3923/raf,360x360,075,t,fafafa:ca443f4786.jpg"
    ]
    
    
    init(view: ViewController? = nil) {
        self.view = view
    }
    
    func downoadImages() {
        
        view?.downloadButton?.isEnabled = false
        let imagesUrl = images
        
        for url in imagesUrl {
            networkClient.downloadImage(url)
        }
        
        networkClient.group.notify(queue: .main) {
            self.view?.downloadButton?.isEnabled = true
            print("Картинки загрузились")
            print(self.networkClient.downloadedImages)
            self.view?.stopActivityIndicator()
            self.view?.updateImages(from: self.networkClient.downloadedImages)
            self.networkClient.clearDownloadedImages()
        }
    }
}
