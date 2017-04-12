//
//  MovieCell.swift
//  assignmentMovieDB
//
//  Created by Xin Zou on 4/10/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit

let imgBasicUrl = "http://image.tmdb.org/t/p/w342/"   // w185 is size for mobile
// "w92", "w154", "w185", "w342", "w500", "w780", or "original"

class MovieCell: UICollectionViewCell {

    var movie : Movie? {
        didSet{
            titleLabel.text = movie?.title ?? "Missing title."
            let vnum = movie?.vote_average ?? 0.0
            voteAvarageLabel.text = "\(vnum)"
            voteAvarageLabel.textColor = UIColor(red: min(1, CGFloat(vnum) / 8), green: max(0.2, 0.8 - CGFloat(vnum) / 8), blue: 0.2, alpha: 1)
            //
            let voteCountAttributeText = NSMutableAttributedString(string: "Vote Count:\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.gray])
            let voteCountNumAttributeText = NSMutableAttributedString(string: "      \(movie?.vote_count ?? 0.0)", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)])
            voteCountAttributeText.append(voteCountNumAttributeText)
            voteCountLabel.attributedText = voteCountAttributeText
            //
            let popularityAttributeText = NSMutableAttributedString(string: "Popularity:\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.gray])
            let popularityNumAttributeText = NSMutableAttributedString(string: "      \(movie?.popularity ?? 0.0)", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)])
            popularityAttributeText.append(popularityNumAttributeText)
            popularityLabel.attributedText = popularityAttributeText
            //
            releaseDateLabel.text = "Release Date: \(movie?.release_date ?? "Missing date.")"
            let imgUrl = imgBasicUrl + (movie?.poster_path ?? "/BbA9z4kFuIXmljZTHG3FjCWjQk.jpg")
            thumbnailImageView.loadImageUsingCacheWith(urlString: imgUrl)
        }
    }
    
    let thumbnailImageView : UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        //i.backgroundColor = .cyan
        return i
    }()
    
    let titleLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "Georgia", size: 23)
        l.text = "movie title"
        //l.backgroundColor = .red
        l.numberOfLines = 3
        return l
    }()
    
    let titleLineView : UIView = {
        let v = UIView()
        v.backgroundColor = .orange
        return v
    }()
    
    let voteAvarageLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "AmericanTypewriter-Bold", size: 40)
        l.text = "7.3"
        l.textAlignment = .center
        //l.backgroundColor = .yellow
        return l
    }()
    
    let voteCountLabel : UILabel = {
        let l = UILabel()
        l.text = "voteCountLabel"
        //l.backgroundColor = .green
        l.numberOfLines = 2
        return l
    }()
    
    let popularityLabel : UILabel = {
        let l = UILabel()
        l.text = "popularityLabel"
        //l.backgroundColor = .green
        l.numberOfLines = 2
        return l
    }()
    
    let releaseDateLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.text = "releaseDateLabel"
        //l.backgroundColor = .green
        return l
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCellView()
        
    }
    
    func setupCellView(){
        self.backgroundColor = .white
        
        let margin: CGFloat = 10
        let detailLabelHeight: CGFloat = 35
        
        self.addSubview(thumbnailImageView)
        thumbnailImageView.addConstraints(left: leftAnchor, top: topAnchor, right: nil, bottom: bottomAnchor, leftConstent: margin, topConstent: margin, rightConstent: 0, bottomConstent: margin, width: 130, height: 0)
        
        self.addSubview(titleLabel)
        titleLabel.addConstraints(left: thumbnailImageView.rightAnchor, top: topAnchor, right: rightAnchor, bottom: nil, leftConstent: 10, topConstent: margin, rightConstent: margin, bottomConstent: 0, width: 0, height: 90)
        self.addSubview(titleLineView)
        titleLineView.addConstraints(left: titleLabel.leftAnchor, top: titleLabel.bottomAnchor, right: titleLabel.rightAnchor, bottom: nil, leftConstent: 10, topConstent: -6, rightConstent: 10, bottomConstent: 0, width: 0, height: 2)
        
        self.addSubview(voteAvarageLabel)
        voteAvarageLabel.addConstraints(left: thumbnailImageView.rightAnchor, top: titleLabel.bottomAnchor, right: nil, bottom: nil, leftConstent: 10, topConstent: 0, rightConstent: 0, bottomConstent: margin, width: 80, height: 70)
        
        self.addSubview(voteCountLabel)
        voteCountLabel.addConstraints(left: voteAvarageLabel.rightAnchor, top: titleLabel.bottomAnchor, right: rightAnchor, bottom: nil, leftConstent: 10, topConstent: 0, rightConstent: margin, bottomConstent: 0, width: 0, height: detailLabelHeight)
        self.addSubview(popularityLabel)
        popularityLabel.addConstraints(left: voteCountLabel.leftAnchor, top: voteCountLabel.bottomAnchor, right: rightAnchor, bottom: nil, leftConstent: 0, topConstent: 0, rightConstent: margin, bottomConstent: 0, width: 0, height: detailLabelHeight)
        self.addSubview(releaseDateLabel)
        releaseDateLabel.addConstraints(left: thumbnailImageView.rightAnchor, top: voteAvarageLabel.bottomAnchor, right: rightAnchor, bottom: nil, leftConstent: 10, topConstent: 1, rightConstent: margin, bottomConstent: 0, width: 0, height: 20)
        
        
    }
    
    func downloadThumbnailImageFrom(url: String){
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


