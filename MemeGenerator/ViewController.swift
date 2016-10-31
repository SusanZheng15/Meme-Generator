//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Flatiron School on 10/27/16.
//  Copyright © 2016 Susan Zheng. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
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
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        
        guard let flowLayout = memeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
            //landscape
        } else {
            //portrait
        }
        
        flowLayout.invalidateLayout()
    }

    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.store.memeArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memesCell", for: indexPath) as! memeCollectionCellCollectionViewCell
        
        let data = self.store.memeArray[indexPath.row].image
        
        if let unwrappedData = data
        {
            cell.memeImages.image = UIImage.init(data: unwrappedData)
        }
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var itemsCount : CGFloat = 3.0
        if UIApplication.shared.statusBarOrientation != UIInterfaceOrientation.portrait
        {
            itemsCount = 3.0
        }
        return CGSize(width: self.view.frame.width/itemsCount - 1, height: 240/130 * (self.view.frame.width/itemsCount - 1));
    }

}

