//
//  APIClient.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/29/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import Foundation

class APIClient
{
    class func getMemeInfo(completion: @escaping (NSDictionary)->())
    {
        let urlString = "https://api.imgflip.com/get_memes"
        
        let url = URL(string: urlString)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? NSDictionary
                
                guard let dictionary = json else {return}
                completion(dictionary)
            }
            catch
            {
                print("error")
            }
            
        }
        task.resume()
    }
}
