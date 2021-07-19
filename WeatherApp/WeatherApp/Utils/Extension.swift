//
//  Extension.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import UIKit
import Kingfisher

extension UIStoryboard {
  
  static var main: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
  }
  
  func viewController<T: UIViewController>(_ type: T.Type) -> T {
    return instantiateViewController(identifier: type.identifer) as! T
  }
}

extension UICollectionView {
  
  func dequeue<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath) -> T {
    return dequeueReusableCell(withReuseIdentifier: type.identifer, for: indexPath) as! T
  }
  
  func register<T: UICollectionViewCell>(type: T.Type) {
    register(T.nib(), forCellWithReuseIdentifier: T.identifer)
  }
  
}

extension UITableView {
  
  func dequeue<T: UITableViewCell>(type: T.Type) -> T {
    return dequeueReusableCell(withIdentifier: type.identifer) as! T
  }
  
  func register<T: UITableViewCell>(type: T.Type) {
    register(T.nib(), forCellReuseIdentifier: T.identifer)
  }
  
  func deleteRow(at indexPath: IndexPath, performDeletion: ()->Void) {
    beginUpdates()
    performDeletion()
    deleteRows(at: [indexPath], with: .automatic)
    endUpdates()
  }
}

extension NSObject {
  
  var indentifer: String {
    return "\(self)"
  }
  
  static var identifer: String {
    return "\(self)"
  }
}

extension UIView {
  
  static func nib() -> UINib {
    return UINib(nibName: identifer, bundle: nil)
  }
  
  func addBlurToView() {
    let blurEffect = UIBlurEffect(style: .light)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.bounds
    blurEffectView.alpha = 0.8
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    self.addSubview(blurEffectView)
  }
}

extension UIImageView {
  
  func setImage(urlString: String, placeHolder: UIImage? = nil) {
    guard let url = URL(string: urlString) else {
      self.image = placeHolder
      return
    }
    let imageResource = ImageResource(downloadURL: url, cacheKey: urlString)
    kf.setImage(with: imageResource, placeholder: placeHolder)
    addGradient()
  }
  
  func makeOval() {
    layer.cornerRadius = bounds.width / 2
    layer.masksToBounds = true
  }

  func addGradient() {
    layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    let colors: [CGColor] = [UIColor.clear.cgColor, UIColor.init(white: 0, alpha: 0.6).cgColor]
    gradient.colors = colors
    layer.insertSublayer(gradient, at: 0)
  }
  
}

extension String {
  
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
  
  var initial: String {
    let words = self.components(separatedBy: " ")
    var initials = ""
    for word in  words {
      initials.append(word.uppercased().first ?? Character(""))
    }
    return initials
  }
  
  var avatar: UIImage? {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    paragraphStyle.lineHeightMultiple = 1.5
    return initial.image(withAttributes: [.foregroundColor: UIColor.white,
                                          .font: UIFont.systemFont(ofSize: 24.0),
        .paragraphStyle: paragraphStyle
      ], size: CGSize(width: 64.0, height: 64.0))
  }
  
  func image(withAttributes attributes: [NSAttributedString.Key: Any]? = nil, size: CGSize? = nil) -> UIImage? {
      let size = size ?? (self as NSString).size(withAttributes: attributes)
      return UIGraphicsImageRenderer(size: size).image { _ in
          (self as NSString).draw(in: CGRect(origin: .zero, size: size),
                                  withAttributes: attributes)
      }
  }
}

extension Date {
  
  var day: String  {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE"
    formatter.timeZone = TimeZone(secondsFromGMT: 19800)
    return formatter.string(from: self)
  }
  
  var time: String  {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(secondsFromGMT: 19800)
    formatter.dateFormat = "h:mm a"
    return formatter.string(from: self)
  }
  
}

extension Double {
  var tempUnit: String {
    return "\(Int(self))\(AppPreferences.unitSystems.tempUnit)"
  }
}

extension Int {
  var visibilityUnit: String {
    let valueInKM = self/1000
    return "\(valueInKM)KM"
  }
}

extension Numeric {
  var pressureUnit: String {
    return "\(self)hPa"
  }
  var humidityUnit: String {
    return "\(self)%"
  }
  var windSpeedUnit: String {
    return "\(self)\(AppPreferences.unitSystems.windSpeedUnit)"
  }
  
}

