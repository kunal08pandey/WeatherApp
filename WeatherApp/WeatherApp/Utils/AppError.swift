//
//  AppError.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import Foundation

enum AppError: Error {
  static var urlError: Error {
    return NSError(domain: "Invalid Url", code: 8889, userInfo: [NSLocalizedFailureReasonErrorKey : "Invalid Url"]) as Error
  }
}
