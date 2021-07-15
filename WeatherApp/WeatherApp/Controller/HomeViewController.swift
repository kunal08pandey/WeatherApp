//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  let viewModel = assembler.homeViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Locations"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.fetchCities()
    tableView.reloadData()
  }
  
}

extension HomeViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfItems()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") as? LocationCell
    let cityName = viewModel.cityName(at: indexPath.row)
    cell?.titleLabel?.text = cityName
    return cell ?? UITableViewCell()
  }
  
}

extension HomeViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.fetchCities()
    let weatherController = assembler.weatherViewController()
    weatherController.viewModel.city = viewModel.item(at: indexPath.row)
    self.navigationController?.pushViewController(weatherController, animated: true)
  }
  
}
