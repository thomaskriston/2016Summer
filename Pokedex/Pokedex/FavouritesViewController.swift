//
//  FavouritesViewController.swift
//  Pokedex
//
//  Created by Thomas Kriston  on 7/27/16.
//  Copyright © 2016 Thomas Kriston. All rights reserved.
//

import UIKit

class FavouritesViewController: UICollectionViewController {
    var favourites = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favourites" //gives title at top of Favourites tab 

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated:Bool ){
        super.viewWillAppear(animated)
        
    let defaults = NSUserDefaults.standardUserDefaults()
    let savedFavourites = defaults.objectForKey("Favourites") as? [String] ?? [String]()
        
        if favourites != savedFavourites {
            favourites = savedFavourites
            collectionView?.reloadData()
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourites.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        let pokemon = favourites [indexPath.item]
        
        if let imageView = cell.viewWithTag(1024) as? UIImageView{
            imageView.image = UIImage(named:pokemon)
        }
        return cell 
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
