//
//  NewsDetailsVC.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/31/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import UIKit

class NewsDetailsVC: UIViewController , UIWebViewDelegate , WKNavigationDelegate  {
    // outlets -------------------
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var sponsorFirstView: UIView!
    @IBOutlet var bannerSliderHeightConstraint: NSLayoutConstraint!
    @IBOutlet var webViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageViewConstraint: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var indLoader: UIActivityIndicatorView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsWriterTxt: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var scrollContent: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var commentsBtn: UIButton!
    @IBOutlet var sponser: TappableSponsorImageView!
    @IBOutlet weak var webViewSubView: UIView!
    @IBOutlet var bannersSliderView: UIView!
    @IBOutlet var wkWebSubView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var articleInfoView: UIView!
    @IBOutlet weak var sponsorFirstImgHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet var scrollContentHeightConstraint: NSLayoutConstraint!
    @IBOutlet var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var sponsorImgHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topimageView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var writerImageView: UIImageView!
    @IBOutlet weak var topScrollContentConstraint: NSLayoutConstraint!
    //--------------------------------
    
    // objects and props
    var adsview: UIView?
    var bannerView: DFPBannerView?
    var teadsInRead: TeadsAd?
    var plusButtonsViewNavBar: LGPlusButtonsView?
    var authors : NSArray = []
    var orginalNewsList: NSMutableArray!
    var relatedNewsList: NSMutableArray!
    var relatedVideosList: NSMutableArray!
    var sectionsList: NSMutableArray!
    var currentRelatedList = 0
    var newsItem: NewsItem?
    var canLoadMore = false
    var fontSize : Int32 =  30
    var currentNewsIndex = 0
    var appDelegate : AppDelegate!
    var webViewHeight: CGFloat = 0
    var arrMinMax : NSMutableArray!;
    var appInfo: AppInfo? = nil
    let Screenheight = UIScreen.main.bounds.size.height
    let Screenwidth = UIScreen.main.bounds.size.width
    var id : Int = 0
    var pageIndex = 0
    var isFromPushNotification = false
    var isFromNewsWidget = false
    var refreshControl: UIRefreshControl?
    var relatedNewscurrentIndex = 0
    var relatedVideosCurrentIndex = 0
    var pageController: UIPageViewController?
    var webView: WKWebView?
    var postquareWebView: WKWebView?
    var postQuareUrlStr: String?
    var textColor: String!
    var bgcolor: UIColor?
    var viewModel : NewsDeatilsVM!
    //------------------------------------
    
    //     func observeValueForKeyPath(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    //        //  NSLog(@"%f",webViewHeight);
    //        if (object as? UIScrollView) == webView?.scrollView  {
    //            // we are here because the contentSize of the WebView's scrollview changed.
    //            let scrollView = webView?.scrollView
    //            webViewHeight = (webView?.scrollView.contentSize.height)!
    //            webViewHeightConstraint.constant = CGFloat(webViewHeight)
    //            view.updateConstraints()
    //            //  NSLog(@"New contentSize: %f x %f", scrollView.contentSize.width, scrollView.contentSize.height);
    //        }
    //    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
        sectionsList = NSMutableArray()
        relatedVideosList = NSMutableArray()
        relatedNewsList = NSMutableArray()
        appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        UIApplication.shared.isStatusBarHidden = false
       // self.commentsBtn.isHidden = true;
        self.currentRelatedList=1;
        bgcolor = Global.getInstance().bgcolor
        textColor = Global.getInstance().textColor
        fontSize = Global.getInstance().fontSize
        appInfo = Global.getInstance().appInfo
        tableView.tableHeaderView?.backgroundColor = UIColor.clear
        articleInfoView.layer.cornerRadius = 5
        articleInfoView.clipsToBounds = true
        appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        appDelegate.isFullScreen = false
        self.sponsorFirstImgHeightConstraint.constant = 280 ;
        loadPostQuareRequest()
        setupWKWebView()
        self.webView!.scrollView.scrollsToTop = false;
        webView?.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        newsTitleLabel.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        appDelegate.application(UIApplication.shared, supportedInterfaceOrientationsFor: appDelegate.window)
       
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bgcolor = Global.getInstance().bgcolor
        changeFont(view)
        UIDevice.current.setValue(NSNumber(value: UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        let moreBtn = UIButton(type: .custom)
        moreBtn.setBackgroundImage(UIImage(named: "Detailsmore"), for: .normal)
        moreBtn.bounds = CGRect(x: Int(Screenwidth) - 170, y: 0, width: 16, height: 18)
        if parent != nil {
            parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreBtn)
        }
        viewModel = NewsDeatilsVM(_serviceAdapter: NetworkAdapter<NewsServiceEnum>() , _id: String(id))
               viewModel.delegate = self
    }
    func addBlackOverlayOnArticleImage()
    {
        let overlay = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(Screenwidth), height: topimageView.frame.size.height))
        overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        topimageView.addSubview(overlay)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //  NSLog(@"%f",webViewHeight);
        if (object as? UIScrollView) == webView?.scrollView && keyPath?.isEqual("contentSize") ?? false && (webView?.scrollView.contentSize.height ?? 0.0) > webViewHeight && webViewHeight != 0 {
            // we are here because the contentSize of the WebView's scrollview changed.
            let scrollView = webView?.scrollView
            webViewHeight = (webView?.scrollView.contentSize.height)!
            webViewHeightConstraint.constant = webViewHeight
            view.updateConstraints()
            //  NSLog(@"New contentSize: %f x %f", scrollView.contentSize.width, scrollView.contentSize.height);
        }
    }
    // webview config
    func setupWKWebView() {
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: webViewSubView.frame.size.width, height: 100))
        webView?.isOpaque = false
        webView?.scrollView.isScrollEnabled = false
        webView?.backgroundColor = UIColor.clear
        webView?.tintColor = UIColor(red: 0.94, green: 0.64, blue: 0.02, alpha: 1.0)
        webView?.navigationDelegate = self
        webView?.scrollView.bounces = true
        let containerWebVIew = webViewSubView
        let subview = webView
        webView!.translatesAutoresizingMaskIntoConstraints = false
        if let subview = subview {
            containerWebVIew?.addSubview(subview)
        }
        containerWebVIew?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: [], metrics: nil, views: [
            "subview" : subview
        ]))
        
        containerWebVIew?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: [], metrics: nil, views: [
            "subview" : subview
        ]))
        
        // self.webView.autoresizingMask =UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        webView?.contentMode = UIView.ContentMode.scaleToFill
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if(webView.tag==123456)
        {
            decisionHandler(.cancel)
        }
        else
        {
            decisionHandler(.allow);
            
        }
    }
    func webView(_ aWebView: WKWebView, didFinish aNavigation: WKNavigation!) {
        if aWebView.tag == 123456 {
            return
        }
        if aWebView.tag == 4444 {
            aWebView.stopLoading()
            return
        }
        aWebView.evaluateJavaScript("document.body.scrollHeight;", completionHandler: { result, error in
            if result != nil {
                
                aWebView.sizeToFit()
                AFNetworkActivityIndicatorManager.shared().isEnabled = false
                self.webViewHeightConstraint.constant = self.webViewHeight
                self.activityIndicator.stopAnimating()
                self.view.updateConstraintsIfNeeded()
                self.tableView.updateConstraintsIfNeeded()
            }
        })
    }
    func changeFont(_ view: UIView?) {
        for View in view?.subviews ?? [] {
            if (View is UILabel) {
                let lbl = View as? UILabel
                lbl?.font = UIFont(name: "DINNextLTW23Regular", size: lbl?.font.pointSize ?? 0.0)
            }
            if (View is UIButton) {
                let lbl = View as? UIButton
                lbl?.titleLabel?.font = UIFont(name: "DINNextLTW23Regular", size: lbl?.titleLabel?.font.pointSize ?? 0.0)
            }
            if (View is UIView) {
                changeFont(View as? UIView)
            }
        }
    }
    func loadHtmlStringToWKWebView() {
        var strBody = ""
        let strCssHead = """
            <head>\
            <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=0.8">\
            <script src=http://platform.twitter.com/widgets.js> </script> <script src=http://platform.instagram.com/en_US/embeds.js></script>\
            <link rel="stylesheet" type="text/css" href="iPhone.css">\
            <link href="http://api.filgoal.com/assets/dist/css/lightslider/css/lightslider.min.css" rel="stylesheet" />\
             <link href="http://api.filgoal.com/assets/dist/css/style.min.css" rel="stylesheet" />\
            </head>
            """
        if textColor!.isEqual("white") {
            strBody = String(format: "<style>body { background-color: trasparent; font-size:%ipx; color: %@; margin:0; font-family:\"%@\"} a { color: #f0a306; }img{width:100%%; height:auto}iFrame{ width : 100%%}</style><body><div id='content' dir='rtl' name='content'>%@</div><script src=\"http://api.filgoal.com/assets/dist/js/custom.min.js\"></script></body>", fontSize, textColor, "DINNextLTW23Regular", viewModel.newsDeatilsData.newsDescription)
        } else {
            strBody = String(format: "<style>body { background-color: trasparent; font-size:%ipx; color: %@; margin:0; font-family:\"%@\"} a { color: #f0a306; }img{width:100%%; height:auto}iFrame{ width : 100%%}</style><body><div id='content' dir='rtl' name='content'>%@</div><script src=\"http://api.filgoal.com/assets/dist/js/custom.min.js\"></script></body>", fontSize, UIColor.black, "DINNextLTW23Regular", viewModel.newsDeatilsData.newsDescription)
        }
        self.webView?.tintColor = UIColor(red: 0.94, green: 0.64, blue: 0.02, alpha: 1.0)
        webViewHeight = 100
        webViewHeightConstraint.constant = 100
        webView?.loadHTMLString("\(strCssHead)\(strBody)", baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "iPhone", ofType: "css")!))
        
    }
    func loadViewsFromNewsItem(withRelatedList: Int) {
        activityIndicator.startAnimating()
        newsDateLabel.font = UIFont(name: "DINNextLTW23Regular", size: newsDateLabel.font.pointSize)
        newsWriterTxt.font = UIFont(name: "DINNextLTW23Regular", size: newsWriterTxt.font!.pointSize)
        currentRelatedList = withRelatedList
        newsTitleLabel.text = "\u{200F}\(viewModel.newsDeatilsData.newsTitle)"
        
        newsDateLabel.text = viewModel.newsDeatilsData.sourceDate!
        viewModel.newsDeatilsData.newsDescription = viewModel.newsDeatilsData.newsDescription.replacingOccurrences(of: "\"//www.youtube.com", with: "\"http://www.youtube.com")
        let prefs = webView?.configuration.preferences
        prefs?.javaScriptEnabled = true
        // prefs.minimumFontSize=self.fontSize;
        if let prefs = prefs {
            webView?.configuration.preferences = prefs
        }
        
        loadHtmlStringToWKWebView()
        
        if viewModel.newsDeatilsData.images != nil && viewModel.newsDeatilsData.images.count > 0 {
            let imageItem = viewModel.newsDeatilsData.images[0]
            newsImageView.sd_setImage(with: URL(string: imageItem.large ?? ""), placeholderImage: UIImage(named: "place_holder_main_article_img.jpg"), completed: { image, error, cacheType, imageURL in
                
            })
        }
    }
    // ----------------------
    // posts
    func loadPostQuareRequest() {
        if postQuareUrlStr != nil && !(postQuareUrlStr == "") {
            postquareWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
            postquareWebView!.tag = 4444
            postquareWebView!.navigationDelegate = self
            if let url = URL(string: "http:\(postQuareUrlStr)") {
                postquareWebView!.load(URLRequest(url: url))
            }
        }
    }
    // --------------------
    // Authorss
    func setAuthorsLbl() {
        authors = getAuthorsNameString()!.components(separatedBy: ",") as NSArray
        newsWriterTxt.text = "بقلم / \(getAuthorsNameString() ?? "")"
        arrMinMax = NSMutableArray()
        var count = 0
        for i in 0..<authors.count {
            let str = authors[i] as? String
            let length = count + (str?.count ?? 0) - 1
            var tempdic: [AnyHashable : Any] = [:]
            tempdic["MinValue"] = NSNumber(value: UInt(count))
            tempdic["MaxValue"] = NSNumber(value: UInt(length == -1 ? 1 : length))
            arrMinMax.add(tempdic)
            count = length + 1
        }
        let lblTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(inAuthorLbl:)))
        newsWriterTxt.addGestureRecognizer(lblTapRecognizer)
        newsWriterTxt.isUserInteractionEnabled = true
        lblTapRecognizer.cancelsTouchesInView = false
    }
    
    @objc func handleTap(inAuthorLbl tapRecognizer: UITapGestureRecognizer?) {
        var characterIndex: Int
        let layoutManager = newsWriterTxt.layoutManager
        let location = tapRecognizer?.location(in: newsWriterTxt)
        characterIndex = (layoutManager.characterIndex(for: location ?? CGPoint.zero, in: newsWriterTxt.textContainer, fractionOfDistanceBetweenInsertionPoints: nil) ?? 0) - 8
        
        for j in 0..<arrMinMax.count {
            if characterIndex >= ((arrMinMax[j] as? [AnyHashable : Any])?["MinValue"] as? NSNumber)?.intValue ?? 0 && characterIndex <= ((arrMinMax[j] as? [AnyHashable : Any])?["MaxValue"] as? NSNumber)?.intValue ?? 0 {
                let authorObj = viewModel.newsDeatilsData.authors[j] as? Author
                if authorObj?.idField != 0 {
                    let profileView = AuthorProfileViewController()
                    profileView.author = authorObj
                    navigationController?.pushViewController(profileView, animated: true)
                }
                //  SelectedProductIndex = j;
            }
        }
        // [self.newsWriterTxt layoutIfNeeded];
        newsWriterTxt.isEditable = false
    }
    func getAuthorsNameString() -> String? {
        var authorName = ""
        for i in 0..<viewModel.newsDeatilsData.authors.count {
            let item = viewModel.newsDeatilsData.authors[i]
            if i == viewModel.newsDeatilsData.authors.count - 1 {
                authorName = authorName + (item.name ?? "")
            } else {
                authorName = "\(authorName + (item.name ?? "")),"
            }
        }
        return authorName
    }
    
    // -----------------------
}

extension NewsDetailsVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: NewsCustomCell
        let dic = sectionsList[indexPath.section] as? [AnyHashable : Any]
        var list: [Any]?
        if (dic?.values.count ?? 0) > 0 {
            list = dic?.first?.value as? [Any]
        }
        if ((list![0] as? [RelatedNew]) != nil) {
            let relatedNews = list![0] as? [RelatedNew]
            let item = relatedNews![indexPath.row]
            cell = (Bundle.main.loadNibNamed("NewsCustomCell", owner: self, options: nil)?[0] as? NewsCustomCell)!
            cell.hideDeleteBtn = true
            
            if item.images.count > 0 {
                let imageItem = item.images[0]
                (cell).itemImg.sd_setImage(with: URL(string: imageItem.large ?? ""), placeholderImage: UIImage(named: "place_holder.jpg"), completed: { image, error, cacheType, imageURL in
                    (cell).activityIndicator.stopAnimating()
                })
            }
            (cell).itemLbl.text = item.newsTitle
            cell.playImg.isHidden = true
            (cell).dateLabel.isHidden = true
            return cell
        }
        if ((list![0] as? [RelatedVideo]) != nil) {
            let relatedVideos = list![0] as? [RelatedVideo]
            let item = relatedVideos![indexPath.row]
            cell = Bundle.main.loadNibNamed("NewsCustomCell", owner: self, options: nil)?[0] as! NewsCustomCell
            cell.hideDeleteBtn = true
            (cell).itemImg.sd_setImage(with: URL(string: item.videoPreviewImage ?? ""), placeholderImage: UIImage(named: "place_holder.jpg"), completed: { image, error, cacheType, imageURL in
                ((cell).activityIndicator)!.stopAnimating()
            })
            
            ((cell).itemLbl)!.text = item.videoTitle
            cell.playImg.isHidden = false
            (cell).dateLabel.isHidden = true
            return cell
        }
        if ((list![0] as? [Album]) != nil) {
            let albums = list![0] as? [Album]
            let item = albums![indexPath.row]
            var cell: NewsCustomCell?
            if cell == nil {
                cell = Bundle.main.loadNibNamed("NewsCustomCell", owner: self, options: nil)?[0] as? NewsCustomCell
                cell?.hideDeleteBtn = true
                cell?.playImg.image = UIImage(named: "ic_album")
                cell?.playImg.isHidden = false
            }
            var firstPictureItem: Picture?
            if item.pictures.count > 0 {
                firstPictureItem = item.pictures[0] as? Picture
            }
            (cell)?.itemLbl.text = item.albumTitle
            (cell)?.dateLabel.isHidden = true
            
            (cell)?.itemImg.sd_setImage(with: URL(string: firstPictureItem?.urls.large ?? ""), placeholderImage: UIImage(named: "place_holder.jpg"), completed: { image, error, cacheType, imageURL in
                (cell)?.activityIndicator.stopAnimating()
            })
            
            return cell!
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        let title = UILabel(frame: CGRect(x: 8, y: 5, width: self.tableView.frame.size.width - 30, height: 25))
        title.font = UIFont(name: "DINNextLTW23Regular", size: title.font.pointSize)
        title.textColor = UIColor.black
        title.textAlignment = .right
        // title.text = [[sections allKeys]objectAtIndex:section];
        title.backgroundColor = UIColor.clear
        
        if sectionsList.count > 0 {
            let dic = sectionsList![section] as? [String : Any]
            title.text = dic!.keys.first!.description.lowercased()
        }
        
        headerView.addSubview(title)
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dic = sectionsList[section] as? [AnyHashable : Any]
        var list = NSArray()
        if (dic?.values.count ?? 0) > 0 {
            list = dic?.values.first as! NSArray
        }
        return (list[0] as AnyObject).count
    }
}
extension NewsDetailsVC : NewsHomeDelegate{
    func showLoading() {
        indLoader.startAnimating()
        indLoader.isHidden = false
        tableView.isHidden = true
        scrollContent.scrollsToTop = true
        tableView.scrollsToTop = false
        webView?.scrollView.scrollsToTop = false
    }
    func hideLoading() {
        indLoader.stopAnimating()
        indLoader.isHidden = true
        tableView.isHidden = false
    }
    func showAlert(messgae: String) {
    }
    func dataBind() {
        if viewModel.newsDeatilsData != nil  && viewModel.newsDeatilsData.newsDescription == "" {
            let alert = UIAlertController(title:  "لا يوجد محتوي لهذا الموضوع", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            relatedVideosList.add(viewModel.newsDeatilsData.relatedVideos)
            relatedNewsList.add(viewModel.newsDeatilsData.relatedNews)
            
            if relatedNewsList.count > 0 {
                // [sections setObject:self.relatedNewsList forKey:@"أخبار متعلقة"];
                let dic = NSDictionary(objects:[relatedNewsList], forKeys:["أخبار متعلقة"] as [NSCopying]) as Dictionary
                sectionsList.add(dic)
            }
            if viewModel.newsDeatilsData.authorRelatedOpinions.count > 0 {
                // [sections setObject:self.relatedNewsList forKey:@"أخبار متعلقة"];
                let dic = NSDictionary(objects:[viewModel.newsDeatilsData.authorRelatedOpinions], forKeys:["مقالات أخري للكاتب"] as [NSCopying]) as Dictionary
                sectionsList.add(dic)
            }
            if viewModel.newsDeatilsData.relatedAlbums.count > 0 {
                // [sections setObject:self.relatedNewsList forKey:@"أخبار متعلقة"];
                let dic = NSDictionary(objects:[viewModel.newsDeatilsData.relatedAlbums], forKeys:["صور متعلقة"] as [NSCopying]) as Dictionary
                sectionsList.add(dic)
            }
            if relatedVideosList.count > 0 {
                // [sections setObject:self.relatedVideosList forKey:@"فيديوهات متعلقة"];
                let dic = NSDictionary(objects:[relatedVideosList], forKeys:["فيديوهات متعلقة"] as [NSCopying]) as Dictionary
                sectionsList.add(dic)
            }
            
            if sectionsList.count > 0 {
                tableView.reloadData()
                tableView.layoutIfNeeded()
            }
            canLoadMore = true
            tableViewHeightConstraint.constant = tableView.contentSize.height
            setAuthorsLbl()
            self.loadViewsFromNewsItem(withRelatedList: 1)
            addBlackOverlayOnArticleImage()
        }
        
    }
}
