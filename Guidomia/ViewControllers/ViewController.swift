//
//  ViewController.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeView: UILabel!
    @IBOutlet weak var modelView: UILabel!
    @IBOutlet weak var filterView: UIView!
    
    var viewModel: CarVM?
    var hiddenSections = Set<Int>()
    var header = Bundle.main.loadNibNamed(CarViewHeaderCell.nibName, owner: self, options: nil)?.first as! CarViewHeaderCell
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel = CarVM()
        prepareViews()
    }
    
    private func prepareViews() {
        
        tableView.separatorStyle = .none
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = Constants.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        [modelView, makeView, filterView].forEach({ $0?.layer.cornerRadius = Constants.viewRadius;
                                                    $0?.layer.masksToBounds = true })
        
        //let carHeaderView = UINib(nibName: CarViewHeaderCell.nibName, bundle: nil)
        //self.tableView.register(carHeaderView, forCellReuseIdentifier: CarViewHeaderCell.identifier)
    }
    @objc
    private func hideSection(sender: UITapGestureRecognizer) {
        
        print("Section tapped \(sender.view?.tag ?? 0)")
        // Create section let
        // Add indexPathsForSection method
        // Logic to add/remove sections to/from hiddenSections, and delete and insert functionality for tableView
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
                return 0
            }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CarCell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarCell
        cell.car = viewModel?.datasource?[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.datasource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed(CarViewHeaderCell.nibName, owner: self, options: nil)?.first as! CarViewHeaderCell
        header.car = viewModel?.datasource?[section]
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSection(sender:)))
        header.contentView.tag = section
        //tapRecognizer.delegate = self
        header.addGestureRecognizer(tapRecognizer)
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.reloadSections([indexPath.section], with: .none)
    }
}

