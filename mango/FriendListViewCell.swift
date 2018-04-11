//
//  TableViewCell.swift
//  
//
//  Created by MACBOOK on 2018/4/11.
//

import UIKit

class FriendListViewCell: UITableViewCell {

    @IBOutlet weak var invitationLabel: UILabel!
    
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
