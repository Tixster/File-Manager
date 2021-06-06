//
//  SettingsViewController.swift
//  FileManage
//
//  Created by Кирилл Тила on 03.06.2021.
//

import UIKit


class SettingsViewController: UIViewController {


    @IBOutlet weak var sortSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortSwitch.isOn = UserDefaults.standard.bool(forKey: "sort")
    }
    
    @IBAction func sortSet(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "sort")
    }
    

    
}
