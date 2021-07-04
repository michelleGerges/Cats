//
//  ErroHandler.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import Foundation

enum ErrorHandler: Error {
    
    static var networkErrorMessage = "Network error"
    static var generalErrorMessage = "Something went wrong"
    
    case network
    case serverDown
    case serialization
    case serverError(error: ServerError?)
    
    var message: String {
        switch self {
        case .network:
            return ErrorHandler.networkErrorMessage
        case .serverDown:
            return ErrorHandler.generalErrorMessage
        case .serialization:
            return ErrorHandler.generalErrorMessage
        case .serverError(let error):
            return error?.message ?? ErrorHandler.generalErrorMessage
        }
    }
}

extension Error {
    var message: String {
        return (self as? ErrorHandler)?.message ?? ErrorHandler.generalErrorMessage
    }
}
