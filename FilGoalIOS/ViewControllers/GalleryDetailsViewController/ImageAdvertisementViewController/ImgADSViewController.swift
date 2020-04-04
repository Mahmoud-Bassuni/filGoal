//
//  ImgADSViewController.swift
//  FilGoalIOS
//
//  Created by Abdelrahman Elabd on 10/2/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import UIKit

class ImgADSViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var imgsWithAddsCollectionView : UICollectionView!
    @objc var arrOfImages = [String]()
    
    let leftAndRightPaddings: CGFloat = 80.0
     let numberOfItemsPerRow: CGFloat = 7.0
     let screenSize: CGRect = UIScreen.main.bounds
     private let cellReuseIdentifier = "collectionCell"
     var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
               let flowLayout = UICollectionViewFlowLayout()
               flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame:CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height) , collectionViewLayout: flowLayout)
               //collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        let dismissButton = UIButton(frame: CGRect(x: self.view.frame.minX + 16, y: collectionView.frame.minY + 16 , width: 30, height: 30))
        dismissButton.addTarget(self, action: #selector(self.didmissCurrentViewController), for: .touchUpInside)
        dismissButton.setImage(UIImage(named: "Comboarrow.ong"), for: .normal)
        
               collectionView.register(ImgsWithAdsCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
               collectionView.delegate = self
               collectionView.dataSource = self
               collectionView.backgroundColor = UIColor.black
               self.view.addSubview(collectionView)
               self.view.addSubview(dismissButton)
    }
    
     @objc func didmissCurrentViewController() {
        print("abdoabdoabdo")
               self.dismiss(animated: true, completion: nil)
    }
    @IBAction func dismissViewCongtroller(_sender : UIButton){
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (arrOfImages.count) ;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imgsWithAdsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? ImgsWithAdsCollectionViewCell
        if indexPath.row % 2 == 0 {
        
            imgsWithAdsCollectionViewCell?.sliderimage = UIImageView(frame: CGRect(x: 0, y: 0, width: (imgsWithAdsCollectionViewCell?.frame.width)!, height:  (imgsWithAdsCollectionViewCell?.frame.height)!))
            imgsWithAdsCollectionViewCell?.sliderimage.contentMode = .scaleAspectFit
        print((arrOfImages.count))
            imgsWithAdsCollectionViewCell?.sliderimage.sd_setImage(with: URL(string: arrOfImages[indexPath.row]), placeholderImage: UIImage(named: "placeholder"))
            imgsWithAdsCollectionViewCell?.addSubview((imgsWithAdsCollectionViewCell?.sliderimage!)!)
        }
        else{
            
            var urlString = "http://www.filgoal.com/Arabic/APIVideoView.aspx?AudioVideoID=1"
            var url = URL(string: urlString)
            
            //var urlString: String?
            //if videoItem != nil {
              //  urlString = String(format: "http://www.filgoal.com/Arabic/APIVideoView.aspx?AudioVideoID=2")
            //}
            //let url = URL(string: urlString )
            var request: URLRequest? = nil
            if let url = url {
                request = URLRequest(url: url)
            }
            let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=\(self.view.frame.width)'); document.getElementsByTagName('head')[0].appendChild(meta);"

            let wkUScript = WKUserScript(source: jScript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            let wkUController = WKUserContentController()
            wkUController.addUserScript(wkUScript)
            let wkWebConfig = WKWebViewConfiguration()
            wkWebConfig.userContentController = wkUController
            var webView = WKWebView()
            //was
            //self.webView=[[WKWebView alloc]initWithFrame: CGRectMake(-10,-30,Screenwidth+20,  self.imageViewHeightConstraint.constant+40) configuration:wkWebConfig];
            //Now
            webView = WKWebView(frame: CGRect(x: 0, y: 0, width: CGFloat(imgsWithAdsCollectionViewCell!.frame.width), height: imgsWithAdsCollectionViewCell!.frame.height), configuration: wkWebConfig)

            webView.scrollView.isScrollEnabled = false
//            webView.setOpaque(false)
//            webView.setTag(500)
         //   webView.navigationDelegate = self as! WKNavigationDelegate
            webView.load(request!)
            imgsWithAdsCollectionViewCell?.addSubview(webView)
        }
     
        return imgsWithAdsCollectionViewCell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width:collectionView.bounds.width, height:collectionView.bounds.height)
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImgsWithAdsCollectionViewCell{
            cell.sliderimage.image = self.resizeImage(image: (cell.sliderimage.image)!, targetSize: CGSize(width: 400, height: 400))
            cell.sliderimage.layoutIfNeeded()
            cell.layoutIfNeeded()
        }
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio * 2,  height: size.height * widthRatio * 2)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
 }




