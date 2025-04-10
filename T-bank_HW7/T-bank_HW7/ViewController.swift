//
//  ViewController.swift
//  T-bank_HW7
//
//  Created by Dmitrii Eselidze on 04.04.2025.
//

import UIKit

class LayoutViewController: UIViewController {
    
    private var brandLabel: UILabel?
    private var priceLabel: UILabel?
    private var titleLabel: UILabel?
    private var mainButton: UIButton?
    private var itemImage: UIImageView?
    private var itemIndex: Int = 0 // Индекс текущего товара
    private var currentItem: Item = Storage.itemList[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()


        }
    
    private func setupView() {
        view.backgroundColor = .black
        setupButton()
        setupItemCard(currentItem)
    }
    
    private func setupItemCard(_ item: Item) { // Отображение карточки товара
        setupImageView(item.imageName)
        setupBrandName(item.brandName)
        setupPrice(item.price)
        setupTitleLabel(item.itemName)

        setupConstraints()
    }
    
    private func setupButton() { // Кнопка переключения товара
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("Показать следующий товар", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitle("Показать следующий товар", for: .normal)
        view.addSubview(button)
        
        mainButton = button
    }

    @objc private func didTapButton() { // Нажатием увеличиваем индекс, удаляем старую и отрисовываем новую карточку
        nextIndex()
        brandLabel?.text = currentItem.brandName
        itemImage?.image = UIImage(named: currentItem.imageName)
        titleLabel?.text = currentItem.itemName
        priceLabel?.text = currentItem.price + " ₽"
//        print(itemIndex)
    }
    
    private func nextIndex() { // Меняет индекс для следующего товара
        let arrayLength = Storage.itemList.count
        
        if itemIndex < arrayLength - 1 {
            itemIndex += 1
        } else {
            itemIndex = 0
        }
        currentItem = Storage.itemList[itemIndex]
    }
    
    private func setupBrandName(_ brand: String) { // Название бренда
        let title = UILabel()
        title.font = .systemFont(ofSize: 17, weight: .bold)
        title.textColor = .gray
        title.textAlignment = .center
        title.numberOfLines = 1
        title.text = brand
        view.addSubview(title)
        
        brandLabel = title
    }
    
    private func setupPrice(_ price: String) { // Цена
        let title = UILabel()
        title.font = .systemFont(ofSize: 25, weight: .bold)
        title.textColor = .white
        title.textAlignment = .center
        title.numberOfLines = 1
        title.text = price + " ₽"
        view.addSubview(title)
        
        priceLabel = title
    }
    
    private func setupTitleLabel(_ label: String) { // Описание товара
        let title = UILabel()
        title.font = .systemFont(ofSize: 20)
        title.textColor = .white
        title.textAlignment = .center
        title.numberOfLines = 1
        title.text = label
        
        view.addSubview(title)
        
        titleLabel = title
    }
    
    private func setupImageView(_ imageName: String) { // Картинка
        let imageName = imageName
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        view.addSubview(imageView)
        itemImage = imageView
    }
    
    private func setupConstraints() {
        guard let brandLabel,
              let mainButton,
              let itemImage,
              let priceLabel,
              let titleLabel else { return }
        
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            itemImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            itemImage.heightAnchor.constraint(equalTo: itemImage.widthAnchor, multiplier: 0.8),
            
            brandLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 16),
            brandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            titleLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            mainButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.96),
            mainButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

