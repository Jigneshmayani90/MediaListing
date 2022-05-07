//
//  MediaListVC.swift
//  MediaListing
//
//  Created by Rahul Mayani on 25/03/21.
//

import UIKit

class MediaListVC: BaseVC {
    // MARK: - IBOutlet -
    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: - Variable -
    // interaction between view and model by listing view model
    public let listingVM = ListingVM()
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind table view with rxswift
        bindTableViewData()
        selectTableViewData()
        deleteTableViewData()
        
        // pull To Refresh
        listingVM.refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        listTableView.addSubview(listingVM.refreshControl)
        
        // Get data from Server
        listingVM.getDataFromServer(true)
    }
    
    // MARK: - Others -
    @objc
    private func pullToRefresh() {
        listingVM.refreshControl.beginRefreshing()
        listingVM.getDataFromServer(false)
    }
}

// MARK: - UITableView -
extension MediaListVC {
        
    private func bindTableViewData() {
        
        listingVM.dataArray.bind(to: listTableView.rx.items(cellIdentifier: String(describing: MediaListCell.self), cellType: MediaListCell.self))
        {  (row, media, cell) in
            cell.data = media
        }.disposed(by: rxbag)
    }
    
    private func selectTableViewData() {
        
        listTableView.rx.modelSelected(MediaModel.self)
        .subscribe(onNext: { [weak self] (media) in
            guard let self = self else { return }
            let mediaDetailsController: MediaDetailsVC = self.storyboard!.loadViewController()
            mediaDetailsController.data = media
            mediaDetailsController.title = "\(media.mediaId ?? 0)"
            self.navigationController?.pushViewController(mediaDetailsController, animated: true)
        }).disposed(by: rxbag)
    }
    
    private func deleteTableViewData() {
        /*listTableView.rx.itemDeleted
        .subscribe(onNext: { [weak self] (indexPath) in
            guard let self = self else { return }
            self.listingVM.removeItem(at: indexPath)
            self.listTableView.deleteRows(at: [indexPath], with: .bottom)
        }).disposed(by: rxbag)
        */
        listTableView.rx.modelDeleted(MediaModel.self)
        .subscribe(onNext: { [weak self]  (media) in
            guard let self = self else { return }
            /*let index = indexPath
            self.listingVM.removeItem(at: indexPath)
            self.listTableView.deleteRows(at: [indexPath], with: .bottom)*/
            /*
            if let selectedRowIndexPath = self.listTableView.indexPathForSelectedRow {
                self.listTableView.deselectRow(at: selectedRowIndexPath, animated: true)
            }*/
            self.listingVM.deleteItem(media)
        }).disposed(by: rxbag)
    }
}
