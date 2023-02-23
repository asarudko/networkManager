//
//  NetworkManager.swift
//
//
//  Created by Anton Sarudko on 23.02.23.
//

import Foundation
/**
 Network Manager to perform network requests
 */
public struct NetworkManager {
    
    // MARK: - Properties
    ///The environment to be used by the Network Manager.
    private let environment: AppEnvironment
    
    /// Network Manager init
    /// - Parameter environment: The environment to be used by the Network Manager.
    public init(environment: AppEnvironment) {
        self.environment = environment
    }
    
    /// Downloads the contents of a resource asynchronously.
    /// - Parameters:
    ///   - resource: Endpoint resource
    ///   - data: HTTP body of the request
    /// - Returns: The downloaded contents of the request
    public func fetch<T>(_ resource: Endpoint<T>, with data: Data? = nil) async throws -> T {
        guard let url = URL(string: resource.path, relativeTo: environment.baseURL) else {
            throw URLError(.unsupportedURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        request.httpBody = data
        request.allHTTPHeaderFields = resource.headers
        
        let (data, _) = try await environment.session.data(for: request)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    /// Downloads the contents of a resource asynchronously with a rety delay.
    /// - Parameters:
    ///   - resource: Endpoint resource
    ///   - data: HTTP body of the request
    ///   - attempts: The maximum number of attempts that will be performed in the event of an error request
    ///   - retryDelay: Retry delay in seconds
    /// - Returns: The downloaded contents of the request
    public func fetch<T>(_ resource: Endpoint<T>, with data: Data? = nil, attempts: Int, retryDelay: Double = 1) async throws -> T {
        do {
            return try await fetch(resource, with: data)
        } catch {
            if attempts > 1 {
                try await Task.sleep(for: .milliseconds(Int(retryDelay * 1000)))
                return try await fetch(resource, with: data, attempts: attempts - 1, retryDelay: retryDelay)
            } else {
                throw error
            }
        }
    }
    
    /// Downloads the contents of a resource asynchronously with a default value.
    /// - Parameters:
    ///   - resource: Endpoint resource
    ///   - data: HTTP body of the request
    ///   - defaultValue: The returned **default value** in the event of an error request
    /// - Returns: The downloaded contents of the request
    public func fetch<T>(_ resource: Endpoint<T>, with data: Data? = nil, defaultValue: T) async throws -> T {
        do {
            return try await fetch(resource, with: data)
        } catch {
            return defaultValue
        }
    }
}

