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
    
    init(title: String, author: String, pages:[Page], image: UIImage){
        self.title = title
        self.author = author
        self.image = image
        self.pages = pages
    }
    
}
