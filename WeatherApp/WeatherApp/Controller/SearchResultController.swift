//
//  SearchResultController.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import UIKit
import MapKit

protocol HandleMapSearch: AnyObject {
    func dropPinZoomIn(placemark:MKPlacemark)
}

protocol SearchResultControllerProtocol {
  func reload()
}

class SearchResultController: BaseTableViewController {
  
  var searchResults: [MKMapItem] = []
  weak var delegate: HandleMapSearch?
  var CellIdentifier = "searchCell"
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return searchResults.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
    cell.textLabel?.text  = searchResults[indexPath.row].placemark.locality
    cell.detailTextLabel?.text = searchResults[indexPath.row].placemark.country
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let placeMark = searchResults[indexPath.row].placemark
    delegate?.dropPinZoomIn(placemark: placeMark)
    dismiss(animated: true, completion: nil)
  }
}

extension SearchResultController: SearchResultControllerProtocol {
  
  func reload() {
    tableView.reloadData()
  }
  
  
}
