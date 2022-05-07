//
//  ListingVM.swift
//  MediaListing
//
//  Created by Rahul Mayani on 25/03/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ListingVM {
    
    // MARK: - Variable -
    // listing data array observe by rxswift
    public var dataArray : BehaviorRelay<[MediaModel]> = BehaviorRelay(value: [])
        
    private let disposeBag = DisposeBag()
    
    public var refreshControl = UIRefreshControl()
    
    // MARK: - Init -
    init() {
        refreshControl.tintColor = R.color.blueColor()!
    }
    
    // MARK: - Removed item by swipe to delete action
    public func deleteItem(_ item: MediaModel) {
        var list = dataArray.value as [MediaModel]

        guard let index = list.firstIndex(of: item) else { return }
        
        // Remove the item at the specified indexPath
        list.remove(at: index)

        // Inform your subject with the new changes
        dataArray.accept(list)
    }
    /*
    public func removeItem(at indexPath: IndexPath) {
        var list = dataArray.value as [MediaModel]

        // Remove the item at the specified indexPath
        list.remove(at: indexPath.row)

        // Inform your subject with the new changes
        dataArray.accept(list)
    }*/
}

// MARK: - API -
extension ListingVM {
    // get data from server by rxswift with alamofire
    public func getDataFromServer(_ isLoading: Bool = false) {
        
        APIManager.shared.setURL(APIEndPoint.Name.mediaList)
        .showIndicator(isLoading)
        .setDeferredAsObservable()
        .subscribeConcurrentBackgroundToMainThreads()
        .subscribe(onNext: { [weak self] (response) in
            guard let self = self else { return }
            if let json = response as? [String: Any],
               let data = json["content"] as? [[String: Any]] {
                let list = data.map { (obj) -> MediaModel in
                    return MediaModel(fromDictionary: obj)
                }
                self.dataArray.accept(list)
            } else {
                UIAlertController.showAlert(title: nil, message: "Data not found!")
            }
            self.refreshControl.endRefreshing()
        }, onError: { [weak self] (error) in
            guard let self = self else { return }
            UIAlertController.showAlert(title: nil, message: error.localizedDescription)
            self.refreshControl.endRefreshing()
        }).disposed(by: disposeBag)
    }
}
