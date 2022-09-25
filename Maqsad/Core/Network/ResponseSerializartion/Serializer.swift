//
//  Serializer.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 24/02/2022.
//


import Foundation
import Alamofire

/// This should be implemented in models coming from server
protocol ResponseObjectSerializable {
    static var cacheEnaled: Bool { get }
  init?(response: HTTPURLResponse?, representation: Any)
}

extension ResponseObjectSerializable {
    static var cacheEnaled: Bool { return true }
}

/// This should be implemented in collection of model coming from server
protocol ResponseCollectionSerializable {
  static func collection(from response: HTTPURLResponse?, withRepresentation representation: Any) -> [Self]
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
  static func collection(from response: HTTPURLResponse?, withRepresentation representation: Any) -> [Self] {
    var collection: [Self] = []
    
    if let representation = representation as? [[String: Any]] {
      for itemRepresentation in representation {
        if let item = Self(response: response, representation: itemRepresentation) {
          collection.append(item)
        }
      }
    }
    
    return collection
  }
}
