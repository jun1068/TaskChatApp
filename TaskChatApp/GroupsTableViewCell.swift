//
//  GroupsTableViewCell.swift
//  TaskChatApp
//
//  Created by 卓馬純之介 on 2022/12/18.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.image = UIImage(systemName: "swift")
                label.text = "Swift"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
