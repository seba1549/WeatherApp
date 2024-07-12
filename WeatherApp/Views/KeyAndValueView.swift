//
//  KeyAndValueView.swift
//  WeatherApp
//
//  Created by Sebastian Maludziński on 12/07/2024.
//

import UIKit
import Foundation

final class KeyAndValueView: UIView {
    
    // MARK: - Properties
    
    private var key: String = .empty
    private var value: String = .empty
    
    // MARK: - Subviews
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var spacer = UIView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func configureView(key: String, value: String) {
        self.key = key
        self.value = value
        setupView()
    }
    
    func configureView(key: String, value: Int?) {
        guard let value else { return }
        self.key = key
        self.value = String(value)
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(mainStack)
        mainStack.addArrangedSubview(keyLabel)
        mainStack.addArrangedSubview(spacer)
        mainStack.addArrangedSubview(valueLabel)
        
        keyLabel.text = key
        valueLabel.text = value
        
        NSLayoutConstraint.activate([
            mainStack.widthAnchor.constraint(equalTo: self.widthAnchor),
            mainStack.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
}
