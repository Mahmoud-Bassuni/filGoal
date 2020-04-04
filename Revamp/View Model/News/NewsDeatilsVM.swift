//
//  NewsDeatilsVM.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/31/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//

import Foundation
class NewsDeatilsVM{
    public var delegate : NewsHomeDelegate!
       var id : String = "376592"
        var newsDeatilsData: NewsDetailsModelCodable!
       private var serviceAdapter : NetworkAdapter<NewsServiceEnum>!
    init(_serviceAdapter : NetworkAdapter<NewsServiceEnum> , _id : String) {
           id = _id
           serviceAdapter = _serviceAdapter
           fetchNewsDetailsData()
       }
       func fetchNewsDetailsData(){
           self.delegate?.showLoading()  // show loading in main ui thread
        serviceAdapter.request(target: .getNewsDetails(id: id), success: { [unowned self] (response:NewsDetailsModelCodable)   in
            self.newsDeatilsData = response
               self.delegate?.dataBind() // callback from vc
               self.delegate?.hideLoading() // hide loading in main ui thread
            }, error: { err in print("bassuni log \(err.localizedDescription)") }
               , failure: {moyaError in self.delegate?.showAlert(messgae: moyaError.localizedDescription)})
       }
       deinit {
           delegate = nil
       }
}
