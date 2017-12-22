//
//  DetailViewController.swift
//  Project1
//
//  Created by Alaniah Nisrina on 11/15/17.
//  Copyright © 2017 ISSE. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var textLabel3: UILabel!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var textLabel4: UILabel!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var textLabel5: UILabel!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var textLabel6: UILabel!
    var weather: [String: String]?
    var forecast: Array<[String: String]>?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.74, green:0.82, blue:0.93, alpha:1.0)
        if let body = weather {
            title = (body["name"])
            textLabel.font = UIFont(name: textLabel.font.fontName, size: 28)
            textLabel.textColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.50, alpha: 1.0)
            textLabel.numberOfLines = 3
            textLabel.text =
                "Weather: " + (body["weather"])! +
                "\n" + "Temperature: " + (body["temperature"])! + "˚C" +
                "\n" + "Humidity: " + (body["humidity"])! + "%"
            
            let urlString: String
            urlString = "https://openweathermap.org/img/w/" + (body["icon"])! + ".png"
            if let url = URL(string: urlString) {
                if let iconData = try? Data(contentsOf: url) {
                    imageView.image  = UIImage(data: iconData)
                }
            }
            
        }
        placeWeather(forecast: forecast![0], icon: imageView2, text: textLabel2)
        placeWeather(forecast: forecast![1], icon: imageView3, text: textLabel3)
        placeWeather(forecast: forecast![2], icon: imageView4, text: textLabel4)
        placeWeather(forecast: forecast![3], icon: imageView5, text: textLabel5)
        placeWeather(forecast: forecast![4], icon: imageView6, text: textLabel6)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func placeWeather(forecast: [String: String], icon: UIImageView, text: UILabel) {
        text.font = UIFont(name: textLabel2.font.fontName, size: 14)
        text.textColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.50, alpha: 1.0)
        text.numberOfLines = 7
        text.textAlignment = .center
        text.text =
            (forecast["weather"])! +
            "\n" +
            "\n" + "Low:" + "\n" +
            (forecast["minTemp"])! + "˚C" +
            "\n" +
            "\n" + "High: " + "\n"
            + (forecast["maxTemp"])! + "˚C"
        
        let urlString: String
        urlString = "https://openweathermap.org/img/w/" + (forecast["icon"])! + ".png"
        if let url = URL(string: urlString) {
            if let iconData = try? Data(contentsOf: url) {
                icon.image = UIImage(data: iconData)
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
