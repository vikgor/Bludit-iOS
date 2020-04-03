//
//  PagesListCell.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/3/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

/// Don't need it for now. If not needed later - delete
class PagesListCell: UITableViewCell {

    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var pageContents: UILabel!
    
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(pageTitle)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        pageTitle.heightAnchor.constraint(equalToConstant: 200).isActive = true
        pageTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        pageTitle.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        pageTitle.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pageTitle: UILabel = {
        let label = UILabel()
        label.text = "Label"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
