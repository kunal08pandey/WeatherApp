//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 17/07/21.
//

import UIKit

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
  
  private func addBackgroundImage() {
    view.addSubview(backgroundImageView)
    view.sendSubviewToBack(backgroundImageView)
    backgroundImageView.addBlurToView()
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
    self.navigationController?.view.sendSubviewToBack(backgroundImageView)
    backgroundImageView.addBlurToView()
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
