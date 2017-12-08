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
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var webView2: WKWebView!
    var selectedImage: String?
    var weather: [String: String]?
    var forecast: [String: String]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let body = weather {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += "<font face=\"verdana\" color=\"#F5A696\">"
            html += "weather: " + (body["weather"])!
            html += "<br/>"
            html += "temperature: " + (body["temperature"])! + "˚C"
            html += "<br/>"
            html += "humidity: " + (body["humidity"])! + "%"
            html += "<br/>"
            html += "</font>"
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
            let urlString: String
            urlString = "https://openweathermap.org/img/w/" + (body["icon"])! + ".png"
            if let url = URL(string: urlString) {
                if let iconData = try? Data(contentsOf: url) {
                    imageView.image  = UIImage(data: iconData)
                }
            }
            
        }
        super.viewDidLoad()
        if let body = forecast {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += "<font face=\"verdana\" color=\"#F5A696\">"
            html += "weather: " + (body["weather"])!
            html += "<br/>"
            html += "temperature: " + (body["temperature"])! + "˚C"
            html += "<br/>"
            html += "humidity: " + (body["humidity"])! + "%"
            html += "<br/>"
            html += "</font>"
            html += "</body>"
            html += "</html>"
            webView2.loadHTMLString(html, baseURL: nil)
            let urlString: String
            urlString = "https://openweathermap.org/img/w/" + (body["icon"])! + ".png"
            if let url = URL(string: urlString) {
                if let iconData = try? Data(contentsOf: url) {
                    imageView2.image  = UIImage(data: iconData)
                }
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
