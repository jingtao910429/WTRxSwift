//
//  ViewController.swift
//  Lesson1
//
//  Created by Mac on 2017/9/14.
//  Copyright © 2017年 LiYou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    fileprivate var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer()
        longPress.rx.event.subscribe(onNext: { [weak self] (tap) in
            
            guard let `self` = self else {
                return
            }
            guard let text = self.showLabel.text else {
                return
            }
            guard let number = Int(text) else {
                return
            }
            self.showLabel.text = String(number + 1)
            
        }, onError: { (error) in
            print(error)
        }).addDisposableTo(disposeBag)
        self.tapButton.addGestureRecognizer(longPress)
        
        tapButton.rx.tap.subscribe({ [weak self] _ in
            guard let `self` = self else {
                return
            }
            guard let text = self.showLabel.text else {
                return
            }
            guard let number = Int(text) else {
                return
            }
            self.showLabel.text = String(number + 1)
            
        }).addDisposableTo(disposeBag)
        
        resetButton.rx.tap.subscribe({ [weak self] _ in
            guard let `self` = self else {
                return
            }
            self.showLabel.text = "0"
        }).addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

