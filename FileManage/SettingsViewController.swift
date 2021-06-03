//
//  SettingsViewController.swift
//  FileManage
//
//  Created by Кирилл Тила on 03.06.2021.
//

import UIKit
import KeychainAccess


class SettingsViewController: UIViewController {

    private let keychain = KeychainConfig.keychan
    private var login: String?

    @IBOutlet weak var sortSwitch: UISwitch!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortSwitch.isOn = UserDefaults.standard.bool(forKey: "sort")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? LoginViewController else { return }
        vc.closure = { [weak self] text in
            self?.login = text
        }
    }
    
    @IBAction func sortSet(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "sort")
    }
    
    
    @IBAction func updatePassword(_ sender: Any) {
        guard let password = passwordTF.text else { return }

        guard let login = login else { return }
        
        keychain[login] = nil
        try? keychain.set(password, key: login)
        alertPasswordUpdate()
        passwordTF.text = nil

    }
    
    private func alertPasswordUpdate(){
        guard let login = login else { return }
        let alert = UIAlertController(title: "Пароль", message: "Пароль для аккаунта \(login) пароль обновлён", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
