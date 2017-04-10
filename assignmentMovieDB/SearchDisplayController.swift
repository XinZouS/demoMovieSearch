//
//  ViewController.swift
//  assignmentMovieDB
//
//  Created by Xin Zou on 4/10/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit

class SearchDisplayController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "movieCellId"
    
    let searchBarView = SearchBarView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationBar()
        setupSearchBarView()
        setupCollectionView()
    }
    
    // setup for collectionView:
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    private func setupNavigationBar(){
        navigationController?.hidesBarsOnSwipe = true
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        titleLabel.text = "My Movies"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .orange
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let backgroundOrangeView = UIView() // for better animation when heiding the navigationBar
        backgroundOrangeView.backgroundColor = .orange
        view.addSubview(backgroundOrangeView)
        backgroundOrangeView.addConstraints(left: view.leftAnchor, top: view.topAnchor, right: view.rightAnchor, bottom: nil, leftConstent: 0, topConstent: 0, rightConstent: 0, bottomConstent: 0, width: 0, height: 40)

    }
    
    private func setupSearchBarView(){
        searchBarView.searchDisplayController = self
        view.addSubview(searchBarView)
        searchBarView.addConstraints(left: view.leftAnchor, top: nil, right: view.rightAnchor, bottom: nil, leftConstent: 0, topConstent: 0, rightConstent: 0, bottomConstent: 0, width: 0, height: 40)
        searchBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupCollectionView(){
        collectionView?.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }

    func searchMovies(){
        //print("start searching movies...") 
        // API: https://developers.themoviedb.org/3/search/search-movies
        let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
        
        // url demo: https://api.themoviedb.org/3/search/movie?api_key=<<api_key>>&language=en-US&page=1&include_adult=false
        let nsUrl = NSURL(string: "https://api.themoviedb.org/3/search/movie?include_adult=false&page=1&language=en-US&api_key=%3C%3Capi_key%3E%3E")
        var request = NSMutableURLRequest(url: nsUrl! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0) as URLRequest
        request.httpMethod = "GET"
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("get error when sending URL request: SearchDisplayControler.swift: ", error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        }) 
        
        dataTask.resume()

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





