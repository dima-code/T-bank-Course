import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private lazy var presenter = Presenter(view: self)
    private var downloadingIndicator: UIActivityIndicatorView?
    
    var imagesStack = UIStackView()
    var downloadButton: UIButton?
    var imagesNumber: Int {
        presenter.images.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        activityIndicator()
        setupButton()
        setupImagesStack()
        setupConstraints()
    }
    
    private func activityIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        view.addSubview(indicator)
        downloadingIndicator = indicator
    }
    
    private func setupButton() {
        let button = UIButton()
        button.setTitle("Загрузить картинки", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        
        button.addTarget(self, action: #selector(buttonTouchDown), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel, .touchDragExit])
        
        button.addTarget(self, action: #selector(startDownloadingImages), for: .touchUpInside)
        view.addSubview(button)
        downloadButton = button
    }
    
    @objc private func buttonTouchDown() {
        UIView.animate(withDuration: 0.1) {
            self.downloadButton?.backgroundColor = .black.withAlphaComponent(0.7)
        }
    }
    
    @objc private func buttonTouchUp() {
        UIView.animate(withDuration: 0.1) {
            self.downloadButton?.backgroundColor = .black
        }
    }
    
    @objc func startDownloadingImages() {
        print("Download started")
        downloadingIndicator?.startAnimating()
        presenter.downoadImages()
    }
    
    private func setupImagesStack() {
        let images = UIStackView()
        images.distribution = .fillEqually
        images.axis = .vertical
        images.spacing = 5
        
        for _ in 0..<imagesNumber {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            images.addArrangedSubview(imageView)
        }
        
        view.addSubview(images)
        imagesStack = images
    }
    
    private func setupConstraints() {
        guard let downloadButton = downloadButton else { return }
        
        downloadingIndicator?.translatesAutoresizingMaskIntoConstraints = false
        imagesStack.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Activity Indicator
            downloadingIndicator?.centerYAnchor.constraint(equalTo: view.centerYAnchor) ?? .init(),
            downloadingIndicator?.centerXAnchor.constraint(equalTo: view.centerXAnchor) ?? .init(),
            
            // Download Button
            downloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 60),
            downloadButton.widthAnchor.constraint(equalToConstant: 300),
            
            // Images Stack
            imagesStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagesStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imagesStack.bottomAnchor.constraint(equalTo: downloadButton.topAnchor, constant: -40)
        ])
    }
    
    func stopActivityIndicator() {
        downloadingIndicator?.stopAnimating()
    }
    
    func updateImages(from imagesData: [Data]) {
            guard !imagesData.isEmpty else {
                print("Data storage is empty")
                return
            }
            
            for (index, imageData) in imagesData.enumerated() {
                guard index < imagesStack.arrangedSubviews.count,
                      let imageView = imagesStack.arrangedSubviews[index] as? UIImageView else {
                    continue
                }
                
                UIView.transition(with: imageView,
                                duration: 0.3,
                                options: .transitionCrossDissolve) {
                    imageView.image = UIImage(data: imageData)
                }
            }
        }
}
