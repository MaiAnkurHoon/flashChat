//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

      
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text ,  let password = passwordTextfield.text{
           
            emailTextfield.autocapitalizationType = .none
            emailTextfield.autocorrectionType = .no
            passwordTextfield.autocapitalizationType = .none
            passwordTextfield.autocorrectionType = .no
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if let e = error{
                    print(e.localizedDescription)
                    func alertLogin (){
                        
                        let alert = UIAlertController(title: "error", message: "enter password and email correctly", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
                        self.present(alert,animated: true)
                    }
                }
                else{
                    self.performSegue(withIdentifier: k.loginSegue, sender: self)
                }
                
            }
        }
    }
    
}
