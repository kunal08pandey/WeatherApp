//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 17/07/21.
//

import UIKit
import Reachability

class BaseViewController: UIViewController {
  
  private var backgroundImageView: UIImageView! = {
    let imageView = UIImageView(image: UIImage(named: "background"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  override func loadView() {
    super.loadView()
    addBackgroundImage()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    applyStyle()
    backButton()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  private func addBackgroundImage() {
    view.addSubview(backgroundImageView)
    updateBackgroundConstraints()
    view.sendSubviewToBack(backgroundImageView)
    backgroundImageView.addBlurToView()
  }
  
  func updateBackgroundConstraints() {
    guard let superview = backgroundImageView.superview else { return }
    backgroundImageView.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
    backgroundImageView.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
    backgroundImageView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    backgroundImageView.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
  }
  
  func backButton() {
    self.navigationItem.backButtonTitle = ""
  }
  
  func applyStyle() {
    self.navigationController?.navigationBar.tintColor = .white
    self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    self.navigationController?.navigationBar.backgroundColor = .clear
    UITableViewCell.appearance().tintColor = .white
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
  }

}

class BaseTableViewController: UITableViewController {
  
  private var backgroundImageView: UIImageView! = {
    let imageView = UIImageView(image: UIImage(named: "background"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override func loadView() {
    super.loadView()
    addBackgroundImage()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    applyStyle()
    backButton()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private func addBackgroundImage() {
    self.navigationController?.view.addSubview(backgroundImageView)
    updateBackgroundConstraints()
    self.navigationController?.view.sendSubviewToBack(backgroundImageView)
    backgroundImageView.addBlurToView()
  }
  
  func updateBackgroundConstraints() {
    guard let superview = backgroundImageView.superview else { return }
    backgroundImageView.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
    backgroundImageView.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
    backgroundImageView.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    backgroundImageView.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
  }
  
  func backButton() {
    self.navigationController?.navigationItem.backButtonTitle = ""
  }
  
  func applyStyle() {
    self.navigationController?.navigationBar.tintColor = .white
    self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    self.navigationController?.navigationBar.backgroundColor = .clear
    UITableViewCell.appearance().tintColor = .white
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .top, barMetrics: .default)
  }
  
  func changeStyle() {
    tableView.backgroundColor = .clear
    tableView.superview?.backgroundColor = .clear
  }
}
