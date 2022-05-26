//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Yash Mundhada on 26/05/22.
//

import Foundation

struct WeatherModel{
    let coditionID: Int
    let temp: Double
    let cityName: String
    
    var tempratureString: String{
        return String(format: "%.1f", temp)
    }
    
    
    var conditionName: String{
        switch coditionID{
        case 200...232:
            return "cloud.bolt"
            
        case 300...321:
            return "cloud.drizzle"
            
        case 500...531:
            return "cloud.rain"
            
        case 600...622:
            return "cloud.snow"
            
        case 701...781:
            return "cloud.fog"
            
        case 800:
            return "sun.max"
            
        case 801...804:
            return "cloud.bolt"
            
        default:
            return "cloud"
        }
    }
    
    
    
}
