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
  let AnnotationReusableIdentifier = "annotationView"
  
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
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "search_locations_placeholder".localized
    navigationItem.searchController = searchController
    definesPresentationContext = true
    changeSearchBarStyle(searchController)
  }
  
  func changeSearchBarStyle(_ searchController: UISearchController) {
    searchController.searchBar.tintColor = .white
    searchController.searchBar.searchTextField.leftView?.tintColor = .white
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes =
      [.foregroundColor: UIColor.white]
  }
  
  func initializeLocation() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
  
  @IBAction func bookmarkedLocation() {
    if let selectedPin = self.selectedPin {
      viewModel.saveLocation(selectedPin.locality, coordinate: selectedPin.coordinate)
    } else if let title = mapView.userLocation.title {
      viewModel.saveLocation(title, coordinate: mapView.userLocation.coordinate)
    }
    navigationController?.popViewController(animated: true)
  }
}

extension AddLocationViewController: UISearchControllerDelegate, UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    viewModel.search(searchText, region: mapView.region) { mapItems in
      guard let searchController = searchController.searchResultsController as? SearchResultController else { return }
      searchController.searchResults = mapItems
      searchController.reload()
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
    let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: AnnotationReusableIdentifier)
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
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    debugPrint("\(String(describing: locations.first))")
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    debugPrint("\(error)")
  }
}

extension AddLocationViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationReusableIdentifier)
    if annotationView == nil {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: AnnotationReusableIdentifier)
    }
    annotationView?.image = #imageLiteral(resourceName: "marker_sun").withRenderingMode(.alwaysTemplate)
    annotationView?.tintColor = .red
    return annotationView
  }
}
