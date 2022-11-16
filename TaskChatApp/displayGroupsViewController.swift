//
//  displayGroupsViewController.swift
//  TaskChatApp
//
//  Created by 卓馬純之介 on 2022/11/13.
//

import UIKit
import Firebase
import FirebaseFirestore
import AudioToolbox

class displayGroupsViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var tableViewCell:UITableViewCell!
    
    let db = Firebase.Firestore.firestore()
    var addresses:[[String:String]]=[]
    
    var viewWidth: CGFloat!
    var viewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated : Bool){
        super.viewWillAppear(animated)
        
        viewWidth = view.frame.width
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        
    }
}
    extension displayGroupsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addresses.count
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


