//
//  ViewController.swift
//  Project1
//
//  Created by Alaniah Nisrina on 11/15/17.
//  Copyright © 2017 ISSE. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var cities : [String] = ["Kyoto,JP", "Kusatsu,JP", "Jakarta,ID", "Bangkok,TH", "Manila,PH"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Weather App"
        cities = defaults.object(forKey:"cityName") as? [String] ?? [String]()
        print(cities)
        
    }
    @IBAction func citySelect(_ sender: Any) {
        print("buttonpressed")
        let ac = UIAlertController(title: "Enter city name i.e. (city,country code)", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] (action: UIAlertAction) in
            let cityName = ac.textFields![0]
            self.cities.append(cityName.text!)
            self.tableView.reloadData()
            self.defaults.set(self.cities, forKey: "cityName")
        }

        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString: String
        let urlRope: String
        var jsonWeather: JSON?
        var jsonForecast: JSON?
        
        urlString =  "https://api.openweathermap.org/data/2.5/weather?q="+cities[indexPath.row]+"&appid=a5ff8344e2fbb334db408ba2738884f9&units=metric"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                jsonWeather = try! JSON(data: data)
            }
        }
        
        urlRope =  "https://api.openweathermap.org/data/2.5/forecast?q="+cities[indexPath.row]+"&appid=a5ff8344e2fbb334db408ba2738884f9&units=metric"
        if let url = URL(string: urlRope) {
            if let data = try? Data(contentsOf: url) {
                jsonForecast = try! JSON(data: data)
                print(jsonForecast)
            }
        }
        
        
        
        //print(jsonWeather!)
        //print(jsonForecast!)
        let weatherData = [
            "name": jsonWeather!["name"].stringValue,
            "temperature": "\(jsonWeather!["main"]["temp"].intValue)",
            "humidity": jsonWeather!["main"]["humidity"].stringValue,
            "weather": jsonWeather!["weather"][0]["main"].stringValue,
            "icon": jsonWeather!["weather"][0]["icon"].stringValue
        ]
        var fiveDays: Array<[String:String]> = Array()
        if let weatherItems = jsonForecast!["list"].array {
            for weatherItem in weatherItems {
                let dt = weatherItem["dt_txt"].string!
                let suffix = String(dt.suffix(8))
                if suffix == "12:00:00"{
                    print (weatherItem["dt_txt"])
                    let forecastData = [
                        "icon": weatherItem["weather"][0]["icon"].stringValue,
                        "minTemp": "\(weatherItem["main"]["temp_min"].intValue)",
                        "maxTemp": "\(weatherItem["main"]["temp_max"].intValue)",
                        "weather": weatherItem["weather"][0]["main"].stringValue
                    ]
                    fiveDays.append(forecastData)
                }
            }
        }
        print(fiveDays)
        
        
//        print(weatherData)
//        print(forecastData)
                // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                    // 2: success! Set its selectedImage property
                    
                    // 3: now push it onto the navigation controller
            vc.weather = weatherData
            vc.forecast = fiveDays
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            cities.remove(at: indexPath.row)
            tableView.reloadData()
            self.defaults.set(self.cities, forKey: "cityName")
        }
    }
}



