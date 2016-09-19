//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Thomas Kriston  on 7/27/16.
//  Copyright © 2016 Thomas Kriston. All rights reserved.
//

import UIKit
import SafariServices //will allow me to host safari within my app

class DetailViewController: UITableViewController { //getting info from TableViewController
    var pokemon: Pokemon!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView! //! means it might be nil or not but don't make safely unwrap all the time
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var evolution: UILabel!
    @IBOutlet weak var toggleFavourites: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        hidesBottomBarWhenPushed = true //property we are using
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pokemon.name
        let share = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(shareTapped)) //Action means do the correct thing locally
                        //target is who should be told when the button has been tapped
                        //action is what method should I call
            //this is the first button
        //second button will show a webpage with information of pokemons 
        let readMore = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: #selector(readMoreTapped))
        navigationItem.rightBarButtonItems = [share,readMore] //read right to left on screen

        // Do any additional setup after loading the view.
        
        imageView.image = UIImage(named: pokemon.name)
        name.text = pokemon.name
        type.text = pokemon.type
        summary.text = pokemon.summary
        if pokemon.evolutions.count > 0 {
        evolution.text = "\(pokemon.name)>" + pokemon.evolutions.joinWithSeparator(">")
        } else{
            evolution.text = pokemon.name
        }
        setFavouritesLabel() //set correct text based on if it is favorite or not
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
}

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 3 {
            //this is the summary cell
            return UITableViewAutomaticDimension //measure this cell to fit its content and no larger
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath
        indexPath: NSIndexPath) {
        guard indexPath.row == 5 else {return}
        
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            let defaults = NSUserDefaults.standardUserDefaults() //saves it to the persons cloud
            var favourites = defaults.objectForKey("Favourites") as? [String] ?? [String]() //typecast this
            if let index = favourites.indexOf(pokemon.name){
               favourites.removeAtIndex(index)
            } else {
                favourites.append(pokemon.name)
            }
            
            defaults.setObject(favourites,forKey:"Favourites")
            setFavouritesLabel()
    }
    
    func shareTapped(){ //when we tap button this is what we call
        let vc = UIActivityViewController(activityItems: [pokemon.summary, imageView.image!], applicationActivities: nil) //first parameter is array of items youw want to share
        presentViewController(vc, animated:true, completion:nil) //show to user now, don't care when it's finished
    }
    
    func readMoreTapped(){
        if let url = NSURL(string: "http://pokemondb.net/pokedex/\(pokemon.name)"){ //creates a URL from a string and it might fail, if nil do nothing and move on, if it's not nil unwrap so we can use it
            let vc = SFSafariViewController(URL:url) //create new safari view controller
            presentViewController( vc, animated: true, completion: nil)
        }
    }
    
   
    
    func setFavouritesLabel(){
        let defaults = NSUserDefaults.standardUserDefaults() //saves it to the persons cloud
        let favourites = defaults.objectForKey("Favourites") as? [String] ?? [String]() //typecast this
        if favourites.contains(pokemon.name){
            toggleFavourites.text = "Remove from favourties"
        } else {
            toggleFavourites.text = "Add to favourites"
        }
    }
}