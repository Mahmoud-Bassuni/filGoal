//
//  NewsHomeVM.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/24/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//
import Foundation
class NewsHomeVM{
    public var delegate : NewsHomeDelegate!
    var pageSize : String = "15"
    var catId : String = "1"
    var langId : String = "1"
    var sectionId : String = "0"
    var pageNumber : Int = 1
    private var _newsList: [NewsCodable]! = []
    private var serviceAdapter : NetworkAdapter<NewsServiceEnum>!
    init(_serviceAdapter : NetworkAdapter<NewsServiceEnum>) {
        serviceAdapter = _serviceAdapter
        fetchNewsData()
    }
    func fetchNewsData(_ isRefresh : Bool = false){
        self.delegate?.showLoading()  // show loading in main ui thread
        serviceAdapter.request(target: .getNewsSection(pageSize: pageSize, catId: catId, langId: langId, sectionId: sectionId, pageNumber: String(isRefresh ? 1: pageNumber)), success: { [unowned self] (response:NewsModelCodable)   in
            isRefresh ? self._newsList = response.news : self._newsList.append(contentsOf: response.news)
            self.delegate?.dataBind() // callback from vc
            self.delegate?.hideLoading() // hide loading in main ui thread
            }, error: {_ in }
            , failure: {moyaError in self.delegate?.showAlert(messgae: moyaError.localizedDescription)})
    }
    deinit {
        delegate = nil
    }
}
extension NewsHomeVM {
    func newsList() -> [NewsCodable] {
        return _newsList
    }
    var numberOfSections: Int {
        return 1
    }
    func numberOfRowsInSection() -> Int {
        return self._newsList.count
    }
    func newsItemAtIndex(index: Int) -> NewsItemCategoryVM {
        let item = _newsList[index]
        return NewsItemCategoryVM(item)
    }
}
struct NewsItemCategoryVM {
    private let newsItem: NewsCodable
    init(_ _newsItem: NewsCodable) {
        newsItem = _newsItem
    }
}
extension NewsItemCategoryVM {
    var title: String {
        return newsItem.newsTitle
    }
    var id: Int {
        return newsItem.id
      }
    var image: String {
        return newsItem.images[0].large
    }
}
