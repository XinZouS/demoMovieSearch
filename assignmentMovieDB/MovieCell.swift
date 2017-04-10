//
//  MovieCell.swift
//  assignmentMovieDB
//
//  Created by Xin Zou on 4/10/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit
 
class MovieCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        
    }
    
    func setupCell(){
        self.backgroundColor = .yellow
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


