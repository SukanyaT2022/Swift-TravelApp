//
//  SignInViewController.swift
//  TravelApp
//
//  Created by Tiparpron Sukanya on 8/10/23.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
class SignInViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //crate sign in and sig up button
    
    @IBAction func signInButtonAction(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil{
                    print("Sign In Fail")
                }else{
                    //if sign in success in else it go to appDelegate-is a class maintain state
                    (UIApplication.shared.delegate as? AppDelegate)?.userID = authResult?.user.uid
                    //if success lig in then call loadhomescreen function
                    NetworkHelper().getToken { status in
                        if status == true{
                            self.loadHomeScreen()
                        }
                    }
                  
                }
            }
        }
            
    }
    //if sucess log in then call function loadhomescreen
    func loadHomeScreen(){
        //we create the home page becuase we donot want to go back to homepage to login page directly-we make this for this root
        DispatchQueue.main.async {
            let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
            let keyWindow = UIApplication.shared.windows.first{$0.isKeyWindow}
            keyWindow?.rootViewController = tabBarViewController
            keyWindow?.makeKeyAndVisible()
        }
       
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
    }
    
}
