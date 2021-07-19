//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import UIKit
import ProgressHUD

class WeatherViewController: BaseViewController {
  
  let viewModel = assembler.weatherViewModel()
  let segueIdentifier = "contains"
  
  @IBOutlet weak var minTempLabel: UILabel!
  @IBOutlet weak var maxTempLabel: UILabel!
  @IBOutlet weak var currentTempLabel: UILabel!
  @IBOutlet weak var sunriseTimeLabel: UILabel!
  @IBOutlet weak var sunsetTimeLabel: UILabel!
  @IBOutlet weak var humidityLevelLabel: UILabel!
  @IBOutlet weak var atmosphericPressureLabel: UILabel!
  @IBOutlet weak var windspeedLabel: UILabel!
  @IBOutlet weak var iconView: UIImageView!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var visibilityLabel: UILabel!
  @IBOutlet weak var mainStackView: UIStackView!
  
  fileprivate func addNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(deviceRotated(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ProgressHUD.show()
    viewModel.getCurrentWeather { [weak self] in
      ProgressHUD.dismiss()
      self?.updateUI()
    }
    addNotification()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    checkIfDeviceRotated()
  }
  
  func updateUI() {
    self.title = viewModel.cityName
    sunriseTimeLabel.text = viewModel.sunriseTime
    sunsetTimeLabel.text = viewModel.sunsetTime
    currentTempLabel.text = viewModel.currentTemprature
    humidityLevelLabel.text = viewModel.humidity
    atmosphericPressureLabel.text = viewModel.atmosphericPressure
    windspeedLabel.text = viewModel.windSpeed
    minTempLabel.text = viewModel.minTemperature
    maxTempLabel.text = viewModel.maxTemperature
    visibilityLabel.text = viewModel.visibility
    iconView.image = viewModel.icon
    containerView.isHidden = false
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  fileprivate func checkIfDeviceRotated() {
    if UIDevice.current.orientation == .portrait {
      mainStackView.axis = .vertical
    } else if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
      mainStackView.axis = .horizontal
    }
  }
  
  @objc func deviceRotated(_ notification: Notification) {
    checkIfDeviceRotated()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    if segue.identifier == segueIdentifier,
       let destination = segue.destination as? ForecastViewController {
      destination.viewModel.city = viewModel.location
    }
  }
  
}
