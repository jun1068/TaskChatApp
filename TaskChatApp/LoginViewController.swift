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
    
    let uid = Auth.auth().currentUser?.uid
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func tappedLoginButton(_sender:Any){
        signInUser(emailText:EmailTextField.text!,passwordText:PassWordTextField.text!)
    }
    //    func signInUser(emailText:String,passwordText:String){
    //        auth.signIn(withEmail:emailText,password:passwordText){AuthDataResult,Error in
    //            if let err = Error{
    //                print("error:\(err)")
    //
    //            }
    //            self.transition()
    //        }
    func signInUser(emailText:String,passwordText:String){
        //FIXME: modify screen transition pattern.
        auth.signIn(withEmail:emailText,password:passwordText){AuthDataResult,Error in
            if let err = Error{
                print("error:\(err)")
                
            }else{
                self.transition()
            }
        }
    }
    
    func transition(){
        let chatboard = UIStoryboard(name:"ChatListStoryboard", bundle: nil)
        
        let toDisplayGroups = chatboard.instantiateViewController(withIdentifier: "NavigationController")
        toDisplayGroups.modalPresentationStyle = .fullScreen
        self.present(toDisplayGroups, animated: true)
    }
}



