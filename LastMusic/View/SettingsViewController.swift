//
//  SettingsViewController.swift
//  LastMusic
//
//  Created by mac on 5/21/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    @IBOutlet weak var settingsUserLabel: UILabel!
    @IBOutlet weak var settingsUserImage: UIImageView!
    
    
    let settings = "information"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let hash = UserDefaults.standard.value(forKey: Constants.Keys.hash.rawValue) as? String,
            let url = Utility.loadWithFileManager(hash),
            let image = UIImage(contentsOfFile: url.path) else {
                return
        }
        settingsUserImage.image = image
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let name = UserDefaults.standard.value(forKey: Constants.Keys.name.rawValue) as? String else {
            return
        }
        settingsUserLabel.text = name
        print("name shown: ", name)
    }
    
    //MARK: Touches Began
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if touch?.view == view.viewWithTag(3) {
            
            let imageController = UIImagePickerController()
            imageController.sourceType = .photoLibrary
            imageController.delegate = self
            present(imageController, animated: true, completion: nil)
            
        }
    }
    
    func setupSettings() {
        settingsTableView.tableFooterView = UIView(frame: .zero)
        settingsTableView.tableHeaderView = UIView(frame: .init())
    }


}

//MARK: TableView

extension SettingsViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier, for: indexPath) as! SettingsTableCell
        
        cell.config(with: settings)
        
        return cell
        
    }
    
    
    
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO:
        let storyboard = UIStoryboard(name: "Settings", bundle: Bundle.main)
        let infoVC = storyboard.instantiateViewController(withIdentifier: "InformationViewController") as! InformationViewController
        
        present(infoVC, animated: true, completion: nil)
    }
}


//MARK: UIPickerControllerDelegate

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
            let data = image.pngData() else {
            return
        }
        
        Utility.saveWithFileManager(data)
        
        let hash = String(data.hashValue)
        UserDefaults.standard.set(hash, forKey: Constants.Keys.hash.rawValue)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
