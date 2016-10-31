//
//  Meme.swift
//  MemeGenerator
//
//  Created by Susan Zheng on 10/31/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import Foundation

class meme
{
    var id: String?
    var name: String?
    var url: String?
    var image: Data?
    
    init(dictionary: NSDictionary)
    {
        if let memeID = dictionary["id"]
        {
            self.id = memeID as? String
        }
        if let memeName = dictionary["name"]
        {
            self.name = memeName as? String
        }
        if let memeURL = dictionary["url"]
        {
            self.url = memeURL as? String
            
            let url = URL(string: self.url!)
            
            if let unwrappedURL = url
            {
                self.image = try? Data.init(contentsOf: unwrappedURL)
            }
        }
        
        
    }
}
