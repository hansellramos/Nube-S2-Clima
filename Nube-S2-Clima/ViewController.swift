//
//  ViewController.swift
//  Nube-S2-Clima
//
//  Created by Hansel Ramos Osorio on 10/12/16.
//  Copyright © 2016 Hansel Ramos Osorio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var ciudades: Array<Array<String>> = Array<Array<String>>()

    @IBOutlet weak var lblCiudad: UILabel!
    @IBOutlet weak var lblTemperatura: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ciudades.append(["Barranquilla","barranquilla","co"])
        ciudades.append(["Medellín","medellin","co"])
        ciudades.append(["Bogotá","bogota","co"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.ciudades[row][0]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let urls = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(self.ciudades[row][1])%2C%20\(self.ciudades[row][2])%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        let url = URL(string: urls)
        let datos = NSData(contentsOf: url!)
        do{
            let json = try JSONSerialization.jsonObject(with: datos! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            let dico1 = json as! NSDictionary
            let dico2 = dico1["query"] as! NSDictionary
            let dico3 = dico2["results"] as! NSDictionary
            let dico4 = dico3["channel"] as! NSDictionary
            let dico5 = dico4["location"] as! NSDictionary
            self.lblCiudad.text = "Ciudad: \(dico5["city"] as! NSString as String), \(dico5["country"] as! NSString as String)"
            let dico6 = dico4["item"] as! NSDictionary
            let dico7 = dico6["condition"] as! NSDictionary
            self.lblTemperatura.text = "Temp: \(dico7["temp"] as! NSString as String)ºF"
        }catch _ {
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    return self.ciudades.count
    
    }


}

