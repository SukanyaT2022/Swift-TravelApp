//
//  SignUpViewController.swift
//  TravelApp
//
//  Created by Tiparpron Sukanya on 8/10/23.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore

class  SignUpViewController:UIViewController{
    //step 1 connect out let above function
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //step 2 connect submit buuton action
    @IBAction func submitButtonAction(_ sender: Any) {
        createUser()
    }
    //step 3 user need to fill all info with fire base
    func createUser(){
        if let firstName = firstNameTextField.text,
           let lastName = lastNameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text{
            Auth.auth().createUser(withEmail:email, password:password) { authResult, error
                in
                if error != nil{
                    print("Sign Up Fail")
                }else{
                    //access to database firebase framwork
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["first": firstName, "last": lastName])
                    Database.database().reference().child("users").child((authResult?.user.uid)!).setValue(["userName": "\(firstName) \(lastName)"])
                    //above store firstname and last name in userName
                    //line below take to previois screen
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
        }
        
    }
}
