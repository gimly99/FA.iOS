//
//  OrdersTableViewController.swift
//  funeralAgency
//
//  Created by user on 21/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit


class OrdersTableViewController: UITableViewController {
    
    var token: String?
    
    override func viewDidLoad() {
        tableView.register(DarkTableViewCell.self, forCellReuseIdentifier: DarkTableViewCell.ReuseID)
        tableView.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let url = URL(string: "http://localhost:3200")!.appendingPathComponent("all")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let data = data {
                print(String(data: data, encoding: .utf8))
                let dec = JSONDecoder()
                dec.dateDecodingStrategy = .iso8601
                let lolkek = try? dec.decode([Data].self, from: data)
                self.data = lolkek ?? [Data(nameCustomer: "Error loading", phoneNumberCustomer: "", dateee: nil)]
            }
            else {
                self.data = [Data(nameCustomer: "Error loading", phoneNumberCustomer: "", dateee: nil)]
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
    
    struct Data: Codable {
        let nameCustomer: String
        let phoneNumberCustomer: String
        let dateee: Date?
    }
    
    var decoder = JSONDecoder()
    
    var data = [Data(nameCustomer: "Loading", phoneNumberCustomer: "", dateee: nil)]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DarkTableViewCell.ReuseID) as! DarkTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        
        cell.textLabel?.text = data[indexPath.row].nameCustomer
        if let date = data[indexPath.row].dateee {
            cell.detailTextLabel?.text = dateFormatter.string(from: date) + "  " + data[indexPath.row].phoneNumberCustomer
        }
        return cell
    }
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let session = URLSession.shared
        let url = URL(string: "http://localhost:3200")!.appendingPathComponent("logout")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Authorization": "Beaver \(token ?? "")"]
        DispatchQueue.main.async {
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                    print("No valid response")
                    return
                }

                guard 200 ~= httpResponse.statusCode else {
                    print("Status code was \(httpResponse.statusCode), but expected 2xx")
                    return
                }
        
                if httpResponse.statusCode == 200 {
                    let alert = UIAlertController(title: "SUCCESS", message: "You successfully loged out", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    
                }
                else {
                    let alertError = UIAlertController(title: "unsuccess", message: "u didnt log out", preferredStyle: .alert)
                    alertError.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                }

            }
        // everything OK, process `data` here
        }
    }
}
