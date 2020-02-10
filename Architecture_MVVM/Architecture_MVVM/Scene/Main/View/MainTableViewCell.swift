//
//  MainTableViewCell.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/07.
//  Copyright © 2020 shAhn. All rights reserved.
//

import UIKit
import Kingfisher

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var imgThumb: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblDesc: UILabel!

    public func configureWith(_ comic: Comic) {
        
      lblTitle.text = comic.title
      lblDesc.text = comic.description ?? "No description available"

      imgThumb.kf.setImage(with: comic.thumbnail.url,
                           options: [.transition(.fade(0.05))])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
