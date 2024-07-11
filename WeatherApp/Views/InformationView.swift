//
//  InformationView.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation
import UIKit

final class InformationView: UIView {
    
    // MARK: - Properties
    
    private let headline: String
    private let subheadline: String?
    private let systemImageName: AppIcon?
    
    private let imageSize: CGFloat = 50
    
    // MARK: - Views
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .clear
        stack.spacing = 5
        return stack
    }()
    
    private lazy var imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .gray
        return imageView
    }()
    
    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var subheadlineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // MARK: - Lifecycle
    
    init(headline: String, subheadline: String? = nil, systemImageName: AppIcon? = nil) {
        self.headline = headline
        self.subheadline = subheadline
        self.systemImageName = systemImageName
        
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(mainStack)
        
        if let systemImageName {
            imageView.image = UIImage(systemName: systemImageName.rawValue)
            mainStack.addArrangedSubview(imageContainer)
            imageContainer.addSubview(imageView)
            
            imageContainer.widthAnchor.constraint(equalTo: mainStack.widthAnchor).isActive = true
            imageContainer.heightAnchor.constraint(equalToConstant: imageSize + 5).isActive = true
            
            imageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
            imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true
        }
        
        headlineLabel.text = headline
        mainStack.addArrangedSubview(headlineLabel)
        
        if let subheadline {
            subheadlineLabel.text = subheadline
            mainStack.addArrangedSubview(subheadlineLabel)
        }
        
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headlineLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
}
