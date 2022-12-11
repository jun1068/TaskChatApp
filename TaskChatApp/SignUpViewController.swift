//
//  SignUpViewController.swift
//  TaskChatApp
//
//  Created by 卓馬純之介 on 2022/11/13.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var UserNameTextField: UITextField!
    @IBOutlet var PassWordTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func createUser(emailText:String,passwordtext:String){
        Auth.auth().createUser(withEmail:emailText,password: passwordtext){FIRAuthDateResult,Error in
            guard let authResult = FIRAuthDateResult else {
                print("error,SignUp")
                return
        }
        let addData = [
            "userName": self.UserNameTextField.text!
        ]
        let db = Firestore.firestore()
        db.collection("users")
            .document(authResult.user.uid)
            .setData(addData)
            
            let chatboard: UIStoryboard = UIStoryboard(name:"ChatListStoryboard",bundle: nil)
            
            let makeRoomViewController = chatboard.instantiateViewController(withIdentifier: "makeRoomViewController")
            
            self.present(makeRoomViewController, animated: true)
        }
    }
    @IBAction func SignUpButton(){
        createUser(emailText: EmailTextField.text!, passwordtext:PassWordTextField.text! )
        
    }
    
    
}

