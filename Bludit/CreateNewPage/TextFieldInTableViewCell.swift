//
//  TextFieldInTableViewCell.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/5/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

protocol TextFieldInTableViewCellDelegate: class {
    func textField(editingDidBeginIn cell: TextFieldInTableViewCell)
    func textField(editingChangedInTextField newText: String, in cell: TextFieldInTableViewCell)
}

class TextFieldInTableViewCell: UITableViewCell {
    
    weak var delegate: TextFieldInTableViewCellDelegate?
    
    private(set) weak var textField: UITextField?
//    private(set) weak var descriptionLabel: UILabel? // Uncomment this to have a description label on the left of the placeholder

    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, placeholder: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews(placeholder: placeholder)
    }

    private func setupSubviews(placeholder: String) {
        
        ///Stack view
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

// Uncomment this to have a description label on the left of the placeholder
//        let label = UILabel()
//        label.text = "Title: "
//        stackView.addArrangedSubview(label)
//        descriptionLabel = label

        /// Text field
        let textField = UITextField()
        textField.textAlignment = .left
        textField.placeholder = "Placeholder"
        textField.placeholder = placeholder
        textField.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        stackView.addArrangedSubview(textField)
        textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        self.textField = textField

        stackView.layoutSubviews()
        selectionStyle = .none
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didSelectCell))
        addGestureRecognizer(gesture)
        
        /// Constraints
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
}

extension TextFieldInTableViewCell {
    @objc func didSelectCell() { textField?.becomeFirstResponder() }
    @objc func editingDidBegin() { delegate?.textField(editingDidBeginIn: self) }
    @objc func textFieldValueChanged(_ sender: UITextField) {
        if let text = sender.text { delegate?.textField(editingChangedInTextField: text, in: self) }
    }
}

