//
//  Parser.swift
//  WeatherApp
//
//  Created by Kunal Pandey on 13/07/21.
//

import Foundation

protocol Parser {
  func parse<T: Decodable>(data: Data?, to: T.Type) -> T?
}

struct DataParser: Parser {
  
  func parse<T: Decodable>(data: Data?, to: T.Type) -> T? {
    guard let data = data else { return nil}
    let jsonDecoder = JSONDecoder()
    do {
      let decodedData = try jsonDecoder.decode(T.self, from: data)
      return decodedData
    } catch {
      debugPrint("Error Occured while parsing \(error)")
     return nil
    }
  }
  
}
