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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Everytime we dequeue a cell with this string use an instance of uitableview cell to render out this row
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellID")
        //Removes extra table view lines if tableview only takes up a portion of the view.
        tableView.tableFooterView = UIView()
        navigationItem.title = "Kindle"
        
        setupBooks()
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
    
    func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupTableView() {
        setTableViewDelegates()
        tableView.rowHeight = 100
        //tableView.separatorStyle = .singleLine
//        tableView.translatesAutoresizingMaskIntoConstraints = true
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupBooks(){
        let page1 = Page(number: 1, text: "Text for my first page")
        let page2 = Page(number: 2, text: "Text for my second page")
        let pages = [page1,page2]
                
        let book = Book(title: "Steve Jobs", author: "Walter Isaacson", pages: pages, image: UIImage(named: "steve_jobs")!)
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Becraft", pages: [
        Page(number: 1, text: "This is page 1"),
        Page(number: 2, text: "This is page 2"),
        Page(number: 3, text: "This is page 3"),
        Page(number: 4, text: "This is page 4")
        ],
                         image: UIImage(named: "bill_gates")!)
                
        self.books = [book, book2]
         
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//
//
//}

