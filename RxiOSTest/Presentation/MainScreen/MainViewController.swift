//
//  MainViewController.swift
//  RxiOSTest
//
//  Created by David Zakharyan on 10.02.2020.
//  Copyright © 2020 David Zakharyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController<Void> {
    
    private var mainPresenter: MainPresenter {
        return presenter as! MainPresenter
    }
    
    @IBOutlet weak var tableViewCards: UITableView!
    
    let searchController = UISearchController()
    
    override func onAfterBinding() {
        configureSearchBar()
        
        dispose(mainPresenter.cards.bind(to: tableViewCards.rx.items(cellIdentifier: "CardTableCell", cellType: CardTableCell.self)) { row, data, cell in
            cell.bind(data: data)
        })
        
        dispose(tableViewCards.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.mainPresenter.goToCardDetail(at: indexPath.row)
        }))
        
        dispose(searchController.searchBar.rx.text.asDriver()
            .map { $0 ?? "" }
            .debounce(.milliseconds(500)) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .filter { !$0.isEmpty }
            .drive(onNext: { [weak self] query in
                self?.mainPresenter.loadCards(query: query)
            })
        )
    }
    
    func configureSearchBar() {
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search_placeholder".localized
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}
