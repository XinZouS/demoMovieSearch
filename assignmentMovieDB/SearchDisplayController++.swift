//
//  SearchDisplayController++.swift
//  assignmentMovieDB
//
//  Created by Xin Zou on 4/10/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit


extension SearchDisplayController {
    
    func showAlertWith(title:String, message:String){
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertCtrl.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alertCtrl.dismiss(animated: true, completion: nil)
        }))
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
}
