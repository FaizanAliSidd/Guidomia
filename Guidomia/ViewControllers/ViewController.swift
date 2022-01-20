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
    @IBOutlet weak var makeShadowView: UIView!
    @IBOutlet weak var modelShadowlView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var makeTxtField: UITextField!
    
    @IBOutlet weak var modelTxtField: UITextField!
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
        //tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = Constants.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        [modelShadowlView, makeShadowView, filterView].forEach({ $0?.layer.cornerRadius = Constants.viewRadius;
                                                    $0?.layer.masksToBounds = true })
        
        let carHeaderView = UINib(nibName: CarViewHeaderCell.nibName, bundle: nil)
        self.tableView.register(carHeaderView, forCellReuseIdentifier: CarViewHeaderCell.identifier)
    }
    @objc
    private func hideSection(sender: UITapGestureRecognizer) {
        
        print("Section tapped \(sender.view?.tag ?? 0)")
        // Create section let
        // Add indexPathsForSection method
        // Logic to add/remove sections to/from hiddenSections, and delete and insert functionality for tableView
    }
    @IBAction func makeBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func modelBtnAction(_ sender: UIButton) {
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.datasource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CarViewHeaderCell.identifier, for: indexPath) as! CarViewHeaderCell
        cell.car = viewModel?.datasource?[indexPath.row]
        cell.isExpanded = viewModel?.isExpandStatus[indexPath.row] ?? false
        cell.selectionStyle = .none
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let cell = tableView.cellForRow(at: indexPath) as?  CarViewHeaderCell else { return }
        cell.isExpanded = true
      
        //let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example

        //let currentCell = tableView.cellForRow(at: indexPath!) as! CarViewHeaderCell
        viewModel?.setExpandCollapseStatus(indexPath: indexPath)
        
        
        UIView.animate(withDuration: 0.3) {
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            self.tableView.reloadData()
        }
       

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat.leastNonzeroMagnitude
    }
}
//MARK:- CarVM Delegate -
extension ViewController: CarVMDelegate {
    
    func updateCarModel() {
        self.tableView.reloadData()
    }
}

