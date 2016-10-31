//
//  Datastore.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/31/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import Foundation

class Datastore
{
    let api = APIClient.sharedInstance
    
    static let sharedInstance = Datastore()

    var memeArray: [meme] = []
    
    func getMemes(completion: @escaping (NSArray)->())
    {
        api.getMemeInfo { (array) in
            for eachMeme in array
            {
                let theMeme = meme.init(dictionary: eachMeme as! NSDictionary)
                self.memeArray.append(theMeme)
                completion(array)
            }
        }
    }
}
