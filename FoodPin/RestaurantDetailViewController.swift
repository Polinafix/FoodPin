//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Polina Fiksson on 28/02/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    //a reference to update the image view
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var location: UILabel!
//    when user selects a restaurant in the table view controller, there must be a way to pass the image name to the detail view. This variable will be used for data passing.
    var restaurantImage = ""
    var restaurantName = ""
    var restaurantType = ""
    var restaurantLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantImageView.image = UIImage(named: restaurantImage)
        name.text = restaurantName
        type.text = restaurantType
        location.text = restaurantLocation
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
