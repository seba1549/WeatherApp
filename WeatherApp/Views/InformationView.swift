//
//  InformationView.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 10/07/2024.
//

import Foundation
import UIKit

///View used to display the selected message.
final class InformationView: UIView {
    
    // MARK: - Properties
    
    private var headline: String?
    private var subheadline: String?
    private var icon: IconType?
    
    private let imageSize: CGFloat = 50
    
    // MARK: - Subviews
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private lazy var imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subheadlineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    init(headline: String? = nil, subheadline: String? = nil, systemImageName: IconType? = nil) {
        self.headline = headline
        self.subheadline = subheadline
        self.icon = systemImageName
        
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    /// Allows you to reconfigure the information view with other data.
    func reconfigureView(headline: String? = nil, subheadline: String? = nil, icon: IconType? = nil) {
        self.headline = headline
        self.subheadline = subheadline
        self.icon = icon
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(mainStack)
        
        if let icon {
            imageView.image = UIImage(systemName: icon.rawValue)
            mainStack.addArrangedSubview(imageContainer)
            imageContainer.addSubview(imageView)
            
            imageContainer.widthAnchor.constraint(equalTo: mainStack.widthAnchor).isActive = true
            imageContainer.heightAnchor.constraint(equalToConstant: imageSize + 5).isActive = true
            
            imageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
            imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true
        } else {
            imageView.removeFromSuperview()
            imageContainer.removeFromSuperview()
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
