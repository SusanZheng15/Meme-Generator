//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/27/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
   
    let store = Datastore.sharedInstance
    
    @IBOutlet weak var memeCollectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.memeCollectionView.delegate = self
        self.memeCollectionView.dataSource = self
        
        store.getMemes { (array) in
            
            OperationQueue.main.addOperation({ 
                self.memeCollectionView.reloadData()
            })
            
        }
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.store.memeArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memesCell", for: indexPath) as! memeCollectionCellCollectionViewCell
        
        if let imageURLString = self.store.memeArray[indexPath.row].url
        {
            let url = URL(string: imageURLString)
            
            if let unwrappedURL = url
            {
                DispatchQueue.main.async(execute:
                {
                    let data = try? Data.init(contentsOf: unwrappedURL)
                    
                    if let unwrappedData = data
                    {
                        cell.memeImages.image = UIImage.init(data: unwrappedData)
                    }
                })
                
            }
        }
        
        
        return cell
    }
  

}

