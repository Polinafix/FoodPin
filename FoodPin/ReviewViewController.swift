//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Polina Fiksson on 02/03/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    
    var restaurant: RestaurantMO!

    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // Applying a Blurring Effect to the Background Image
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        //set the initial state of the container view:
       // containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        //containerView.transform = CGAffineTransform.init(translationX: 0, y: -1000)
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform
        reviewImage.image = UIImage(data: restaurant.image as! Data)
        backgroundImageView.image = UIImage(data: restaurant.image as! Data)
        
        closeButton.transform = CGAffineTransform.init(translationX: 1000, y: 0)
    }
    //create the growing effect
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
           // define the final state of the dialog view
            self.containerView.transform = CGAffineTransform.identity
        })
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            
            self.closeButton.transform = CGAffineTransform.identity
            
        }, completion: nil)
      
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
