//
//  AddRestaurantTableViewController.swift
//  FoodPin
//
//  Created by Polina Fiksson on 03/03/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantTableViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var restaurant:RestaurantMO!
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameTextField:UITextField!
    @IBOutlet var typeTextField:UITextField!
    @IBOutlet var locationTextField:UITextField!
    @IBOutlet var yesButton:UIButton!
    @IBOutlet var noButton:UIButton!
    @IBOutlet var phoneTextField: UITextField!
    
    var isVisited = true

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

    //detect the touch and load the photo library:
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    //delegate method
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        //define and activate four layout constraints for the image view so that the image is bound within the cell
        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute:
            NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem:
            photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1,
                                      constant: 0)
        leadingConstraint.isActive = true
        let trailingConstraint = NSLayoutConstraint(item: photoImageView,
            attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal,
            toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing,
            multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute:
            NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem:
            photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1,
                                      constant: 0)
        topConstraint.isActive = true
        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute:
            NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem:
            photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1,
                                      constant: 0)
        bottomConstraint.isActive = true
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveRestaurant(_ sender: UIBarButtonItem) {
        if nameTextField.text == "" || typeTextField.text == "" || locationTextField.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        //to get the AppDelegate object and variable
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            restaurant = RestaurantMO(context:
                appDelegate.persistentContainer.viewContext)
            restaurant.name = nameTextField.text
            restaurant.type = typeTextField.text
            restaurant.location = locationTextField.text
            restaurant.phoneNumber = phoneTextField.text
            restaurant.isVisited = isVisited
            if let restaurantImage = photoImageView.image {
                //get the data of a specified image in PNG format
                if let imageData = UIImagePNGRepresentation(restaurantImage) {
                    //convert it to an NSData object
                    restaurant.image = NSData(data: imageData)
                }
            }
            print("Saving data to context ...")
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func toggleBeenHereButton(sender: UIButton) {
        // Yes button clicked
        if sender == yesButton {
            isVisited = true
            
            // Change the backgroundColor property of yesButton to red
            yesButton.backgroundColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
            
            // Change the backgroundColor property of noButton to gray
            noButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            
        } else if sender == noButton {
            isVisited = false
            
            // Change the backgroundColor property of yesButton to gray
            yesButton.backgroundColor = UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/255.0, alpha: 1.0)
            
            // Change the backgroundColor property of noButton to red
            noButton.backgroundColor = UIColor(red: 218.0/255.0, green: 100.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
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
