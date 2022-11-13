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
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
