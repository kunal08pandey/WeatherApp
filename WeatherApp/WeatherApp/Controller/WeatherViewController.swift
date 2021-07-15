//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 15/07/21.
//

import UIKit
import ProgressHUD

class WeatherViewController: UIViewController {
  
  let viewModel = assembler.weatherViewModel()
  
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var cityMinTempLabel: UILabel!
  @IBOutlet weak var cityWeatherLabel: UILabel!
  @IBOutlet weak var cityMaxTempLabel: UILabel!
  @IBOutlet weak var iconView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ProgressHUD.show()
    viewModel.getCurrentWeather { [weak self] weatherInfo in
      ProgressHUD.dismiss()
      self?.updateUI(weatherInfo: weatherInfo)
    }
  }
  
  func updateUI(weatherInfo: WeatherInfo?) {
    if let weather = weatherInfo {
      cityNameLabel.text = viewModel.cityName
      cityMinTempLabel.text = "\(weather.main.tempMin) ºC"
      cityMaxTempLabel.text = "\(weather.main.tempMax) ºC"
      cityWeatherLabel.text = weather.weather.first?.main ?? ""
      iconView.setImage(urlString: viewModel.iconUrl)
    }
  }
  
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
