//
//  NetworkClient.swift
//  T-bank_HW9
//
//  Created by Dmitrii Eselidze on 23.04.2025.
//

import Foundation
import Alamofire


class NetworkClient {
    let queue = DispatchQueue(label: "download", attributes: .concurrent)
    let group = DispatchGroup()
    let lock = NSLock()
    
    var downloadedImages = [Data]()
    
    private lazy var view = ViewController()
    
    func clearDownloadedImages() {
        downloadedImages = []
    }
    
    func downloadImage(_ url: String) {
        guard let url = URL(string: url) else {
            print("Wrong URL")
            return
        }

        self.group.enter()
        queue.async {
            AF.request(url).responseData { response in
                self.group.leave()
                self.lock.lock()
                
                switch response.result {
                    
                case .success(let data):
                    print("Success download")
                    self.downloadedImages.append(data)
                    print(data)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
                self.lock.unlock()
            }
            
        }
    }
}
