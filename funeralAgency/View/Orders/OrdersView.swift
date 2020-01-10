//
//  OrdersView.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class DarkTableViewCell: UITableViewCell {
    static let ReuseID = "AHAHAH"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        textLabel?.textColor = .systemRed
        detailTextLabel?.textColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class OrdersView: UITableViewController {
    let viewModel: OrdersViewModelProtocol = OrdersViewModel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DarkTableViewCell.self, forCellReuseIdentifier: DarkTableViewCell.ReuseID)
        
        viewModel.getAll { (result) in
            switch result {
            case .success(let array):
                self.data = array
            case .failure(let error):
                self.data = [ Order(nameCustomer: "Error loading", phoneNumberCustomer: error, dateee: nil) ]
            }
        }
    }
    
    var data = [Order]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
}
