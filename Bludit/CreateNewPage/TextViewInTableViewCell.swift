//
//  TextViewInTableViewCell.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/5/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

protocol TextViewInTableViewCellDelegate: class {
    func textView(editingDidBeginIn cell: TextViewInTableViewCell)
    func textView(editingChangedInTextView newText: String, in cell: TextViewInTableViewCell)
}

class TextViewInTableViewCell: UITableViewCell {
    
    private(set) weak var descriptionLabel: UILabel?
    private(set) weak var textView: UITextView?

    weak var delegate: TextViewInTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }

    private func setupSubviews() {
        
        /// Stack view
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        /// Text view
        let pageContentsTextView = UITextView()
        pageContentsTextView.isScrollEnabled = true
        pageContentsTextView.font = UIFont.systemFont(ofSize: 16)
        pageContentsTextView.text = "Page contents"
        stackView.addArrangedSubview(pageContentsTextView)
        self.textView = pageContentsTextView
        
        stackView.layoutSubviews()
        selectionStyle = .none
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didSelectCell))
        addGestureRecognizer(gesture)
        
        /// Constraints
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            pageContentsTextView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
}

extension TextViewInTableViewCell {
    @objc func didSelectCell() { textView?.becomeFirstResponder() }
    @objc func editingDidBegin() { delegate?.textView(editingDidBeginIn: self) }
    @objc func textViewValueChanged(_ sender: UITextView) {
        if let text = sender.text { delegate?.textView(editingChangedInTextView: text, in: self) }
    }
}

