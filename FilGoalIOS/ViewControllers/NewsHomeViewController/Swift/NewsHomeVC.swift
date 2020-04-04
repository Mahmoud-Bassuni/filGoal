//
//  NewsHomeVC.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/24/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//
import UIKit
class NewsHomeVC: UIViewController , UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = 0
        index = (viewController as? NewsDetailsVC)?.currentNewsIndex ?? 0
        index -= 1
        if index < 0 {
            return nil
        } else {
            var childViewController = NewsDetailsVC()
            childViewController.id = newsHomeVM.newsItemAtIndex(index: index).id
            childViewController.currentNewsIndex =  index
            _ = childViewController.view
            childViewController.viewDidLoad()
            return childViewController
            
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = 0
        index = (viewController as? NewsDetailsVC)?.currentNewsIndex ?? 0
        index += 1
        
        var childViewController = NewsDetailsVC()
        childViewController.id =  newsHomeVM.newsItemAtIndex(index: index).id  //379586
        childViewController.currentNewsIndex =  index
        _ = childViewController.view
        childViewController.viewDidLoad()
        return childViewController
        
    }
    
    // IBOutlets and objects
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var indLoader: UIActivityIndicatorView!
    @IBOutlet var loadingLabel: UILabel!
    
    var pageController: UIPageViewController?
    
    var refreshControl: UIRefreshControl?
    var newsHomeVM : NewsHomeVM!
    // ------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        desginAndConfigVC()
    }
    func desginAndConfigVC(){
        self.loadingLabel.isHidden = true
        searchBar.semanticContentAttribute = .forceRightToLeft
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        newsHomeVM = NewsHomeVM(_serviceAdapter: NetworkAdapter<NewsServiceEnum>())
        newsHomeVM.delegate = self
        addBottomPullToRefresh()
        tableView.tableFooterView = UIView() // ui of table
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(nil, action: #selector(updateArray(_:)), for: .valueChanged)
        if let refreshControl = refreshControl {
            tableView.addSubview(refreshControl)
        }
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    @objc func updateArray(_ sender: UIRefreshControl?) {
        newsHomeVM.fetchNewsData(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        //  newsHomeVM = nil
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsHomeVM = NewsHomeVM(_serviceAdapter: NetworkAdapter<NewsServiceEnum>())
        newsHomeVM.delegate = self
        self.tableView.isScrollEnabled = true;
    }
    func addBottomPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.black
        refreshControl.triggerVerticalOffset = 80.0
        refreshControl.addTarget(self, action: #selector(refreshBottom), for: .valueChanged)
        tableView.bottomRefreshControl = refreshControl
    }
    @objc func refreshBottom() {
        newsHomeVM.pageNumber += 1
        newsHomeVM.fetchNewsData()
        tableView.bottomRefreshControl!.endRefreshing()
    }
}
// tableview implementation
extension NewsHomeVC: UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (fabs(Float(Double(UIScreen.main.bounds.size.height) - Double(736))) < Float(DBL_EPSILON)) {
            return CGFloat(300)
        } else if (fabs(Float(Double(UIScreen.main.bounds.size.height) - Double(667))) < Float(DBL_EPSILON)) {
            return CGFloat(270)
        } else {
            return CGFloat(235)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsHomeVM.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsHomeVM.numberOfRowsInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "StoryTVC")
        cell = Bundle.main.loadNibNamed("StoryTVC", owner: self, options: nil)?[0] as? UITableViewCell
        let item = newsHomeVM.newsItemAtIndex(index: indexPath.row)
        (cell as? StoryTVC)?.initWith(title: item.title, image: item.image)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var viewControllers: [AnyHashable]? = nil
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let navigationController = appDelegate?.getSelectedNavigationController
        var newsDetailsVC = NewsDetailsVC()
        newsDetailsVC.id = newsHomeVM.newsItemAtIndex(index: indexPath.row).id
        viewControllers = [newsDetailsVC]
        
        pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController!.view.backgroundColor = UIColor.black
        pageController!.dataSource = self;
        pageController!.view.frame = view.bounds
        pageController!.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: false)
        navigationController!()!.pushViewController(pageController!, animated: true)
        
    }
}
// implementation MenuVMDelegate
extension NewsHomeVC: NewsHomeDelegate
{
    func showLoading() {
        //Show Loading view
        loadingLabel.text = "برجاء الانتظار قليلا ....."
        indLoader.startAnimating()
        indLoader.isHidden = false
        loadingLabel.isHidden = false
    }
    func hideLoading() {
        
        indLoader.stopAnimating()
        indLoader.isHidden = true
        loadingLabel.isHidden = true
        
    }
    func showAlert(messgae: String) {
        loadingLabel.text="لم يتم العثور علي اخبار"
    }
    func dataBind() {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}
extension NewsHomeVC : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyWord = searchBar.text
        if !(keyWord == "") {
            let searchVC = SearchViewController(keyWord: keyWord, andTypeId: 2)
            view.endEditing(true)
            navigationController?.pushViewController(searchVC!, animated: true)
        }
    }
}

