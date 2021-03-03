//
//  WeatherManager.swift
//  Clima
//
//  Created by Ziyi Zhang on 2/21/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=1197a308c84b45d227c3c65b3e386cc5&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performrequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        print(urlString)
        performrequest(with: urlString)
    }
    
    func performrequest(with urlString: String) {
        // 1. create an url
        if let url = URL(string: urlString) {
            // 2. create a urlSession
            let session = URLSession(configuration: .default)
            // 3. give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    // inside closure, need to add self.
                    if let weather = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // 4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) ->WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            print(weather.temperatureString)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
