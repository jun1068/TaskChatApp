//
//  LoginViewController.swift
//  TaskApp
//
//  Created by 卓馬純之介 on 2022/10/30.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage




class LoginViewController: UIViewController {
    
    @IBOutlet weak var EmailTextField:UITextField!
    @IBOutlet weak var PassWordTextField:UITextField!
    
    let auth = Auth.auth()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func tappedLoginButton(_sender:Any){
        signInUser(emailText:EmailTextField.text!,passwordText:PassWordTextField.text!)
    }
    func signInUser(emailText:String,passwordText:String){
        auth.signIn(withEmail:emailText,password:passwordText){AuthDataResult,Error in
            if let err = Error{
                print("error:\(err)")
                
            }
        }
        
        func transition(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabView = storyboard.instantiateViewController(withIdentifier: "tab") as! UITabBarController
            tabView.selectedIndex = 0
            self.present(tabView, animated: true, completion: nil)
            
            let chatboard = UIStoryboard(name:"ChatListStoryboard", bundle: nil)
            
            let makeRoomViewController = chatboard.instantiateViewController(withIdentifier: "makeRoomViewController")
            
            self.present(makeRoomViewController, animated: true)
        }
        }
    }

