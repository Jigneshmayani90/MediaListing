//
//  MediaDetailsVC.swift
//  MediaListing
//
//  Created by Rahul Mayani on 25/03/21.
//

import UIKit
import WebKit

class MediaDetailsVC: BaseVC {

    // MARK: - IBOutlet -
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mediaURLLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Variable -
    var data: MediaModel?
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set datasource
        titleLabel.text = data?.mediaTitleCustom ?? ""
        dateLabel.text = data?.mediaDate.dateString.date(AppDateFormat.dateandtime)?.string(dateFormate: AppDateFormat.date)
        mediaURLLabel.text = data?.mediaUrl ?? ""
        
        // PDF View by Webkit
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Loader.startLoaderToAnimating(false)
        if let url = URL(string: data?.mediaUrl ?? "") {
            /*if let type = AppWebFiles(rawValue: url.pathExtension.lowercased()), type == .pdf, let data = try? Data(contentsOf: url) {
               webView.load(data, mimeType: type.mimeType, characterEncodingName: "", baseURL: url)
               DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                   Loader.stopLoaderToAnimating()
               }
            } else {*/
                let request = URLRequest(url: url)
                webView.load(request)
            //}
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Loader.stopLoaderToAnimating()
    }
}

// MARK: - WebKit delegate -
extension MediaDetailsVC: WKUIDelegate, WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Loader.startLoaderToAnimating(false)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        Loader.stopLoaderToAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Loader.stopLoaderToAnimating()
    }
}
