//
//  LoginViewController.swift
//  FileManage
//
//  Created by Кирилл Тила on 03.06.2021.
//

import UIKit
import KeychainAccess

class LoginViewController: UIViewController {
    private let keychain = KeychainConfig.keychan
    private var retry = false
    private var check = ""
    var closure: ((String) -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkProfileButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func checkProfile(_ sender: UIButton) {
        titleLabel.text = "Авторизация"
        loginButton.titleLabel?.text = "Войти"
        sender.isHidden = true
        
    }
    
    @IBAction func login(_ sender: Any) {
        guard let login = loginTextField.text, let password = passwordTextField.text else {return}
        let vc = self.storyboard?.instantiateViewController(identifier: "tabBar")
    
        if !checkProfileButton.isHidden {
            guard password.count > 4 else {
                alertCountPassword()
                passwordTextField.text = nil
                return }
            guard retry else {
                checkProfileButton.isHidden = false
                checkProfileButton.titleLabel?.text = "Введите пароль ещё раз"
                checkProfileButton.tintColor = .red
                passwordTextField.text = nil
                retry.toggle()
                check = password
                return
            }
            guard check == password else {
                alertPasswordCheck()
                return }
            
            try? keychain.set(password, key: login)
            self.navigationController?.pushViewController(vc!, animated: true)
            closure?(login)
            check = ""
            retry.toggle()
            
        } else {
  
            let token = try? keychain.get(login)
            if token == password {
                self.closure?(login)
            self.navigationController?.pushViewController(vc!, animated: true)

            } else {
                alertPasswordCheck()
            }
        }
    }
    
    private func alertCountPassword(){
        let alert = UIAlertController(title: "Пароль", message: "Пароль должен содержать больше 4 символов", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func alertPasswordCheck(){
        let alert = UIAlertController(title: "Пароль", message: "Пароли не совпадают", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
