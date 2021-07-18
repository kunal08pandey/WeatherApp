//
//  AddLocationViewController.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class AddLocationViewController: BaseViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  var locationManager = CLLocationManager()
  
  var selectedPin: MKPlacemark? = nil
  let viewModel = assembler.addLocationViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    intializeMap()
    initializeLocation()
    initializeSearchBar()
  }
  
  func intializeMap() {
    mapView.showsUserLocation = true
  }
  
  func initializeSearchBar() {
    let searchResultController = assembler.searchResultController()
    searchResultController.delegate = self
    let searchController = UISearchController(searchResultsController: searchResultController)
    searchController.delegate = self
    searchController.searchBar.tintColor = .white
    searchController.searchBar.searchTextField.leftView?.tintColor = .white
    searchController.searchResultsUpdater = self
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes =
      [.foregroundColor: UIColor.white]
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Locations"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  
  func initializeLocation() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
  
  @IBAction func bookmarkedLocation() {
    guard let selectedPin = self.selectedPin else { return }
    viewModel.saveLocation(selectedPin)
    
      self.navigationController?.popViewController(animated: true)
  }
}

extension AddLocationViewController: UISearchControllerDelegate, UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    let localRequest = MKLocalSearch.Request()
    localRequest.naturalLanguageQuery = searchText
    localRequest.region = mapView.region
    let search = MKLocalSearch(request: localRequest)
    search.start { response, _ in
      guard let response = response,
            let searchController = searchController.searchResultsController as? SearchResultController else { return }
      searchController.searchResults = response.mapItems
      searchController.tableView.reloadData()
    }
  }
}

extension AddLocationViewController: HandleMapSearch {
  func dropPinZoomIn(placemark: MKPlacemark) {
    self.selectedPin = placemark
    mapView.removeAnnotations(mapView.annotations)
    let annotation = MKPointAnnotation()
    annotation.coordinate = placemark.coordinate
    annotation.title = placemark.name
    let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
    annotationView.image = #imageLiteral(resourceName: "marker_sun").withRenderingMode(.alwaysTemplate)
    annotationView.animatesDrop = true
    annotationView.tintColor = .red
    mapView.delegate = self
    mapView.addAnnotation(annotation)
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
    mapView.setRegion(region, animated: true)
  }
}

extension AddLocationViewController: CLLocationManagerDelegate {
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    if manager.authorizationStatus == .authorizedWhenInUse {
      locationManager.requestLocation()
    }
  }
  
  func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
    print(manager.location)
    
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("\(String(describing: locations.first))")
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("\(error)")
  }
}

extension AddLocationViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView")
    if annotationView == nil {
      
      annotationView = MKAnnotationView(annotation: MKPointAnnotation(), reuseIdentifier: "annotationView")
    }
    annotationView?.image = #imageLiteral(resourceName: "marker_sun")
//    annotation
    return annotationView
  }
}
