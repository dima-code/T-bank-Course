//  NetworkClient.swift


import Foundation
import Alamofire

final class NetworkClient {
    private let queue = DispatchQueue(label: "download", attributes: .concurrent)
    private let lock = NSLock()
    
    var downloadedImages = [Data]()

    func clearDownloadedImages() {
        downloadedImages = []
    }

    func downloadImage(_ url: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: url) else {
            print("Wrong URL")
            completion?()
            return
        }

        AF.request(url).responseData { response in
            self.lock.lock()
            defer {
                self.lock.unlock()
                completion?()
            }

            switch response.result {
            case .success(let data):
                print("Success download")
                self.downloadedImages.append(data)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
