//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Polina Fiksson on 28/02/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate {
    
    //so that we can establish a connection with the table view object in the storyboard.
    @IBOutlet var tableView:UITableView!
    
    //a reference to update the image view
    @IBOutlet weak var restaurantImageView: UIImageView!
    
//    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var type: UILabel!
//    @IBOutlet weak var location: UILabel!
//    when user selects a restaurant in the table view controller, there must be a way to pass the image name to the detail view. This variable will be used for data passing.
    var restaurant:Restaurant!
    
//    var restaurantImage = ""
//    var restaurantName = ""
//    var restaurantType = ""
//    var restaurantLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = false
    

        // Do any additional setup after loading the view.
        restaurantImageView.image = UIImage(named: restaurant.image)
        //display the restaurant name in the navigation bar
        title = restaurant.name
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.2)
        //change the color of the separators
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.8)
        //remove the separators of the empty rows by setting the footer
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //convert to self sizing cells
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
        Int {
            return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailTableViewCell
        
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phone
        case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've been here before" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
