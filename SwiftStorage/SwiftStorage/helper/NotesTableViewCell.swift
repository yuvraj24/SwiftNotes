//
//  NotesTableViewCell.swift
//  SwiftStorage
//
//  Created by new on 30/05/18.
//  Copyright © 2018 yuvraj. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet var imageNotes : UIImageView?
    @IBOutlet var contentNotes : UILabel?
    @IBOutlet var locationNotes : UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
