//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Ümit on 26.09.2020.
//  Copyright © 2020 umtblbl. All rights reserved.
//

import Moya

enum WeatherAPI: BaseService {
    case today(cityName: String)
    case fourDays(cityName: String)
}

extension WeatherAPI: TargetType {
    
    var path: String {
        switch self {
        case .today:
            return "weather"
        case .fourDays:
            return "forecast/hourly"
        }
    }
    
    var method: Method {
        switch self {
        case .today, .fourDays:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .today(let cityName):
            let headerParameters: [String: Any] = [
                "q": cityName,
                "appid": "fae09bb8a74c921afe4884502f4ecb5f"
            ]
            return .requestParameters(parameters: headerParameters, encoding: URLEncoding.default)
        case .fourDays(let cityName):
            let headerParameters: [String: Any] = [
                "q": cityName,
                "appid": "fae09bb8a74c921afe4884502f4ecb5f"
            ]
            return .requestParameters(parameters: headerParameters, encoding: URLEncoding.default)
        }
    }
}

extension WeatherAPI {
    enum StubbedDataType: String {
        case HourlyWeatherResponse
        case CurrentWeatherResponse
    }
    
    var sampleData: Data {
        switch self {
        case .today:
            return stubbedResponse(fileName: StubbedDataType.CurrentWeatherResponse.rawValue)
        default:
            return stubbedResponse(fileName: StubbedDataType.HourlyWeatherResponse.rawValue)
        }
    }
}