//
//  ViewController.swift
//  Lesson2
//
//  Created by Mac on 2017/9/15.
//  Copyright © 2017年 LiYou. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var clickButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    fileprivate let disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clickButton.rx.tap.flatMapLatest { [weak self] _ in
            return UIImagePickerController.rx.createWithParent(self) { picker in
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
            }.flatMap {
                $0.rx.didFinishPickingMediaWithInfo
            }.take(1)
            
        }.map({
            info in
            return info[UIImagePickerControllerOriginalImage] as? UIImage
        }).subscribe(onNext: { [weak self] (image) in
            guard let this = self else {
                return
            }
            guard let image = image else {
                return
            }
            let textAttachment = NSTextAttachment()
            let scaleFactor = image.size.width / (this.textView.frame.size.width - 10);
            guard let cgImage = image.cgImage else {
                return
            }
            textAttachment.image = UIImage(cgImage: cgImage, scale: scaleFactor, orientation: .up)
            let attString = NSAttributedString(attachment: textAttachment)
            this.textView.textStorage.insert(attString, at: this.textView.selectedRange.location)
            
        }, onError: { (error) in
            print(error)
        }).addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

