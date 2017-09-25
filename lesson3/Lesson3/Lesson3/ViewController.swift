//
//  ViewController.swift
//  Lesson3
//
//  Created by Mac on 2017/9/15.
//  Copyright © 2017年 LiYou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var disposeBag = DisposeBag()
    fileprivate var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Variable([
            "Mike",
            "Apples",
            "Ham",
            "Eggs"
            ])
        let itmes2 = [
            "Fish",
            "Carrots",
            "Mike",
            "Apples",
            "Ham",
            "Eggs",
            "Bread",
            "Chiken",
            "Water"
        ]
        
        items.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self), curriedArgument: { (row, element, cell) in
                cell.textLabel?.text = element
            }).disposed(by: disposeBag)
        refreshControl.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { _ in
                items.value = itmes2
                self.refreshControl.endRefreshing()
            }).addDisposableTo(disposeBag)
        tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

