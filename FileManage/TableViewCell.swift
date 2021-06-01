//
//  TableViewCell.swift
//  FileManage
//
//  Created by Кирилл Тила on 01.06.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

     lazy var pictureFromData: UIImageView = {
         let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
         imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView(){
        contentView.addSubview(pictureFromData)
        
        NSLayoutConstraint.activate([
            pictureFromData.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureFromData.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            pictureFromData.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureFromData.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureFromData.heightAnchor.constraint(equalTo: pictureFromData.widthAnchor),
            pictureFromData.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
 
        ])
    
    }
    
    

}
