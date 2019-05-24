//
//  SliderViewController.swift
//  LastMusic
//
//  Created by Jerry Zhou on 5/24/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countSlider: UISlider!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
   
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        let name = nameTextField.text!
        if !name.isEmpty {
            // save name
            UserDefaults.standard.set(name, forKey: Constants.Keys.name.rawValue)
            print("name to be saved: ", name)
        }
    }
    
    @IBAction func sliderBarChanged(_ sender: UISlider) {
        let count = Int(sender.value)
        UserDefaults.standard.set(count, forKey: Constants.Keys.count.rawValue)
        countLabel.text = "Artist Count: \(count)"
    }
    
    // helping function
    func setupView() {
        doneButton.layer.cornerRadius = 15
        
        // setup slider
        guard let count = UserDefaults.standard.value(forKey: Constants.Keys.count.rawValue) as? Int else {
            return
        }
        countSlider.value = Float(count)
        countLabel.text = "Artist Count: \(count)"
    }
    
    
    
} // end class
