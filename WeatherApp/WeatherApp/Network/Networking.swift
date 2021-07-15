//
//  Networking.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import Foundation

enum RequestMethod: String {
  case get = "GET"
  case post = "POST"
  case delete = "DELETE"
  case put = "PUT"
}

typealias Parameter = [String: Any]

protocol Requestable {
  var path: Path { get }
  var parameters: Parameter { get }
  var method: RequestMethod { get }
}

protocol URLQueryRequest: Requestable { }

extension URLQueryRequest {
  
  var parameters: Parameter {
    return [:]
  }
  
  var method: RequestMethod {
    return .get
  }
  
}

protocol Networking {
  func request(_ request: Requestable, completion: ((Result<Data, Error>) -> Void)?)
}

struct HTTPNetworking: Networking {
  
  func request(_ request: Requestable, completion: ((Result<Data, Error>) -> Void)?) {
    guard let url = request.path.url else { return }
    var dataRequest = URLRequest(url: url)
    dataRequest.httpMethod = request.method.rawValue
    var completeParameters = request.parameters
    completeParameters[Path.appID] = request.path.apiKey
    completeParameters[Path.units] = "metric"
    dataRequest.url = parameter(url: url, paramaters: completeParameters)
    debugPrint("URL: \(dataRequest.url!.absoluteString)")
    URLSession.shared.dataTask(with: dataRequest) { (data, _, error) in
      DispatchQueue.main.async {
        if let data = data {
          completion?(.success(data))
        } else {
          if let error = error {
            completion?(.failure(error))
          }
        }
      }
    }.resume()
  }
  
  private func parameter(url: URL, paramaters: Parameter) -> URL {
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
    if !paramaters.isEmpty {
      let percentEncodedQuery = urlComponents?.percentEncodedQuery.map { $0 + "&" } ?? "" + query(paramaters)
      urlComponents?.percentEncodedQuery = percentEncodedQuery
      return urlComponents?.url ?? url
    }
    return url
  }
  
  private func query(_ parameters: [String: Any]) -> String {
    var components: [(String, String)] = []
    
    for key in parameters.keys.sorted(by: <) {
      if let value = parameters[key] as? String {
        components.append((key, value))
      }
    }
    return components.map { "\($0)=\($1)" }.joined(separator: "&")
  }
}

struct Responder<T: Decodable> {
  typealias ResponseHandeler<T: Decodable> = ((Result<T?, Error>) -> Void)
  let completion: ResponseHandeler<T>
  init(completion: @escaping ResponseHandeler<T>) {
    self.completion = completion
  }
}
