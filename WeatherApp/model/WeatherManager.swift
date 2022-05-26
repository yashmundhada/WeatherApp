//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Yash Mundhada on 26/05/22.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManagaer: WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=eb22cd4191b26cc9f681617b6e86d3c6&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func featchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWheather(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //1.create a url
        if let url = URL(string: urlString){
            
            //2.create a url session
            let session = URLSession(configuration: .default)
            
            //3.give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
            }
            
            //4.start the task
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData:Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(coditionID: id, temp: temp, cityName: name)
            return weather
            
            
            
            
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }

    }
    
    
}
