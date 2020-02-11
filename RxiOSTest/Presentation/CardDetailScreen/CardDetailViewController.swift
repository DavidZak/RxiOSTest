//
//  CardDetailViewController.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 11.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit
import RxSwift

class CardDetailViewController: BaseViewController<Void> {
    
    private var cardDetailPresenter: CardDetailPresenter {
        return presenter as! CardDetailPresenter
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var imageCard: KFImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelIllustrator: UILabel!
    
    override func onAfterBinding() {
        dispose(doneButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.cardDetailPresenter.pop()
        }))
        
        dispose(cardDetailPresenter.title.drive(labelTitle.rx.text))
        dispose(cardDetailPresenter.description.drive(labelDescription.rx.text))
        dispose(cardDetailPresenter.artist.drive(labelIllustrator.rx.text))
        dispose(cardDetailPresenter.image.drive(imageCard.url))
    }
    
}
