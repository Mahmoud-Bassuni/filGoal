//
//  NewsHomeDelegate.swift
//  FilGoalIOS
//
//  Created by Bassuni on 12/24/19.
//  Copyright © 2019 Sarmady. All rights reserved.
//
import Foundation
protocol NewsHomeDelegate{
    func showLoading()
    func hideLoading()
    func showAlert(messgae : String)
    func dataBind()
}
