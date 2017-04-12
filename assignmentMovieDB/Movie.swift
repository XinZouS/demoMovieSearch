//
//  Movie.swift
//  assignmentMovieDB
//
//  Created by Xin Zou on 4/10/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit

class SafeJsonObject : NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstChar = String(key.characters.first!).uppercased()
        let selectorStr = uppercasedFirstChar + key.substring(from: key.index(key.startIndex, offsetBy: 1))
        let selector = NSSelectorFromString("set\(selectorStr):")
        let responds = self.responds(to: selector)
        if !responds {
            //print("can not find Movie setter from key:\(key) for: ", selectorStr)
            return
        }
        super.setValue(value, forKey: key)
    }
    
}

class Movie : SafeJsonObject {
    
    var poster_path:    String? //url: /hlWVb2DeqkrViXarProJCHyufgi.jpg
    var adult:          Bool?
    var overview:       String?
    var release_date:   String?     // 1984-03-02
    var genre_ids:      [NSNumber]? // [18,99]
    var id:             NSNumber?   // 91767
    var original_title: String?
    var original_language:String?
    var title:          String?
    var backdrop_path:  String? // url /6YwEwhzud2GcmrG2AbYcoHIfvWH.jpg
    var popularity:     NSNumber?  // 1.076187
    var vote_count:     NSNumber?  // 11
    var video:          Bool?      // false
    var vote_average:   NSNumber?  // 5.2
    
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
    
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "genre_ids" {
            let ids = value as? [NSNumber] ?? []
            for id in ids {
                self.genre_ids?.append(id)
            }
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
}



