//
//  CellLabel.swift
//  Bludit
//
//  Created by Viktor Gordienko on 5/17/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

final class CellLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
