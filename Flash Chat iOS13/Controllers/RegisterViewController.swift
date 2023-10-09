//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
class RegisterViewController: UIViewController, UINavigationControllerDelegate{
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var dp: UIImageView!
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            //            emailTextfield.delegate = self
            //            passwordTextfield.delegate = self
            emailTextfield.autocapitalizationType = .none
            emailTextfield.autocorrectionType = .no
            passwordTextfield.autocapitalizationType = .none
            passwordTextfield.autocorrectionType = .no
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                    func alertUserRegister(){
                        let alert = UIAlertController(title: "error", message: "enter proper email or password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "dismiss", style: .cancel, handler: nil))
                        self.present(alert,animated: true)
                    }
                    alertUserRegister()
                }
                else {
                    self.performSegue(withIdentifier: k.registerSegue , sender: self)
                    
                }
                
            }
            
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        dp.isUserInteractionEnabled = true
        dp.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        print("dp is live")
        presentPhotoActionSheet()
    }
}


//chooose DP from delegate methods


extension RegisterViewController: UIImagePickerControllerDelegate{
    
    func presentPhotoActionSheet(){

        let actionSheet = UIAlertController(title: "dp", message: "select dp method", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        
        actionSheet.addAction(UIAlertAction(title: "take photo", style: .default, handler: {[weak self]_ in
            self?.presentCamera()
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "choose photo", style: .default, handler: {[weak self]_ in
            self?.presentPhotoPicker()
        }))
        
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
            guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage]as?UIImage else{
                return
            }
            self.dp.image = selectedImage
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        
        
    }
    
}
