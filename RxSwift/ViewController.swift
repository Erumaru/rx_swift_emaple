//
//  ViewController.swift
//  RxSwift
//
//  Created by erumaru on 11/27/19.
//  Copyright © 2019 kbtu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    let publishSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    var label: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publishSubject.subscribe { event in
            switch event {
            case .error(let error):
                print(error)
            case .next(let ok):
                print(ok)
            case .completed:
                print("finish")
            }
        }
        .disposed(by: disposeBag)
        
        publishSubject.bind(to: label.rx.text).disposed(by: disposeBag)
        
        publishSubject.on(.next("privet"))
        publishSubject.on(.error(RxSwiftError.random))
        publishSubject.on(.completed)
        
        
    }
}

enum RxSwiftError: Error {
    case random
}
