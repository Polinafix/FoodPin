//
//  RestaurantTableTableViewController.swift
//  FoodPin
//
//  Created by Polina Fiksson on 26/02/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit


class RestaurantTableTableViewController: UITableViewController {
    //array of Restaurant objects
    var restaurants:[Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", phone: "232-923423", image: "cafedeadend.jpg", isVisited: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", phone: "348-233423", image: "homei.jpg", isVisited: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", phone: "354-243523", image: "teakha.jpg", isVisited: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", phone: "453-333423", image: "cafeloisl.jpg", isVisited: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", phone: "983-284334", image: "petiteoyster.jpg", isVisited: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", phone: "232-434222", image: "forkeerestaurant.jpg", isVisited: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", phone: "234-834322", image: "posatelier.jpg", isVisited: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", phone: "982-434343", image: "bourkestreetbakery.jpg", isVisited: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", phone: "734-232323", image: "haighschocolate.jpg", isVisited: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", phone: "872-734343", image: "palominoespresso.jpg", isVisited: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", phone: "343-233221", image: "upstate.jpg", isVisited: false),
        Restaurant(name: "Traif", type: "American", location: "New York", phone: "985-723623", image: "traif.jpg", isVisited: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", phone: "455-232345", image: "grahamavenuemeats.jpg", isVisited: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", phone: "434-232322", image: "wafflewolf.jpg", isVisited: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", phone: "343-234553", image: "fiveleaves.jpg", isVisited: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", phone: "342-455433", image: "cafelore.jpg", isVisited: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", phone: "643-332323", image: "confessional.jpg", isVisited: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", phone: "542-343434", image: "barrafina.jpg", isVisited: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", phone: "722-232323", image: "donostia.jpg", isVisited: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", phone: "343-988834", image: "royaloak.jpg", isVisited: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", phone: "432-344050", image: "caskpubkitchen.jpg", isVisited: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
            .plain, target: nil, action: nil)
        //hide navigation bar
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
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
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        //method is used for retrieving a reusable table cell from the queue with the specified cell identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        //The dequeueReusableCellWithIdentifier method always returns a UITableViewCell object.
        //If a custom cell is used, this object can be converted to the specific cell type (e.g. RestaurantTableViewCell)

        // Configure the cell...
        
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        //update the accessory view
        cell.accessoryType = restaurants[indexPath.row].isVisited ? .checkmark : .none
        /*if restaurantIsVisited[indexPath.row] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }*/

        return cell
    }
   /* //method is called after the user selects a row
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
        
    }*/
    
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
                    self.restaurants[indexPath.row].name
                if let imageToShare = UIImage(named:
                    self.restaurants[indexPath.row].image){
                let activityController = UIActivityViewController(activityItems:
                    [defaultText, imageToShare], applicationActivities: nil)
                
                self.present(activityController, animated: true, completion: nil)
                }
        })
        // Delete button
        let deleteAction = UITableViewRowAction(style:UITableViewRowActionStyle.default, title: "Delete",handler: { (action,
            indexPath) -> Void in
            // Delete the row from the data source
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        })
        
        shareAction.backgroundColor = UIColor(red: 48.0/255.0, green: 173.0/255.0,
                                              blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0,
                                               blue: 203.0/255.0, alpha: 1.0)
        //telling the table view to create the buttons when someone swipes across the cell.
        return [deleteAction, shareAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //The block of code is only executed for the showRestaurantDetail segue
        if segue.identifier == "showRestaurantDetail" {
            //retrieve the selected row
            if let indexPath = tableView.indexPathForSelectedRow {
                //retrieve the destination controller
                let destinationController = segue.destination as!
                RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
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

  

}
