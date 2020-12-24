//
//  NotificationsTableViewCell.swift
//  Sos
//
//  Created by mohammad ahmad on 12/21/20.
//

import UIKit

class NotificationsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setLabel(title: String){
        titleLabel.text=title
    }

}
