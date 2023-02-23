//
//  HTTPMethod.swift
//  
//
//  Created by Anton Sarudko on 23.02.23.
//


 /**
  Enumeration of supported HTTP methods
  
  Supported HTTP methods:
  
   * GET
   * POST
   * PUT
   * PATCH
   * DELETE
 */
public enum HTTPMethod: String {
    case delete, get, patch, post, put
    
    public var rawValue: String {
        String(describing: self).uppercased()
    }
}
