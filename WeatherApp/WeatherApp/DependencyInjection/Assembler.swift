//
//  Assembler.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import UIKit

let assembler = Assembler()

class Assembler {
  
  var singletonInstance: AnyObject?
  /// Controllers
  func homeController() -> HomeViewController {
    return UIStoryboard.main.viewController(HomeViewController.self)
  }
  
  func addLocationController() -> AddLocationViewController {
    return UIStoryboard.main.viewController(AddLocationViewController.self)
  }

  func searchResultController() -> SearchResultController {
    return UIStoryboard.main.viewController(SearchResultController.self)
  }
  
  func weatherViewController() -> WeatherViewController {
    return UIStoryboard.main.viewController(WeatherViewController.self)
  }
  
  func apiService() -> APIServiceProtocol {
    return APIService(fetcher: fetcher())
  }
  
  func fetcher() -> Fetcher {
    return DataFetcher(networking: networking(), parser: parser())
  }
  
  func networking() -> Networking {
    return HTTPNetworking()
  }
  
  func parser() -> Parser {
    return DataParser()
  }
  
  func storageManager() -> DataManager {
    if singletonInstance == nil {
      singletonInstance = StorageManager()
    }
    return singletonInstance as! DataManager
  }
  
  /// ViewModels
  func addLocationViewModel() -> AddLocationViewModel {
    return AddLocationViewModel(storageManager())
  }
  
  func homeViewModel() -> HomeViewModel {
    return HomeViewModel()
  }
  
  func weatherViewModel() -> WeatherViewModel {
    return WeatherViewModel()
  }
  
  func forecastViewModel() -> ForecastViewModel {
    return ForecastViewModel()
  }
}

