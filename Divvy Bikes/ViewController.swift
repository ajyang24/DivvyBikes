//
//  ViewController.swift
//  Divvy Bikes
//
//  Created by Andrew Yang on 6/26/17.
//  Copyright © 2017 Andrew Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var myTableView: UITableView!
    var stations = [[String: String]]()
    
    override func viewDidLoad()
        
    {
        super.viewDidLoad()
        let urlstring = "https://feeds.divvybikes.com/stations/stations.json"
        if let url = URL(string: urlstring)
        {
            if let myData = try? Data(contentsOf: url, options: [])
            {
                let json = JSON(myData)
                parse(myData: json)
            }
        }
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let station = stations[indexPath.row]
        cell.textLabel?.text = station["stationName"]
        cell.detailTextLabel?.text = station["statusValue"]
        return cell
    }

    func parse(myData:JSON)
    {
        for i in myData["stationBeanList"].arrayValue
        {
            let statusValue = i["statusValue"].stringValue
            let stationName = i["stationName"].stringValue
            let availableDocks = i["availableDocks"].stringValue
            let availableBikes = i["availableBikes"].stringValue
            let totalDocks = i["totalDocks"].stringValue
            let latitude = i["latitude"].stringValue
            let longitude = i["longitude"].stringValue
            
            let obj = ["statusValue": statusValue, "stationName" : stationName, "availableDocks" : availableDocks, "availableBikes" : availableBikes, "totalDocks" : totalDocks, "latitude" : latitude, "longitude" : longitude]
            stations.append(obj)
        }
        
        myTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = myTableView.indexPathForSelectedRow
        {
            let station = stations[indexPath.row]
            let dvc = segue.destination as! DetailViewController
            dvc.detailItem = station
        }
    }



}

