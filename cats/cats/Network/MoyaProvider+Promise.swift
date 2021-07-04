//
//  MoyaProvider+Promise.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import Alamofire
import Moya
import PromiseKit

extension MoyaProvider {
    
    func requestItem<T: Decodable> (_ target: Target) -> Promise<T> {
        
        return Promise<T> { (resolver) in
            
            self.request(target) { (result) in
                
                switch result {
                    
                case let .success(response):
                    
                    do {
                        if response.isSuccess { // response status code is 200
                            
                            let item = try JSONDecoder().decode(T.self, from: response.data)
                            resolver.fulfill(item)
                            
                        } else { // response status code is 400 ... 500
                            let error = try JSONDecoder().decode(ServerError.self, from: response.data)
                            resolver.reject(ErrorHandler.serverError(error: error))
                        }
                        
                    } catch { // could not serialize
                        resolver.reject(ErrorHandler.serialization)
                    }
                    
                case .failure: // network error
                    resolver.reject(ErrorHandler.network)
                }
            }
        }
    }
    
    func requestItems<T: Decodable> (_ target: Target) -> Promise<[T]> {
        
        return Promise<[T]> { (resolver) in
            
            self.request(target) { (result) in
                
                switch result {
                    
                case let .success(response):
                    
                    do {
                        if response.isSuccess { // response status code is 200
                            
                            let items = try JSONDecoder().decode([T].self, from: response.data)
                            resolver.fulfill(items)
                            
                        } else { // response status code is 400 ... 500
                            let error = try JSONDecoder().decode(ServerError.self, from: response.data)
                            resolver.reject(ErrorHandler.serverError(error: error))
                        }
                        
                    } catch { // could not serialize
                        resolver.reject(ErrorHandler.serialization)
                    }
                    
                case .failure: // network error
                    resolver.reject(ErrorHandler.network)
                }
            }
        }
    }
}

extension Moya.Response {
    var isSuccess: Bool {
        return (200 ... 299) ~= self.statusCode
    }
}

extension NetworkLoggerPlugin.Configuration {
    
    static var loggerConfiguration: NetworkLoggerPlugin.Configuration {
        return NetworkLoggerPlugin.Configuration (formatter: Formatter (),
                                                  output: defaultOutput(target:items:),
                                                  logOptions: LogOptions.verbose)
    }
}

extension NetworkLoggerPlugin {
    
    static var networkLogger: NetworkLoggerPlugin {
        return NetworkLoggerPlugin (configuration: NetworkLoggerPlugin.Configuration.loggerConfiguration)
    }
}
