//
//  SearchResultsViewController.swift
//  Wyld
//
//  Created by Hector Enrique Gomez Morales on 6/16/14.
//  Copyright (c) 2014 Hector Enrique Gomez Morales. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
                            
    @IBOutlet var appsTableView: UITableView
    var tableData: NSArray = []
    var api: APIController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.searchItunesFor("JQ Software")
        self.api.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        var resultsArr = results["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = resultsArr
            self.appsTableView.reloadData()
            })
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let kCellIdentifier = "SearchResultCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        
        var rawData = self.tableData[indexPath.row] as NSDictionary
        
        cell.text = rawData["trackName"] as String
        
        var urlString = rawData["artworkUrl60"] as NSString
        var imgURL = NSURL(string: urlString)
        
        var imgData = NSData(contentsOfURL: imgURL)
        cell.image = UIImage(data: imgData)
        
        var formattedPrice = rawData["formattedPrice"] as NSString

        cell.detailTextLabel.text = formattedPrice
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var rowData = self.tableData[indexPath.row] as NSDictionary
        
        var name = rowData["trackName"] as String
        var formattedPrice = rowData["formattedPrice"] as String
        
        var alert = UIAlertView()
        alert.title = name
        alert.message = formattedPrice
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
}

