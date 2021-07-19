//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 16/07/21.
//

import UIKit
import ProgressHUD

class ForecastViewController: UIViewController {
  
  let viewModel = assembler.forecastViewModel()
  
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    ProgressHUD.show()
    viewModel.fetchForecast { [weak self] in
      ProgressHUD.dismiss()
      self?.tableView.reloadData()
    }
  }
  
}

extension ForecastViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfItems()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as? ForecastCell
    cell?.timeLabel.text = viewModel.time(at: indexPath)
    cell?.minTempLabel.text = viewModel.minTemp(at: indexPath)
    cell?.maxTempLabel.text = viewModel.maxTemp(at: indexPath)
    cell?.humidityLabel.text = viewModel.humidity(at: indexPath)
    cell?.iconView.image = viewModel.icon(at: indexPath)
    return cell ?? UITableViewCell()
  }
  
}
