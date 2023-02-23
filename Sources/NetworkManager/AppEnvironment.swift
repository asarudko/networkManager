//
//  AppEnvironment.swift
//  
//
//  Created by Anton Sarudko on 23.02.23.
//

import Foundation

/**
App Environment
*/
public struct AppEnvironment {
    /// Name of the App Environment
    var name: String
    /// Base URL of the App Environment
    var baseURL: URL
    /// Session of the App Environment
    var session: URLSession
    
    /// AppEnvironment init
    /// - Parameters:
    ///   - name: Name of the App Environment
    ///   - baseURL: Base URL of the App Environment
    ///   - session: Session of the App Environment
    public init(name: String, baseURL: URL, session: URLSession) {
        self.name = name
        self.baseURL = baseURL
        self.session = session
    }
}

