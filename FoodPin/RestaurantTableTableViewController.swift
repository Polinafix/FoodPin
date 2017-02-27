//
//  RestaurantTableTableViewController.swift
//  FoodPin
//
//  Created by Polina Fiksson on 26/02/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class RestaurantTableTableViewController: UITableViewController {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats","Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina","Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    //we initialize the restaurantImages array with a list of image file names. The order of images are aligned with that of the restaurantNames
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg",
                            "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg","bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg","upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg","fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg","donostia.jpg", "royaloak.jpg", "caskpubkitchen.jpg"]
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
                               "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York","London", "London", "London", "London"]
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian /Casual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American /Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell

        // Configure the cell...
        //cell.textLabel?.text = restaurantNames[indexPath.row]
        cell.nameLabel.text = restaurantNames[indexPath.row]
       // cell.imageView?.image = UIImage(named:"restaurant.jpg")
        //different picture
        //cell.imageView?.image = UIImage(named: restaurantImages[indexPath.row])
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
            nil)
        // Add Call action
        //The block of code will be executed when a user selects the action
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Service Unavailable", message:
                "Sorry, the call feature is not available yet. Please retry later.",
                                                 preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler:
                nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)",
            style: .default, handler: callActionHandler)
        
        // Check-in action
       // we add a checkmark to the selected cell to indicate user has been to the restaurant.
        let checkInAction = UIAlertAction(title: "Check in", style: .default, handler:
            {
                (action:UIAlertAction!) -> Void in
                //retrieves the selected table cell using indexPath , which contains the index of the selected cell.
                let cell = tableView.cellForRow(at: indexPath)
                //updates the accessoryType property of the cell with a check mark.
                cell?.accessoryType = .checkmark
        })
        optionMenu.addAction(checkInAction)
        optionMenu.addAction(callAction)
        optionMenu.addAction(cancelAction)
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
