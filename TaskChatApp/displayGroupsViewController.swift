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
    var data: [[String : String]] = []
    
    var viewWidth: CGFloat! //viewの横幅
    var viewHeight: CGFloat! //viewの縦幅
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: セルの登録
        tableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWidth = view.frame.width
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        self.fetchData()
    }
    
    private func fetchData(){
        data.removeAll()
        db.collection("groups")
            .getDocuments {querySnapshot, error in
                guard let snapshot = querySnapshot else {return}
                snapshot.documentChanges.forEach{ diff in
                    let roomName = diff.document.data()["roomName"]as! String
                    let roomId = diff.document.data()["roomNumber"]as! String
                    
                    self.data.append(["roomName":roomName,"roomId":roomId])
                }
                self.tableView.reloadData()
            }
       
    }
}

extension displayGroupsViewController: UITableViewDelegate,UITableViewDataSource{
    //extentionは一つづつ
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! GroupsTableViewCell
        //MARK: 追加する
        cell.label.text = data[indexPath.row]["roomName"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatboard = UIStoryboard(name: "ChatStoryboard", bundle: nil).instantiateViewController(withIdentifier: "chatboard")
        
        //        let toChatboard = chatboard.instantiateViewController(withIdentifier: "NavigationController")
        //
        //        toChatboard.modalPresentationStyle = .fullScreen
        //        self.present(toChatboard, animated: true)
        navigationController?.pushViewController(chatboard, animated: true)
    }
}

