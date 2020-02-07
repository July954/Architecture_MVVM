//
//  MainViewController.swift
//  Architecture_MVVM
//
//  Created by adcapsule on 2020/02/05.
//  Copyright © 2020 shAhn. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxViewController
import ReactorKit

class MainViewController: BaseVC, StoryboardView, StoryboardBased {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func bindTableView(item: [Comic]) {
        let itemOb: Observable<[Comic]> = Observable.of(item)
        itemOb.bind(to: tableView.rx.items(cellIdentifier: "MainTableViewCell")) { (index, element, cell: MainTableViewCell) in
            cell.configureWith(element)
            
        }.disposed(by: disposeBag)
    }
    
    func bind(reactor: MainViewModel) {

        //API
        self.rx.viewDidAppear
            .map { _ in Reactor.Action.getMarvelAPI }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.reactor?.state.asObservable()
                  .map { $0.marvelAPIState }
                  .subscribe(onNext: { (state) in
                    switch state {
                    case .error :
                        Utilty.shared.print(output: "error")
                        break
                    case .loading:
                        Utilty.shared.print(output: "loading")
                        break
                    case .ready(let result):
                        self.bindTableView(item: result)
                        break
                    }
                  })
              .disposed(by: disposeBag)
        //API-End

    }
    

}
