//
//  PostCell.swift
//  instagram
//
//  Created by Regie Daquioag on 2/25/18.
//  Copyright © 2018 Regie Daquioag. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var PostCellImage: UIImageView!
    @IBOutlet weak var PostCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
