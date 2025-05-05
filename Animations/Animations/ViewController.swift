//
//  ViewController.swift
//  Animations
//
//  Created by Dmitrii Eselidze on 01.05.2025.
//

import UIKit

class ViewController: UIViewController {

    let pictureImageView = UIImageView(image: UIImage(named: "logo"))
    let titleLabel = UILabel()
    let animatedButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupAnimations()
    }

    private func setupButton() {

        animatedButton.setTitle("Click", for: .normal)
        animatedButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        animatedButton.backgroundColor = .systemBlue
        animatedButton.setTitleColor(.white, for: .normal)
        animatedButton.layer.cornerRadius = 12
        animatedButton.alpha = 0
        animatedButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5).rotated(by: -.pi / 4)
        animatedButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(animatedButton)
    }
    
    private func setupTitle() {
        titleLabel.text = "Hello!"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.alpha = 0
        view.addSubview(titleLabel)
    }
    
    private func setupLogo() {
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.alpha = 0
        pictureImageView.transform = CGAffineTransform(translationX: 0, y: -200)
        view.addSubview(pictureImageView)
    }
    
    private func setupScreen() {
        view.backgroundColor = .systemBackground
        setupButton()
        setupLogo()
        setupTitle()
    }
    
    private func setupConstraints() {
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        animatedButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            pictureImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pictureImageView.heightAnchor.constraint(equalToConstant: 200),
            pictureImageView.widthAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            animatedButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 65),
            animatedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animatedButton.widthAnchor.constraint(equalToConstant: 150),
            animatedButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupAnimations() {
        // Кнопка с bounce-эффектом (`transform`, `rotation`, `scale`)
        UIView.animate(withDuration: 0.6, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {
            self.animatedButton.alpha = 1
            self.animatedButton.transform = .identity
        }, completion: { _ in
            self.addShadow()
        })
        
        // fade-заголовок
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.curveEaseIn], animations: {
            self.titleLabel.alpha = 1
        })
        
        // Логотип выезжает сверху
        UIView.animate(withDuration: 0.6, delay: 0, options: [.curveEaseOut], animations: {
            self.pictureImageView.alpha = 1
            self.pictureImageView.transform = .identity
        })
    }


    private func addShadow() {
        // Добавление тени
        let shadow = CABasicAnimation(keyPath: "shadowOpacity")
        shadow.fromValue = 0
        shadow.toValue = 0.4
        shadow.duration = 0.5
        animatedButton.layer.shadowColor = UIColor.black.cgColor
        animatedButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        animatedButton.layer.shadowRadius = 6
        animatedButton.layer.add(shadow, forKey: "shadowFade")
        animatedButton.layer.shadowOpacity = 0.4
    }

    @objc private func buttonPressed() {
        // Изменение радиуса при нажатии
        let radiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        radiusAnimation.fromValue = animatedButton.layer.cornerRadius
        radiusAnimation.toValue = 28
        radiusAnimation.duration = 0.5
        radiusAnimation.autoreverses = true
        animatedButton.layer.add(radiusAnimation, forKey: "cornerRadius")
    }
}
