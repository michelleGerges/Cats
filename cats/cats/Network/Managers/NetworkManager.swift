//
//  NetworkManager.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import Foundation
import Moya

class NetworkManager: NSObject {

    lazy var catsProvider: MoyaProvider<CatsAPIs> = {
        return MoyaProvider <CatsAPIs> (plugins: [NetworkLoggerPlugin.networkLogger])
    } ()
}
