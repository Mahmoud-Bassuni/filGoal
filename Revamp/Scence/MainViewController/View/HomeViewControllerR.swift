////
////  MainViewController.swift
////  FilGoalIOS
////
////  Created by Abdelrahman Elabd on 7/29/19.
////  Copyright © 2019 Sarmady. All rights reserved.
////
//
//import UIKit
//import Firebase
//import FirebaseAnalytics
//
//class HomeViewControllerR: ParentViewController ,XLPagerTabStripChildItem ,GADDebugOptionsViewControllerDelegate {
//    func debugOptionsViewControllerDidDismiss(_ controller: GADDebugOptionsViewController) {
//        
//    }
//    
//    func title(for pagerTabStripViewController: XLPagerTabStripViewController!) -> String! {
//        return ""
//        
//    }
//    
//    
//    @IBOutlet weak var homeTableView : UITableView!
//    @IBOutlet weak var loadingLbl : UILabel!
//    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
//    @IBOutlet weak var sponsorImgView : UIImageView!
//    @IBOutlet weak var sponsorImgViewHeightConstraint : NSLayoutConstraint!
//    @IBOutlet weak var bottomHeightConstraint : NSLayoutConstraint!
//    
//    @IBOutlet weak var specialSectionImgView : UIImageView!
//    @IBOutlet weak var bottomTableViewSpaceConstraint : NSLayoutConstraint!
//    @IBOutlet weak var specialSectionSpaceConstraint : NSLayoutConstraint!
//    @IBOutlet weak var topConstraint : NSLayoutConstraint!
//    @IBOutlet weak var testBtn : UIButton!
//    
//    
//    
//    var sectionId = 0
//    var index = 0
//    var isFirstLoad = false
//    var sectionChampions : NSArray?
//    var homeSectionsList : NSMutableArray?
//    var matchesDic : NSDictionary?
//    var sectionName = ""
//    
//    var widgetVC : MatchesWidgetViewController?
//    var isFromLandingScreen : Bool?
//    var lastVersionCheckPerformedOnDate: NSDate?
//    var matchesWidgetHeight : Double?
//    
//    
//    private var featuredAreaView: FeaturedAreaSliderViewController!
//    private var topRefreshControl: UIRefreshControl!
//    private var appDelegate: AppDelegate!
//    private var sliderView: BannersSliderViewController!
//    private var alertView: CustomIOSAlertView!
//      init(sectionId : Int , andChampions : NSArray) {
//        self.sectionId = sectionId
//        self.sectionChampions = andChampions
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        homeSectionsList = NSMutableArray()
//        appDelegate = UIApplication.shared.delegate as? AppDelegate
//        sliderView = BannersSliderViewController()
//        sliderView.isFromHome = true
//        
//        // FIRAnalytics.logEvent(withName: kFIREventViewItem, parameters: ["" : Any]?)
//      //  NSNotification(name: <#T##NSNotification.Name#>, object: <#T##Any?#>, userInfo: <#T##[AnyHashable : Any]?#>)
//        var defaults = UserDefaults.standard
//        defaults.set(false, forKey: "notfirstTimeHome")
//        UserDefaults.standard.synchronize()
//        //self.getMetaDataAndAppInfoAPIs()
//        self.testBtn.imageView?.image = self.testBtn.imageView?.image?.withRenderingMode(.alwaysTemplate)
//        self.edgesForExtendedLayout = UIRectEdge.all
//       // self.homeTableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, CGRect.height((self.tabBarController?.tabBar.frame)!)
//         //   , 0.0)
//        self.isFirstLoad = true
//        
//    }
//        override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }
//    
//    func getActiveChampions()  {
//        PredictionServiceManager.getActiveChampionships({ (response) in
//            if let response = response as? PredictionActiveChampions{
//                Global.getInstance()?.activePredictionchampions = response.result
//                
//            }
//        }) { ( error ) in
//            if let error = error as NSError?{
//              //  let statusCode = error.userInfo(objectForKey : AFNetworkingOperationFailingURLResponseErrorKey).statusCode
//                if error.code == 401{
//                 //   AFOAuthCredential.delete(withIdentifier: kPredictCrednitialIdentifier)
//                }
//            }
//            
//        }
//        
//    }
//    
//    
//    func getHomeDataAPI() {
//        let dictionary = Dictionary(uniqueKeysWithValues: zip("SecId",String(self.sectionId)))
//        if(self.sectionId != 0 && self.sectionChampions?.count == 0 ){
//            
//            WServicesManager.getDataWithURLString(HomeSectionNewsAPI, andParameters: dictionary, withObjectName: "Home", andAuthenticationType: .CMSAPIs, success: { (metaDate) in
//                
//            }) { (error) in
//                print(error)
//            }
//        }
//        
//    }
//    
//    
//    
//    func checkVersionWeekly()  {
//        self.lastVersionCheckPerformedOnDate = UserDefaults.standard.object(forKey: NEW_UPDATE_STORED_DATE) as? NSDate
//        if (self.lastVersionCheckPerformedOnDate != nil){
//            self.lastVersionCheckPerformedOnDate = NSDate()
//            self.checkVersion()
//        }
//        if (self.daysBetweenDate(BetweenDate: self.lastVersionCheckPerformedOnDate!, andDate: NSDate()) > 3){
//            self.checkVersion()
//        }
//    }
//    func numberOfDaysElapsedBetweenLastVersionCheckDate() -> Int {
//        var currentCalendar : Calendar = Calendar.current
//        var component : DateComponents = currentCalendar.component(<#T##component: Calendar.Component##Calendar.Component#>, from: <#T##Date#>)
//    }
//    
//    func daysBetweenDate(BetweenDate fromDateTime : NSDate ,andDate toDateTime : NSDate) -> Int  {
//        var fromDate : Date?
//        var toDate : Date?
//        var calendar = Calendar.current
//        calendar.ra
//        
//    }
//    
//    
//    
//    
//    
//    - (NSUInteger)numberOfDaysElapsedBetweenLastVersionCheckDate
//    {
//    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
//    NSDateComponents *components = [currentCalendar components:NSCalendarUnitDay
//    fromDate:[self lastVersionCheckPerformedOnDate]
//    toDate:[NSDate date]
//    options:0];
//    return [components day];
//    }
//    - (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
//    {
//    NSDate *fromDate;
//    NSDate *toDate;
//    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
//    interval:NULL forDate:fromDateTime];
//    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
//    interval:NULL forDate:toDateTime];
//    
//    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
//    fromDate:fromDate toDate:toDate options:0];
//    
//    return [difference day];
//    }
//    
//    
//    func showNewUpdateAlert()  {
//        let controller = NewUpdateViewController()
//        let rect = CGRect(x: 0, y: 0, width: 280, height: 321)
//        controller.preferredContentSize = rect.size
//        let alertController = UIAlertController(title: "تنزيل التحديث", message: "", preferredStyle: .alert)
//        alertController.setValue(controller, forKey: "contentViewController")
//        let cancelAction = UIAlertAction(title: "إلغاء", style: .destructive, handler: nil)
//        alertController.addAction(cancelAction)
//        self.present(alertController,animated: true)
//        
//    }
//    
//    func checkVersion()  {
//        let valueofIsActive  = Global.getInstance()?.appInfo.app.isActive
//        if (valueofIsActive != nil) && (Global.getInstance()?.appInfo.app.version == super.app){
//            self.showNewUpdateAlert()
//            self.lastVersionCheckPerformedOnDate = NSDate()
//            UserDefaults.standard.set(self.lastVersionCheckPerformedOnDate, forKey: NEW_UPDATE_STORED_DATE)
//            UserDefaults.standard.synchronize()
//            
//        }
//    }
//    func showReloadAlert()  {
//        alertView = CustomIOSAlertView()
//        let reloadViewController = ReloadViewController()
//        alertView.containerView = reloadViewController.view
//        reloadViewController.retryBtn.addTarget(self, action: #selector(reloadAgain), for: .touchUpInside)
//        alertView.buttonTitles = nil
//        alertView.useMotionEffects = true
//        alertView.show()
//        
//        
//    }
//    
//    @objc func reloadAgain(){
//        alertView.close()
//        self.loadingLbl.text = "برجاء الانتظار قليلا ....."
//        self.activityIndicator.startAnimating()
//        self.activityIndicator.isHidden = false
//        alertView = nil
//        homeSectionsList = NSMutableArray()
//        self.getHomeDataAPI()
//    }
//    
//    func scrollViewShouldScrollToTop(scrollView: UIScrollView) ->Bool{
//        return true
//    }
//    
//    @IBAction func testAction(_ sender : UIButton){
//      let debugOptionsViewController =  GADDebugOptionsViewController(adUnitID: MeduimRectangle_AD_UNIT_ID)
//       debugOptionsViewController.delegate = self
//        self.present(debugOptionsViewController,animated: true)
//    
//    }
//    func scrollViewWillEndDragging(scrollView: UIScrollView!, withVelocity velocity: CGPoint, targetContentOffset: UnsafePointer<CGPoint>) {
//        if self.sectionId == 0{
//            if velocity.y > 0{
//                let userInfo = Dictionary(uniqueKeysWithValues: zip("SecId",String(true)))
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ClubProfileScrollUpNotification"), object: userInfo)
//            }
//            if velocity.y < 0 {
//                let userInfo = Dictionary(uniqueKeysWithValues: zip("SecId",String(false)))
//                if(scrollView.contentOffset.y<=0){
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ClubProfileScrollUpNotification"), object: userInfo)
//                }
//            }
//        }
//    }
//}
//
//
//
//
//
//
