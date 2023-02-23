//
//  Endpoint.swift
//  
//
//  Created by Anton Sarudko on 23.02.23.
//

/**
 Represents a network endpoint
 
 An endpoint has the following properties: :
 */
public struct Endpoint<T: Decodable> {
    /// URL Path
    var path: String
    /// Decode Type
    var type: T.Type
    /// HTTP Method
    var method = HTTPMethod.get
    /// HTTP Request Header
    var headers = [String: String]()
    
    /// Endpoint init
    /// - Parameters:
    ///   - path:  URL Path
    ///   - type: Decode Type
    ///   - method: HTTP Method
    ///   - headers: HTTP Request Header
    public init(path: String, type: T.Type, method: HTTPMethod = HTTPMethod.get, headers: [String : String] = [String: String]()) {
        self.path = path
        self.type = type
        self.method = method
        self.headers = headers
    }
}
