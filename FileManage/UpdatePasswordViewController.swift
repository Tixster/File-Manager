//
//  UpdatePasswordViewController.swift
//  FileManage
//
//  Created by Кирилл Тила on 06.06.2021.
//

import UIKit
import KeychainAccess

class UpdatePasswordViewController: UIViewController {
    
    private let keychain = KeychainConfig.keychan
    private let login = Login.shared.getLogin()
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tapUpdate(_ sender: Any) {
        guard let password = passwordTF.text else { return }


        keychain[login] = nil
        try? keychain.set(password, key: login)
        passwordTF.text = nil
        alertPasswordUpdate()
        
    }
    
    private func alertPasswordUpdate(){
        
        let alert = UIAlertController(title: "Пароль", message: "Пароль для аккаунта \(login) пароль обновлён", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true)

    }
    
    
}
