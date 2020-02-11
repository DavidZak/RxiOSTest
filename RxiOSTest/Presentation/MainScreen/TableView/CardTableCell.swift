//
//  CardTableCell.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit
import Kingfisher

final class CardTableCell: BaseTableCell<Card> {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var illustratorLabel: UILabel!
    @IBOutlet private weak var cardImage: KFImageView!
    
    override func bind(data: Card) {
        nameLabel.text = data.name
        descriptionLabel.text = data.oracleText
        illustratorLabel.text = String(format: "artist".localized, data.artist ?? "")
        cardImage.setImage(url: data.imageUris?.small)
    }
}
