//  Presenter.swift

import Foundation

final class Presenter {
    private weak var view: ViewInput?
    private let networkClient: NetworkClient

    private let images: [String] = [
        "https://i.pinimg.com/736x/1f/7d/41/1f7d41627a6b4fe7900a0ac14ae06c10.jpg",
        "https://i.pinimg.com/736x/8b/af/23/8baf2349c851bb62cbff216972332747.jpg",
        "https://ih1.redbubble.net/image.5676644126.3923/raf,360x360,075,t,fafafa:ca443f4786.jpg"
    ]

    init(view: ViewInput, networkClient: NetworkClient) {
        self.view = view
        self.networkClient = networkClient
    }

    func downloadImages() {
        view?.setDownloadButton(enabled: false)
        view?.showLoading()

        var completed = 0
        for url in images {
            networkClient.downloadImage(url) { [weak self] in
                guard let self = self else { return }
                completed += 1
                if completed == self.images.count {
                    DispatchQueue.main.async {
                        self.view?.setDownloadButton(enabled: true)
                        self.view?.hideLoading()
                        self.view?.showDownloadedImages(self.networkClient.downloadedImages)
                        self.networkClient.clearDownloadedImages()
                    }
                }
            }
        }
    }
}
