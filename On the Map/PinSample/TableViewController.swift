//
//  TableViewController.swift
//  PinSample
//
//  Created by Ebraham Alskaf on 13/06/2024.
//  Copyright © 2024 Udacity. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    
    // Add observer for new location notification
    NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: .didAddLocation, object: nil)
    }
    
    @objc func reloadTableView() {
        tableView.reloadData()
    }
    
    func setupRefreshControl() {
            refreshControl = UIRefreshControl()
            refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            tableView.addSubview(refreshControl!)
        }
        
        @objc func refreshData() {
            tableView.reloadData()
            refreshControl?.endRefreshing()
        }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationsDataSource.shared.locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        let location = LocationsDataSource.shared.locations[indexPath.row]
        cell.textLabel?.text = "\(location.firstName) \(location.lastName)"
        cell.detailTextLabel?.text = location.linkedinURL
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = LocationsDataSource.shared.locations[indexPath.row]
        if let urlString = location.mediaURL, let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
