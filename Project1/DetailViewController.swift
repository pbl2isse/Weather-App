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
    var selectedImage: String?
    var weather: [String: String]?
    var forecast: Array<[String: String]>?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let body = weather {
            textLabel.font = UIFont(name: textLabel.font.fontName, size: 28)
            textLabel.textColor = UIColor(displayP3Red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
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
        super.viewDidLoad()
        let day1 = forecast![0]
        textLabel2.font = UIFont(name: textLabel2.font.fontName, size: 14)
        textLabel2.textColor = UIColor(displayP3Red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
        textLabel2.numberOfLines = 5
        textLabel2.text =
            (day1["weather"])! +
            "\n" +
            "\n" + "Low:" + (day1["minTemp"])! + "˚C" +
            "\n" +
            "\n" + "High: " + (day1["maxTemp"])! + "˚C"
        
        let urlString: String
        urlString = "https://openweathermap.org/img/w/" + (day1["icon"])! + ".png"
        if let url = URL(string: urlString) {
            if let iconData = try? Data(contentsOf: url) {
                imageView2.image = UIImage(data: iconData)
                
            }
        }
        
        
        
        title = selectedImage
        
        // Do any additional setup after loading the view.
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
