//
//  FKImageView.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class KFImageView : UIImageView {
    let url = PublishSubject<String?>()
    let picture = PublishSubject<UIImage?>()
    let isFilled = PublishSubject<Bool>()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        defaultImage = image
        
        disposeBag.addDisposable(url.subscribe(onNext: { [weak self] url in
            self?.setImage(url: url)
        }))
        
        disposeBag.addDisposable(picture.subscribe(onNext: { [weak self] picture in
            self?.setImage(image: picture)
        }))
    }
    
    func setImage(url: String?, _ withDomainUrl: Bool = false) {
        kf.cancelDownloadTask()
        
        guard let `url` = url else {
            image = defaultImage
            isFilled.onNext(false)
            return
        }
        
        if let path = URL(string: Constants.domainUrl + url), withDomainUrl {
            kf.setImage(with: path, placeholder: defaultImage) { [weak self] image, error, cacheType, url in
                self?.isFilled.onNext(image != nil)
            }
        } else if let path = URL(string: url), !withDomainUrl {
            kf.setImage(with: path, placeholder: defaultImage) { [weak self] image, error, cacheType, url in
                self?.isFilled.onNext(image != nil)
            }
        } else {
            image = defaultImage
            isFilled.onNext(false)
        }
    }
    
    func setImage(path: String?) {
        kf.cancelDownloadTask()
        
        guard let `path` = path else {
            image = defaultImage
            isFilled.onNext(false)
            return
        }
        
        kf.setImage(with: URL(fileURLWithPath: path, isDirectory: true), placeholder: defaultImage) { [weak self] image, error, cacheType, url in
            self?.isFilled.onNext(image != nil)
        }
    }
    
    func setImage(image: UIImage?) {
        if let `image` = image {
            self.image = image
            isFilled.onNext(true)
        } else {
            self.image = defaultImage
            isFilled.onNext(false)
        }
    }
    
    private var defaultImage: UIImage?
    private lazy var disposeBag = DisposeBag()
}
