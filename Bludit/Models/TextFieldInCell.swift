//
//  TextFieldInCell.swift
//  Bludit
//
//  Created by Viktor Gordienko on 5/17/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

final class TextFieldInCell: UITextField, UITextFieldDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
