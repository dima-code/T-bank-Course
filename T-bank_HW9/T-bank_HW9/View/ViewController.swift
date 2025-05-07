//
//  ViewController.swift
//  T-bank_HW9
//
//  Created by Dmitrii Eselidze on 21.04.2025.
//
import UIKit

final class ViewController: UIViewController, ViewInput {
    private var presenter: Presenter!
    private var downloadingIndicator: UIActivityIndicatorView?
    
    var imagesStack = UIStackView()
    var downloadButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter = Presenter(view: self, networkClient: NetworkClient())
        
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
        
        button.addTarget(self, action: #selector(startDownloadingImages), for: .touchUpInside)
        view.addSubview(button)
        downloadButton = button
    }
    
    @objc func startDownloadingImages() {
        presenter.downloadImages()
    }
    
    private func setupImagesStack() {
        let images = UIStackView()
        images.distribution = .fillEqually
        images.axis = .vertical
        images.spacing = 5
        
        for _ in 0..<3 {
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
            downloadingIndicator!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadingIndicator!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            downloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 60),
            downloadButton.widthAnchor.constraint(equalToConstant: 300),
            imagesStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagesStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imagesStack.bottomAnchor.constraint(equalTo: downloadButton.topAnchor, constant: -40)
        ])
    }
    
    func setDownloadButton(enabled: Bool) {
        downloadButton?.isEnabled = enabled
    }

    func showLoading() {
        downloadingIndicator?.startAnimating()
    }

    func hideLoading() {
        downloadingIndicator?.stopAnimating()
    }

    func showDownloadedImages(_ imagesData: [Data]) {
        for (index, imageData) in imagesData.enumerated() {
            guard index < imagesStack.arrangedSubviews.count,
                  let imageView = imagesStack.arrangedSubviews[index] as? UIImageView else { continue }
            
            UIView.transition(with: imageView, duration: 0.3, options: .transitionCrossDissolve) {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
}
