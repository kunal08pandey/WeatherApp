//
//  NetworkUtil.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 19/07/21.
//

import Foundation
import ProgressHUD
import Reachability

class NetworkUtil {
  
  let reachability = try! Reachability()
  
  init() {
    reachability.whenReachable = { reachability in
      
    }
    reachability.whenUnreachable = { [weak self] reachability in
      self?.handleNoInternet()
    }
    do {
      try reachability.startNotifier()
    } catch {
      debugPrint("Unable to start notifier :\(error)")
    }
  }
  
  func handleNoInternet() {
    ProgressHUD.dismiss()
    let alert = UIAlertController(title: "No Internet", message: "Please check your internet connection", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
      rootViewController.present(alert, animated: true, completion: nil)
    }
  }
  
  func checkConnectivityIssue() {
    if reachability.connection == .unavailable {
      handleNoInternet()
    }
  }
}
