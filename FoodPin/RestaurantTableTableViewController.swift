//
//  RestaurantTableTableViewController.swift
//  FoodPin
//
//  Created by Polina Fiksson on 26/02/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import CoreData


class RestaurantTableTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    //array of Restaurant objects
    var restaurants:[RestaurantMO] = []
    var searchController:UISearchController!
    var searchResults:[RestaurantMO] = []
    
    //declare an instance variable for the fetched results controller
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
            .plain, target: nil, action: nil)
        //convert to self sizing cells
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 218.0/255.0, green:
            100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest:
                fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil,
                              cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //hide navigation bar
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
        if searchController.isActive {
            return searchResults.count
        } else {
            return restaurants.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        //method is used for retrieving a reusable table cell from the queue with the specified cell identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        // Determine if we get the restaurant from search result or the original
        //array
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row]
            : restaurants[indexPath.row]

        // Configure the cell...
        
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image
            as! Data)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        //update the accessory view
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        return cell
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    //is called when NSFetchedResultsController is about to start processing the content change
    func controllerWillChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type:
        NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [RestaurantMO]
        }
    }
    func controllerDidChangeContent(_ controller:
        NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath:
        IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    

    
    //add custom actions to the table view's row
    override func tableView(_ tableView: UITableView, editActionsForRowAt
        indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style:
            UITableViewRowActionStyle.default, title: "Share", handler: { (action,
                indexPath) -> Void in
                let defaultText = "Just checking in at " +
                    self.restaurants[indexPath.row].name!
                if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image as!
                    Data) {
                let activityController = UIActivityViewController(activityItems:
                    [defaultText, imageToShare], applicationActivities: nil)
                
                self.present(activityController, animated: true, completion: nil)
                }
        })
        // Delete button
        let deleteAction = UITableViewRowAction(style:
            UITableViewRowActionStyle.default, title: "Delete",handler: { (action,
                indexPath) -> Void in
                if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                    let context = appDelegate.persistentContainer.viewContext
                    let restaurantToDelete = self.fetchResultController.object(at:
                        indexPath)
                    context.delete(restaurantToDelete)
                    appDelegate.saveContext()
                }
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
                destinationController.restaurant = (searchController.isActive) ?
                    searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
    //filter your data
    func filterContent(for searchText: String) {
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            if let name = restaurant.name, let location = restaurant.location {
                let isMatch = name.localizedCaseInsensitiveContains(searchText) || location.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    //update and display the search results
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
 

    

  

}
