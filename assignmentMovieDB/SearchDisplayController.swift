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
    
    var currPage : NSNumber = 1
    
    var movies : [Movie] = [Movie]()
    var total_results : NSNumber = 0
    var page   : NSNumber = 0 // JSON searching results' page
    var total_pages : NSNumber = 0
    let imgBasicUrl = " http://image.tmdb.org/t/p/w185/"   // w185 is size for mobile
    
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
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
        cell.movie = movies[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        let movieDetailController = MovieDetailController()
        movieDetailController.movie = selectedMovie
        navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
    private func setupNavigationBar(){
        navigationController?.hidesBarsOnSwipe = true
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        titleLabel.text = "My MovieDB"
        titleLabel.font = UIFont(name: "AmericanTypewriter", size: 23)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
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
        collectionView?.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 40, left: 0, bottom: 5, right: 0)
        collectionView?.alwaysBounceVertical = true
    }

    func searchMovies(){
        guard let keyWord = searchBarView.textField.text, keyWord != "" else {
            showAlertWith(title: "Oops! Something miss", message: "Please type at least one keyword of the movie you want to find.")
            return
        }
        // API: https://developers.themoviedb.org/3/search/search-movies
        let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
        
        let apiKey = "635cdfbf239eb6f85297d3777fbcda86"
        let keyWordFormated = keyWord.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(keyWordFormated)&page=\(currPage)&include_adult=false"
        guard let nsUrl = NSURL(string: urlString) else {
            showAlertWith(title: "Is Keyword Right?", message: "Keywords are only allow letters and spaces, no numbers or other characters, please try again.")
            return
        }
        var request = NSMutableURLRequest(url: nsUrl as! URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0) as URLRequest
        request.httpMethod = "GET"
        request.httpBody = postData as Data
        
        downloadMovieInfoBy(request)
        
    }
    
    private func downloadMovieInfoBy(_ request: URLRequest){
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let downloadContent = data, error == nil else {
                print("get error when sending URL request: SearchDisplayControler.swift: ", error!)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: downloadContent, options: .mutableContainers) as! [String:AnyObject]
                
                self.total_results = json["total_results"] as? NSNumber ?? 0
                self.currPage = json["page"] as? NSNumber ?? 0
                self.total_pages = json["total_pages"] as? NSNumber ?? 0
                let movieResults = json["results"] as? [[String:AnyObject]] ?? [["Result":"get no result." as AnyObject]]
                for getMovie in movieResults {
                    //print("---getMovies---", getMovie)
                    let newMovie = Movie(dictionary: getMovie)
                    self.movies.append(newMovie)
                }
                DispatchQueue.main.async {
                    if self.total_results == 0 {
                        self.showAlertWith(title: "Oops, no result 😅", message: "We can not find any movie with the keyword. Please try other keywords.")
                    }else{
                        self.collectionView?.reloadData()
                    }
                }
                
            }catch{
                self.showAlertWith(title: "Data faild", message: "Get an error when trying to decode downloaded data. Please try again later.")
            }
            
        })
        dataTask.resume()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





