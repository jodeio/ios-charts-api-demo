//
//  ChartService.swift
//  ios-charts-api-demo
//
//  Created by Joshua de Guzman on 20/04/2018.
//  Copyright © 2018 Joshua de Guzman. All rights reserved.
//

import Alamofire

enum ChartService: EndpointProtocol{
    
    case getChartData()
    
    var method: HTTPMethod{
        switch self {
            case .getChartData:
            return .get
        }
    }
    
    var path: String{
        switch self {
        case .getChartData:
            return "b/5ad9eb8e003aec63328d9193/2/"
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .getChartData:
            return nil
        }
    }
    
    var headers: HTTPHeaders?{
        switch self {
        case .getChartData:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try API.BASE_URL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // Methods
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        urlRequest.allHTTPHeaderFields = headers
        
        // Returning URL Request with encoding
        switch self {
        case .getChartData:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
    }
    
    
}
