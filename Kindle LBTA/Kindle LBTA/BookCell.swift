//
//  BookCell.swift
//  Kindle LBTA
//
//  Created by Andrew Freitas on 12/10/19.
//  Copyright © 2019 Andrew Freitas. All rights reserved.
//

import UIKit
class BookCell: UITableViewCell{
    
    var book: Book? {
        didSet{
            coverImageView.image = book?.image
            titleLabel.text = book?.title
            authorLabel.text = book?.author
            
            //print(book?.coverImageURL)
            
            guard let coverImageURL = book?.coverImageURL else {
                return
            }
            
            guard let url = URL(string: coverImageURL) else{
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in

                if let err = error{
                    print("Failed to retrieve our image", err)
                    return
                }
                
                guard let imageData = data else {
                    return
                }
                
                let image = UIImage(data: imageData)
                
                DispatchQueue.main.async{
                    self.coverImageView.image = image
                }
            }.resume()
            
        }
    }
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.image = UIImage(named: "steve_jobs")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the tex of the title for the book inside of our cell"
        //label.backgroundColor = .blue
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the author of the book we have for this row"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        //label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(coverImageView)
        //coverImageView.frame = CGRect(x: 8, y: 8, width: 50, height: 64)
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(titleLabel)
        //cant expand lable all the way out with this method
        //titleLabel.frame = CGRect(x: 66, y: 20, width: UIScreen.main.bounds.width, height: 20)
        titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo:self.centerYAnchor, constant: -10).isActive = true
        
        //print("Cell is being initialized")
        
        addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo:titleLabel.bottomAnchor, constant: 4).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        authorLabel.rightAnchor.constraint(equalTo:self.rightAnchor, constant: -8).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}
