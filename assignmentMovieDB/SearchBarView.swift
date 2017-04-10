//
//  SearchBarView.swift
//  assignmentMovieDB
//
//  Created by Xin Zou on 4/10/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit

class SearchBarView : UIView {
    
    var searchDisplayController : SearchDisplayController?
    
    let textField : UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = UIFont.systemFont(ofSize: 16)
        t.placeholder = "  Search key words..."
        t.backgroundColor = .white
        t.layer.cornerRadius = 6
        t.layer.masksToBounds = true
        return t
    }()
    
    lazy var submitButton : UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(searchMovies), for: .touchUpInside)
        b.setTitle("🔍", for: .normal)
        b.layer.cornerRadius = 15
        b.layer.masksToBounds = true
        b.backgroundColor = .yellow
        return b
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .orange
        
        self.addSubview(submitButton)
        submitButton.addConstraints(left: nil, top: topAnchor, right: rightAnchor, bottom: nil, leftConstent: 0, topConstent: 5, rightConstent: 10, bottomConstent: 0, width: 50, height: 30)
        
        self.addSubview(textField)
        textField.addConstraints(left: leftAnchor, top: topAnchor, right: submitButton.leftAnchor, bottom: nil, leftConstent: 20, topConstent: 5, rightConstent: 10, bottomConstent: 0, width: 0, height: 30)
        
    }
    
    func searchMovies(){
        searchDisplayController?.searchMovies()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


