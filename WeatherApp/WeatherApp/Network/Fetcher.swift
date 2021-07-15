//
//  Fetcher.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import Foundation

protocol Fetcher {
  func fetch<T: Decodable>(request: Requestable, responder: Responder<T>)
}

struct DataFetcher: Fetcher {
  
  let networking: Networking
  let parser: Parser
  
  init(networking: Networking, parser: Parser) {
    self.networking = networking
    self.parser = parser
  }
  
  func fetch<T>(request: Requestable, responder: Responder<T>) where T : Decodable {
    networking.request(request) { (result) in
      switch result {
        case .success(let data):
          debugPrint("Response: \(String(data: data, encoding: .utf8))")
          let parsedData = self.parser.parse(data: data, to: T.self)
          debugPrint("Parsed Data: \(parsedData)")
          responder.completion(.success(parsedData))
        case .failure(let error):
          responder.completion(.failure(error))
      }
    }
  }
  
  func fetch<T: Decodable>(request: Requestable, completion: ((Result<T?, Error>) -> Void)?) {
    
  }
}


