//
//  displayGroupsViewController.swift
//  TaskChatApp
//
//  Created by 卓馬純之介 on 2022/11/13.
//


import UIKit
import Firebase
import FirebaseFirestore

class displayGroupsViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView:UITableView!
    
    let db = Firebase.Firestore.firestore()
    var addresses: [[String : String]] = []
    
    var viewWidth: CGFloat! //viewの横幅
    var viewHeight: CGFloat! //viewの縦幅
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWidth = view.frame.width
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        
    }
    func tableview(_ tableView:UITableView,numberOfRowsInSction senction: Int)->Int{
        return 10
    }
    
    
    
}
extension displayGroupsViewController: UITableViewDelegate,UITableViewDataSource{
    //extentionは一つづつ
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! GroupsTableViewCell
        return cell
    }
    
    //func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    //cell.layer.cornerRadius = 12
    //cell.layer.shadowOpacity = 0.25
    //cell.layer.shadowColor = UIColor.black.cgColor
    //cell.layer.shadowOffset = CGSize(width: 2, height: 3)
    //cell.layer.masksToBounds = false
    
    //return cell
    //}
    func tableView(_ collectionView: UITableView, indexPath: IndexPath) -> CGSize {
        
        let space: CGFloat = 36
        let cellWidth: CGFloat = viewWidth - space
        let cellHeight: CGFloat = 160
        
        
        db.collection("groups")
            .addSnapshotListener{ (querySnapshot, err) in
                guard let snapshot = querySnapshot else{
                    print(err!)
                    return
                }
                
                self.addresses.removeAll()
                
                for doc in snapshot.documents{
                    
                    let roomName = doc.data()["roomName"] as! String
                    
                    self.addresses.append(["roomName": roomName])
                    
                    self.tableView.reloadData()
                }
            }
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
