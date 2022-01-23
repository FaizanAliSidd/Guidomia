//
//  ViewController.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeShadowView: UIView!
    @IBOutlet weak var modelShadowView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var modelButton: UIButton!
    var viewModel = CarViewModel()
    let dropDown = MakeDropDown()
    let offset = CGSize.zero
    var isDropdownShown = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel = CarViewModel()
        prepareViews()
        prepareDropDown()
    }
    
    /// Prepare Views to load
    private func prepareViews() {
        
        prepareNavBar()
        prepareTableView()
        addShadowAndCornerRadius()
    }
    
    /// Prepare Navigation Bar
    private func prepareNavBar() {
        
        self.navigationController?.setBarAppearance()
        self.navigationController?.setNavBarTitle(label: Constants.navigationTitle)
    }
    
    /// Prepare TableView to Show Car List
    private func prepareTableView() {
        
        let carCellNib = UINib(nibName: Constants.carCellNibName, bundle: nil)
        self.tableView.register(carCellNib, forCellReuseIdentifier: Constants.carCellIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.estimatedRowHeight = Constants.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    /// Add shadow and corner radius on filter view textfields
    private func addShadowAndCornerRadius() {
        
        makeShadowView.addShadow(opacity: Constants.shadowOpacity,
                                 color: .black,
                                 offset: offset,
                                 radius: Constants.shadowRadius)
        modelShadowView.addShadow(opacity: Constants.shadowOpacity,
                                  color: .black,
                                  offset: offset,
                                  radius: Constants.shadowRadius)
        [modelShadowView, makeShadowView, filterView].forEach({ $0?.layer.cornerRadius = Constants.viewRadius })
    }
    
    /// Prepare dropdown
    private func prepareDropDown() {
        dropDown.cellReusableIdentifier = Constants.dropDownCellIdentifier
        dropDown.makeDropDownDataSourceProtocol = self
    }
    
    /// Method to hide dropdown and update dropdown shown status
    private func removeDropdown() {
        self.dropDown.hideDropDown()
        self.isDropdownShown = false
    }
    
    /// Make filter button action
    @IBAction func makeBtnAction(_ sender: UIButton) {
        
        if self.isDropdownShown {
            removeDropdown()
        }else{
            if self.viewModel.fileteredArr.count < self.viewModel.datasource.count && !self.viewModel.makeArr.contains(Constants.clearFilterString) {
                
                self.viewModel.makeArr.insert(Constants.clearFilterString, at: 0)
            }
            self.showDropDownFor(view: makeShadowView,
                                 withIdentifier: Constants.makeDropDownIdentifier,
                                 dataArray: self.viewModel.makeArr)
        }
    }
    
    /// Model filter button action
    @IBAction func modelBtnAction(_ sender: UIButton) {
        
        if self.isDropdownShown {
            removeDropdown()
        }else {
            self.showDropDownFor(view: modelShadowView,
                                 withIdentifier: Constants.modelDropDownIdentifier,
                                 dataArray: self.viewModel.modelArr)
        }
    }
    
    /// Method to show dropdown when button is pressed
    /// - Parameters:
    ///  - dropDownView: View for which dropdown iis to be added
    ///  - identifier: dropdown identifier
    ///  - dataArray: data array to be shown in the dropdown
    private func showDropDownFor(view dropDownView : UIView, withIdentifier identifier : String,  dataArray : [String]) {
        
        self.isDropdownShown = true
        dropDown.makeDropDownIdentifier = identifier
        dropDown.setUpDropDown(viewPositionReference: (self.view.getConvertedFrame(fromSubview: dropDownView ) ?? dropDownView.frame), offset: 2)
        dropDown.nib = UINib(nibName: Constants.dropDownCellNibName, bundle: nil)
        dropDown.setRowHeight(height: DropDownCell.dropDownRowHeight)
        dropDown.width = dropDownView.frame.width
        self.view.addSubview(dropDown)
        self.dropDown.showDropDown(height: DropDownCell.dropDownRowHeight * CGFloat(dataArray.count))
    }
}

//MARK:- TableView DataSource and Delegate
extension CarViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.fileteredArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.carCellIdentifier, for: indexPath) as! CarViewHeaderCell
        cell.car = viewModel.fileteredArr[indexPath.row]
        cell.isExpanded = viewModel.isExpandStatus[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as?  CarViewHeaderCell else { return }
        cell.isExpanded = true
        viewModel.setExpandCollapseStatus(indexPath: indexPath)
        UIView.animate(withDuration: 0.3) {
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat.leastNonzeroMagnitude
    }
    
}

//MARK:- DropDown DataSource
extension CarViewController: MakeDropDownDataSourceProtocol{
    
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, makeDropDownIdentifier: String) {
        
        if makeDropDownIdentifier == Constants.makeDropDownIdentifier {
            let dropDownCell = cell as! DropDownCell
            dropDownCell.dropDownTitle.text = self.viewModel.makeArr[indexPos]
        }
        else {
            let dropDownCell = cell as! DropDownCell
            dropDownCell.dropDownTitle.text = self.viewModel.modelArr[indexPos]
        }
    }
    
    func numberOfRows(makeDropDownIdentifier: String) -> Int {
        
        if makeDropDownIdentifier == Constants.makeDropDownIdentifier {
            return self.viewModel.makeArr.count
        }else {
            return self.viewModel.modelArr.count
        }
    }
    
    func selectItemInDropDown(indexPos: Int, makeDropDownIdentifier: String) {
        
        if makeDropDownIdentifier == Constants.makeDropDownIdentifier {
            if self.viewModel.makeArr[indexPos] != Constants.clearFilterString {
                self.makeTextField.text = self.viewModel.makeArr[indexPos]
                self.filterArrayWith(title: self.viewModel.makeArr[indexPos], makeDropDownIdentifier: makeDropDownIdentifier)
                self.viewModel.modelArr = self.viewModel.fileteredArr.map({ car -> String in
                    if car.make == self.viewModel.makeArr[indexPos] {
                        return car.model
                    }else {
                        return ""
                    }
                })
                self.modelTextField.text = Constants.empty
                
            }
            else{
                self.clearFilter()
            }
        }else {
            self.modelTextField.text = self.viewModel.modelArr[indexPos]
            self.filterArrayWith(title: self.viewModel.modelArr[indexPos], makeDropDownIdentifier: makeDropDownIdentifier)
        }
        removeDropdown()
    }
    
    func filterArrayWith(title: String, makeDropDownIdentifier: String) {
        if makeDropDownIdentifier == Constants.makeDropDownIdentifier {
            self.viewModel.fileteredArr = self.viewModel.datasource.filter({ $0.make == title })
        }else {
            self.viewModel.fileteredArr = self.viewModel.datasource.filter({ $0.model == title })
        }
        self.tableView.reloadData()
    }
    
    func clearFilter() {
        
        self.makeTextField.text = Constants.empty
        self.modelTextField.text = Constants.empty
        self.viewModel.makeArr.remove(at: 0)
        viewModel = CarViewModel()
        //self.viewModel.fileteredArr = self.viewModel.datasource
        self.tableView.reloadData()
    }
}
