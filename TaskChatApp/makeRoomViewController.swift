//
//  makeRoomViewController.swift
//  TaskChatApp
//
//  Created by 卓馬純之介 on 2022/11/13.
//

import UIKit
import Firebase

class makeRoomViewController: UIViewController {
    
    @IBOutlet weak var roomNameTextfield: UITextField!
    @IBOutlet weak var roomNumberTextfield: UITextField!
    
    let db = Firebase.Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func tappedAddButton(_sender:Any){
        let addDate = [
            "roomName": roomNameTextfield.text!,
            "roomNumber": roomNumberTextfield.text!
        ]
        db.collection("groups")
            .addDocument(data: addDate){err in
                
                if let error = err {
                    print("保存に失敗しました：\(error)")
                }
            }
        self.navigationController?.popViewController(animated: true)
        
    }
}
