//
//  ViewController.swift
//  T-bank_HW8
//
//  Created by Dmitrii Eselidze on 11.04.2025.
//

import UIKit

final class MainViewController: UIViewController {
    private let presenter: MainPresenterInput
    private var loadedImages = 0
    private var totalImages: Int {
        presenter.itemsCount
    }
    private var activityIndicator = UIActivityIndicatorView()
    
    private var loadedIndexPaths: Set<IndexPath> = []
    private var imageCache: [IndexPath: UIImage] = [:]
    
    private lazy var tableView: UITableView = { // Строим TableView
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var progressLabel: UILabel = { // Окно с прогрессом
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Ни одно изображение не загружено"
        return label
    }()
    
    
    init(presenter: MainPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        activityIndicator.startAnimating()
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setupView() { // Добавление всех View
        view.backgroundColor = .white
        view.addSubview(progressLabel)
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            progressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}


extension MainViewController: MainViewInput {
    
    func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor.systemBlue
        view.addSubview(activityIndicator)
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func loadImage(for item: Item, at indexPath: IndexPath) {
        guard let url = URL(string: item.image) else { return }
        
        if loadedIndexPaths.contains(indexPath) {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self, let data = data, error == nil,
                  let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self.loadedIndexPaths.insert(indexPath)
                self.loadedImages += 1  // Увеличиваем счетчик загруженных картинок
                self.updateImageLoadingProgress(loaded: self.loadedImages, total: self.totalImages)
                let resizedImage = self.resizeImage(image, targetSize: CGSize(width: 40, height: 40))
                self.imageCache[indexPath] = resizedImage
                
                if let visibleCell = self.tableView.cellForRow(at: indexPath) {
                    var updatedContent = visibleCell.defaultContentConfiguration()
                    updatedContent.text = item.title
                    updatedContent.image = resizedImage
                    
                    updatedContent.imageProperties.maximumSize = CGSize(width: 40, height: 40)
                    visibleCell.contentConfiguration = updatedContent
                }
            }
        }.resume()
    }
    
    func updateImageLoadingProgress(loaded: Int, total: Int) {
        progressLabel.text = "Загружено \(loaded) из \(total)"
    }
    
    func updateTable() {
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellId) else {
            return UITableViewCell()
        }
        
        let item = presenter.item(at: indexPath.row)
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        
        if let cachedImage = imageCache[indexPath] {
            content.image = cachedImage
        } else {
            content.image = UIImage(systemName: "photo")
            loadImage(for: item, at: indexPath)
        }
        
        content.text = item.title
        cell.contentConfiguration = content
        return cell
    }
}

extension MainViewController: UITableViewDelegate {}

extension MainViewController {
    private enum Constant {
        static let cellId = "cellId"
    }
}
