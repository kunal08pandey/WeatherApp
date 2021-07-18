//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import UIKit

class HomeViewController: BaseViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  let viewModel = assembler.homeViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "locations".localized
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchCities()
    tableView.reloadData()
  }
  
  func navigateToWeatherScreen(_ city: LocationEntity) {
    let weatherController = assembler.weatherViewController()
    weatherController.viewModel.location = city
    self.navigationController?.pushViewController(weatherController, animated: true)
  }
}

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfItems()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(type: LocationCell.self)
    let cityName = viewModel.cityName(at: indexPath.row)
    cell.titleLabel?.text = cityName
    return cell
  }
  
}

extension HomeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.fetchCities()
    navigateToWeatherScreen(viewModel.item(at: indexPath.row))
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      tableView.deleteRow(at: indexPath) { [weak self] in
        self?.viewModel.deleteCities(at: indexPath)
        self?.viewModel.fetchCities()
      }
    }
  }
}
