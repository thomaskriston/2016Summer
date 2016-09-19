//
//  ViewController.swift
//  Pokedex
//
//  Created by Thomas Kriston  on 7/27/16.
//  Copyright © 2016 Thomas Kriston. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UITableViewController {

    var pokedex = [Pokemon]() //making an array to hold our pokemon
    
    override func viewDidLoad() {
        super.viewDidLoad() //do everything the super class wants to do
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Pokedex"
        
        let credits = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: #selector(creditsTapped))
        navigationItem.rightBarButtonItems = [credits]
        
        
        pokedex.append(Pokemon(name: "Pidgey", type: "Normal/Flying", summary: "Pidgey is pure XP gold", evolutions: ["Pidgeotto","Pidgeot"])) //adding new element to the array
         pokedex.append(Pokemon(name: "Spearow", type: "Normal/Flying", summary: "Spearow is remarkably angry", evolutions: ["Fearow"])) //adding new element to the array
         pokedex.append(Pokemon(name: "Jynx", type: "Psychic", summary: "Will cast a spell on you", evolutions: [])) //adding new element to the array
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //how many rows are in your table
        return pokedex.count //returning how many items are in the array
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { //what's in each row
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
       let pokemon = pokedex[indexPath.row]   //pull out correct pokemon for row we are looking at
        cell.textLabel?.text = pokemon.name  //modifying a text label
        cell.detailTextLabel?.text = pokemon.type    //subtitle for pokemon
        cell.imageView?.image = UIImage(named: "\(pokemon.name)-Thumb") //loading from assets catalog the name of the image
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) { //when somebody taps on a row
        if let vc = storyboard?.instantiateViewControllerWithIdentifier("Detail") as? DetailViewController { //call a thing you want to make detail
            //typecasting, attempt it to be a DetailViewController, if works run the following code
            vc.pokemon = pokedex[indexPath.row] 
            navigationController?.pushViewController(vc, animated: true) //pushing vc onto stack
        }
    }
    
    func creditsTapped(){
        if let url = NSURL(string: "https://www.linkedin.com/in/thomas-kriston-9864199b"){
            let vc = SFSafariViewController(URL:url) //create new safari view controller
            presentViewController( vc, animated: true, completion: nil)
        }
    }
    
}

//disclosure indicator gives you arrows 

