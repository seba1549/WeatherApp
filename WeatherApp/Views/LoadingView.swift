//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 12/07/2024.
//

import Foundation
import UIKit

/// Data loading view.
final class LoadingView: UIView {
    
    // MARK: - Subviews
    
    private lazy var container: UIView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = .secondaryLabel
        return spinner
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(container)
        container.addSubview(loadingSpinner)
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalTo: self.widthAnchor),
            container.heightAnchor.constraint(equalTo: self.heightAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            loadingSpinner.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        ])
    }
    
}
