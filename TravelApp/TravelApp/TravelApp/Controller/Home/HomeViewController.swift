//
//  Home.swift
//  TravelApp
//
//  Created by Tiparpron Sukanya on 8/16/23.
//

import Foundation
import UIKit
class HomeViewController: UIViewController{
    
    @IBOutlet weak var secmentControl: UISegmentedControl!
    
    @IBOutlet weak var submitButton: UIButton!
    
var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        selectedIndex = sender.selectedSegmentIndex
    }
    
    @IBAction func submitButtonAction(_ sender: Any) {
        switch selectedIndex {
        case 0:
            self.performSegue(withIdentifier: "flightNav", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "hotelNav", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "activityNav", sender: nil)
        default:
            self.performSegue(withIdentifier: "flightNav", sender: nil)
        }
    }
}
