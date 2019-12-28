//
//  Book.swift
//  Kindle LBTA
//
//  Created by Andrew Freitas on 12/4/19.
//  Copyright © 2019 Andrew Freitas. All rights reserved.
//

import UIKit


class Book {
    
    let title: String
    let author: String
    
    let pages: [Page]
    let image: UIImage
    
    let coverImageURL: String
    
    init(title: String, author: String, pages:[Page], image: UIImage){
        self.title = title
        self.author = author
        self.image = image
        self.pages = pages
        self.coverImageURL = ""
    }
    
    init(dictionary: [String: Any]){
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        self.coverImageURL = dictionary["coverImageUrl"] as? String ?? ""

        image = #imageLiteral(resourceName: "bill_gates")
        
        var bookPages = [Page]()
        
        if let pagesDictionaries = dictionary["pages"] as? [[String: Any]]{
            
            for pageDictionary in pagesDictionaries{
                
                if let pageText = pageDictionary["text"] as? String {
                    let page = Page(number: 1, text: pageText)
                    bookPages.append(page)
                }
            }
        }
        
        self.pages = bookPages
        
    }
    
}
