//
//  MovieDetailController.swift
//  assignmentMovieDB
//
//  Created by Xin Zou on 4/11/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit

class MovieDetailController : UIViewController {
    
    var movie : Movie? {
        didSet{
            setupNavigationBar()
            setupTitleLabel()
            if let bkdpImgUrl = movie?.backdrop_path {
                setupImageFor(backdropImageView, withUrl: imgBasicUrl + bkdpImgUrl)
            }else{
                backdropImageViewHeightConstraint?.constant = 1.0
            }
            setupDetailTitleTextView()
            setupDetailVoteTextView()
            if let psImgUrl = movie?.poster_path {
                setupImageFor(postImageView, withUrl: imgBasicUrl + psImgUrl)
            }else{
                postImageViewHeightConstraint?.constant = 1.0
            }
            setupOverviewTextView()
            self.view.layoutIfNeeded()
        }
    }
    
    let movieTitleLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "Georgia", size: 30)
        l.textAlignment = .center
        l.numberOfLines = 0
        //l.backgroundColor = .red
        return l
    }()
    var movieTitleLabelHeighConstraint : NSLayoutConstraint?
    
    let backdropImageView : UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        //v.backgroundColor = .orange
        return v
    }()
    var backdropImageViewHeightConstraint: NSLayoutConstraint?
    
    let detailTitleTextView : UITextView = {
        let t = UITextView()
        t.isEditable = false
        //t.backgroundColor = .yellow
        return t
    }()
    
    let detailVoteTextView : UITextView = {
        let t = UITextView()
        t.isEditable = false
        t.isScrollEnabled = false
        //t.backgroundColor = .green
        return t
    }()
    
    let postImageView : UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFit
        //i.backgroundColor = .orange
        return i
    }()
    var postImageViewHeightConstraint: NSLayoutConstraint?
    
    let overviewTextView : UITextView = {
        let t = UITextView()
        t.isEditable = false
        t.isScrollEnabled = false
        t.font = UIFont.systemFont(ofSize: 18)        
        return t
    }()
    var overviewTextViewHeightConstraint: NSLayoutConstraint?
    
    
    let scrollView : UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1000))
        v.backgroundColor = .white
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        
    }
    
    private func setupNavigationBar(){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        titleLabel.text = "Movie Details"
        titleLabel.font = UIFont(name: "AmericanTypewriter", size: 23)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
    }
    
    private func setupScrollView(){
        self.view.addSubview(scrollView)
        scrollView.addConstraints(left: view.leftAnchor, top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, leftConstent: 0, topConstent: 0, rightConstent: 0, bottomConstent: 0, width: UIScreen.main.bounds.width, height: 0)
        
        let scrL = view.leftAnchor
        let scrR = view.rightAnchor

        scrollView.addSubview(movieTitleLabel)
        movieTitleLabel.addConstraints(left: scrL, top: scrollView.topAnchor, right: scrR, bottom: nil, leftConstent: 20, topConstent: 0, rightConstent: 20, bottomConstent: 0, width: 0, height: 80)
        movieTitleLabelHeighConstraint = movieTitleLabel.constraints[0]
        
        scrollView.addSubview(backdropImageView)
        let bkImgH: CGFloat = scrollView.frame.width * (9.0 / 16.0)
        backdropImageView.addConstraints(left: scrL, top: movieTitleLabel.bottomAnchor, right: scrR, bottom: nil, leftConstent: 0, topConstent: 0, rightConstent: 0, bottomConstent: 0, width: 0, height: bkImgH)
        backdropImageViewHeightConstraint = backdropImageView.constraints[0]
        
        scrollView.addSubview(detailTitleTextView)
        detailTitleTextView.addConstraints(left: scrL, top: backdropImageView.bottomAnchor, right: scrR, bottom: nil, leftConstent: 20, topConstent: 0, rightConstent: 20, bottomConstent: 0, width: 0, height: 140)
        
        scrollView.addSubview(detailVoteTextView)
        detailVoteTextView.addConstraints(left: scrL, top: detailTitleTextView.bottomAnchor, right: scrR, bottom: nil, leftConstent: 20, topConstent: 0, rightConstent: 0, bottomConstent: 0, width: 0, height: 150)
        
        scrollView.addSubview(postImageView)
        let psImgH: CGFloat = (scrollView.frame.width - 40) * (4.0 / 3.0)
        postImageView.addConstraints(left: scrL, top: detailVoteTextView.bottomAnchor, right: scrR, bottom: nil, leftConstent: 20, topConstent: 0, rightConstent: 20, bottomConstent: 0, width: 0, height: psImgH)
        postImageViewHeightConstraint = postImageView.constraints[0]
        
        scrollView.addSubview(overviewTextView)
        overviewTextView.addConstraints(left: scrL, top: postImageView.bottomAnchor, right: scrR, bottom: scrollView.bottomAnchor, leftConstent: 30, topConstent: 10, rightConstent: 30, bottomConstent: 0, width: 0, height: 300)
        overviewTextViewHeightConstraint = overviewTextView.constraints[0]
    }
    
    private func setupTitleLabel(){
        movieTitleLabel.text = movie?.title ?? "Missing title🎬"
        let size = CGSize(width: (view.frame.width - 40), height: 100)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 40)]
        let estimateRect = NSString(string: movieTitleLabel.text!).boundingRect(with: size, options: option, attributes: attributes, context: nil)
        movieTitleLabelHeighConstraint?.constant = max(estimateRect.height + 10.0, 80)
    }
    private func setupImageFor(_ imgView: UIImageView, withUrl urlStr: String){
        imgView.loadImageUsingCacheWith(urlString: urlStr)
    }
    
    private let titleAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: UIColor.gray]
    private let contentAttributes = [NSFontAttributeName: UIFont(name: "AmericanTypewriter-Bold", size: 20)! , NSForegroundColorAttributeName: UIColor.orange]

    private func setupDetailTitleTextView(){
        let releaseDateStr = movie?.release_date ?? "missing date📆"
        let idStr = movie?.id ?? 00
        let originalTitleStr = movie?.original_title ?? "missing original title."
        let languageStr = movie?.original_language ?? "missing language info."

        let resultStr = NSMutableAttributedString(string: "Release Date:  ", attributes: titleAttributes)
        resultStr.append(NSMutableAttributedString(string: releaseDateStr + "\n", attributes: contentAttributes) )
        resultStr.append(NSMutableAttributedString(string: "Movie ID:  ", attributes: titleAttributes) )
        resultStr.append(NSMutableAttributedString(string: "\(idStr)\n", attributes: contentAttributes) )
        resultStr.append(NSMutableAttributedString(string: "Original Title:  ", attributes: titleAttributes) )
        resultStr.append(NSMutableAttributedString(string: originalTitleStr + "\n", attributes: contentAttributes) )
        resultStr.append(NSMutableAttributedString(string: "Language:  ", attributes: titleAttributes) )
        resultStr.append(NSMutableAttributedString(string: languageStr.capitalized, attributes: contentAttributes) )
        detailTitleTextView.attributedText = resultStr
    }
    private func setupDetailVoteTextView(){
        let popularityStr = (movie?.popularity) ?? 0
        let voteCountStr = movie?.vote_count ?? 0
        let voteavgStr = movie?.vote_average ?? 0
        let videoStr = (movie?.video ?? false) ? "No video available." : "Video on MovieDB.com"
        
        let resultStr = NSMutableAttributedString(string: "😃 Popularity:  ", attributes: titleAttributes)
        resultStr.append(NSMutableAttributedString(string: "\(popularityStr)\n", attributes: contentAttributes) )
        resultStr.append(NSMutableAttributedString(string: "👍🏼 Vote Count:  ", attributes: titleAttributes) )
        resultStr.append(NSMutableAttributedString(string: "\(voteCountStr)\n", attributes: contentAttributes) )
        resultStr.append(NSMutableAttributedString(string: "❤️ Vote Average:  ", attributes: titleAttributes) )
        resultStr.append(NSMutableAttributedString(string: "\(voteavgStr)\n", attributes: contentAttributes) )
        resultStr.append(NSMutableAttributedString(string: "🎦 Video:  ", attributes: titleAttributes) )
        resultStr.append(NSMutableAttributedString(string: "\(videoStr)\n", attributes: contentAttributes) )
        detailVoteTextView.attributedText = resultStr
    }
    private func setupOverviewTextView(){
        overviewTextView.text = movie?.overview ?? "Oops! No overview for this movie 😂"
        let size = CGSize(width: (view.frame.width - 40), height: 300)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 20)]
        let estimateRect = NSString(string: overviewTextView.text!).boundingRect(with: size, options: option, attributes: attributes, context: nil)
        overviewTextViewHeightConstraint?.constant = estimateRect.height + 60
    }
    
    
    
}

