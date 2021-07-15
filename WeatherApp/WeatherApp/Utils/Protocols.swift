//
//  Protocols.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import UIKit

protocol ModelLayer {
  var title: String { get }
  var image: UIImage? { get }
  var url: String { get }
  var subTitle: String { get }
}

extension ModelLayer {
  var subTitle: String {
    return ""
  }
}

protocol DataView {
  associatedtype Item
  func bind(item: Item)
}

