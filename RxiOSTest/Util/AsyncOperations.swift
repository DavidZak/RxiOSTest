//
//  AsyncOperations.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//
import UIKit

func doAfter(delayInSec seconds: Double, action: @escaping () -> Void) {
    let delayTime = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime) {
        action()
    }
}

func fg(block: @escaping (() -> Void)) {
    DispatchQueue.main.async {
        block()
    }
}

func bg(block: @escaping (() -> Void)) {
    DispatchQueue.global(qos: .background).async {
        block()
    }
}
