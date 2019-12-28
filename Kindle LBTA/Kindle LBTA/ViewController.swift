//
//  ViewController.swift
//  Kindle LBTA
//
//  Created by Andrew Freitas on 12/4/19.
//  Copyright © 2019 Andrew Freitas. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //var tableView = UITableView()
    
    //view controller doesnt have a custom initializer so we must declare books as an option null value by adding an optional (?) must change let to var because you have to change a potential null to a new value
    var books: [Book]?
    var footerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarStyles()
        setUpNavBarButtons()
        //Everytime we dequeue a cell with this string use an instance of uitableview cell to render out this row
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellID")
        //Removes extra table view lines if tableview only takes up a portion of the view.
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.separatorColor = UIColor(white:1, alpha: 0.2)
        navigationItem.title = "Kindle"
        
        fetchBooks()
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red:40/255 , green:40/255, blue:40/255, alpha: 1)

        let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
        footerView.addSubview(segmentedControl)
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        let gridButton = UIButton(type: .system)
        gridButton.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal) , for: .normal)
        footerView.addSubview(gridButton)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 20).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        let sortButton = UIButton(type: .system)
        sortButton.setImage(#imageLiteral(resourceName: "sort").withRenderingMode(.alwaysOriginal), for: .normal)
        footerView.addSubview(sortButton)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.rightAnchor.constraint(equalTo:footerView.rightAnchor, constant:-20).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true

        return footerView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 50
    }
    
    func setUpNavBarButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), style:.plain , target: self, action:#selector(handleMenuPress))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "amazon_icon").withRenderingMode(.alwaysOriginal), style:.plain , target: self, action:#selector(handleAmazonPress))
    }
    
    @objc func handleMenuPress(){
        print("Menu pressed")
    }
    
    @objc func handleAmazonPress(){
        print("Amazon Pressed")
    }
    
    func setupNavigationBarStyles(){
        navigationController?.navigationBar.barTintColor = UIColor(red:40/255 , green:40/255, blue:40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        print("setting up nav bar styles")
    }
    
    func fetchBooks(){
        print("fetching books...")
        if let url = URL(string:"https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if let err = error{
                    print("Failed to fetch json books", err)
                    return
                }
                
                guard let data = data else{
                    return
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    
                    guard let bookDictionaries = json as? [[String : Any]] else{
                        return
                    }
                    
                    self.books = []
                    
                    for bookDictionary in bookDictionaries{
                       
                        let book = Book(dictionary: bookDictionary)
                        self.books?.append(book)
            
                    }
                    
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                    
                } catch let jsonError{
                    print ("Failed to parse json properly", jsonError)
                }
            }).resume()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let selectedBook = self.books?[indexPath.row]
//        print(book?.title)
//        return
        
        let layout = UICollectionViewFlowLayout()
        let bookPagerController = BookPagerController(collectionViewLayout: layout)
        
        bookPagerController.book = selectedBook
        
        let navController = UINavigationController(rootViewController: bookPagerController)
        present(navController, animated: true,
                completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 86
    }
    
    //Tells the app what should go in each cell. Dequeue allows the tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! BookCell
        
        let book = books?[indexPath.row]
        cell.book = book
        
        return cell
    }
    
    //Returns how many cells your table view will have
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if let count = books?.count{
            return count
        }
        return 0
    }
}
