//
//  EndpointProtocol.swift
//  ios-charts-api-demo
//
//  Created by Joshua de Guzman on 20/04/2018.
//  Copyright © 2018 Joshua de Guzman. All rights reserved.
//

import Alamofire

protocol EndpointProtocol:URLRequestConvertible{
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
}
