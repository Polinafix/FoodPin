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
    
    
    // declare a Boolean array:
   // var restaurantIsVisited = Array(repeating: false, count: 21)
    
    var restaurantIsVisited = [false, false, false, false, false, false, false,
                               false, false, false, false, false, false, false, false, false, false, false,
                               false, false, false]

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
        //method is used for retrieving a reusable table cell from the queue with the specified cell identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        //The dequeueReusableCellWithIdentifier method always returns a UITableViewCell object.
        //If a custom cell is used, this object can be converted to the specific cell type (e.g. RestaurantTableViewCell)

        // Configure the cell...
        
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        //update the accessory view
        cell.accessoryType = restaurantIsVisited[indexPath.row] ? .checkmark : .none
        /*if restaurantIsVisited[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }*/

        return cell
    }
    //method is called after the user selects a row
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
        // Determine the check in title. If the selected restaurant has been checked (i.e.
        // restaurantIsVisited[indexPath.row] returns true), the title will be set to "Undo Check in".
        let checkInTitle = restaurantIsVisited[indexPath.row] ? "Undo Check in" : "Check in"
        let checkInAction = UIAlertAction(title: checkInTitle, style: .default, handler:
            {
                (action:UIAlertAction!) -> Void in
                //retrieves the selected table cell using indexPath , which contains the index of the selected cell.
                let cell = tableView.cellForRow(at: indexPath)
                //updates the accessoryType property of the cell with a check mark.
                //cell?.accessoryType = .checkmark
                //update the value of the Bool array when a restaurant is checked
                //self.restaurantIsVisited[indexPath.row] = true
                
                
                //update the value of the Bool array when a restaurant is checked or unchecked
                self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
                // Toggle check-in and undo-check-in
                cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
        })
        optionMenu.addAction(checkInAction)
        optionMenu.addAction(callAction)
        optionMenu.addAction(cancelAction)
        // Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        //method to deselect the row
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
/*// Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            restaurantNames.remove(at: indexPath.row)
            restaurantTypes.remove(at: indexPath.row)
            restaurantLocations.remove(at: indexPath.row)
            restaurantImages.remove(at: indexPath.row)
            restaurantIsVisited.remove(at: indexPath.row)
            
            
            }
       // We only remove the data from the model but haven't notified the table view to update its content.
        //reload the data in the table view:
       // tableView.reloadData()
        
        //delete a specific row from the table view.
        tableView.deleteRows(at: [indexPath], with: .fade)
        
    }*/
    
    //add custom actions to the table view's row
    override func tableView(_ tableView: UITableView, editActionsForRowAt
        indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style:
            UITableViewRowActionStyle.default, title: "Share", handler: { (action,
                indexPath) -> Void in
                let defaultText = "Just checking in at " +
                    self.restaurantNames[indexPath.row]
                if let imageToShare = UIImage(named:
                    self.restaurantImages[indexPath.row]){
                let activityController = UIActivityViewController(activityItems:
                    [defaultText, imageToShare], applicationActivities: nil)
                
                self.present(activityController, animated: true, completion: nil)
                }
        })
        // Delete button
        let deleteAction = UITableViewRowAction(style:UITableViewRowActionStyle.default, title: "Delete",handler: { (action,
            indexPath) -> Void in
            // Delete the row from the data source
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0,
                                              blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0,
                                               blue: 203.0/255.0, alpha: 1.0)
        //telling the table view to create the buttons when someone swipes across the cell.
        return [deleteAction, shareAction]
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
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
