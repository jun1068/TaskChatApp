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


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewWidth = view.frame.width

        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        // Do any additional setup after loading the view.
//        tableView.register(UINib(nibName: "groupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")

    }

}

extension displayGroupsViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addresses.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.layer.cornerRadius = 12 //角丸
        cell.layer.shadowOpacity = 0.25 //影の濃さ
        cell.layer.shadowColor = UIColor.black.cgColor //影の色
        cell.layer.shadowOffset = CGSize(width: 2, height: 3) //影の方向
        cell.layer.masksToBounds = false

        return cell
    }
}
