//
//  DataLoader.swift
//  SurveysListTests
//
//  Created by Reinaldo Verdugo on 4/10/19.
//  Copyright © 2019 Nimble. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

class DataLoader {
  
  static func loadJson(fileName: String) -> Any {
    do {
      if let file = Bundle(for: self).path(forResource: fileName, ofType: "json") {
        let data = try Data(contentsOf: URL(fileURLWithPath: file))
        let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
        return jsonData
      }
    } catch {
      print(error.localizedDescription)
    }
    return "Couldn't open file"
  }
  
  static func loadJsonDictionary(fileName: String) -> JSONDictionary? {
    return self.loadJson(fileName: fileName) as? JSONDictionary
  }
}

extension Decodable {
  init(from: Any) {
    let data = try! JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    self = try! decoder.decode(Self.self, from: data)
  }
}

