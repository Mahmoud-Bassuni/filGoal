//
//  NetworkAdapter.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/19/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//
import Foundation
import Moya
struct NetworkAdapter<T> where T: TargetType {
    private var  provider : MoyaProvider<T>!
    var endPointClousre  = { (target: T) -> Endpoint in
        
        let url = URL(target: target).absoluteString.removingPercentEncoding
        return Endpoint(url: url!, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
    }
    init() {
        provider = MoyaProvider<T>(endpointClosure: endPointClousre, plugins: [NetworkLoggerPlugin(verbose: true)]) // handle url encoding
    }
    func request<C: Codable>(target: T, success successCallback: @escaping (C) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    do{
                        let decoder = JSONDecoder()
                        // decode the json object
                        let decodableModel = try decoder.decode(C.self,from: response.data)
                        successCallback(decodableModel)
                    }
                    catch let err {errorCallback(err)}
                    
                } else {
                    let error = NSError(domain:"http://error.getsandbox.com", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
        
    }
}

