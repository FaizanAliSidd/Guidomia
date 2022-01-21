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
    @IBOutlet weak var makeTxtField: UITextField!
    @IBOutlet weak var modelTxtField: UITextField!
    var viewModel: CarViewModel?
    var hiddenSections = Set<Int>()
    let dropDown = MakeDropDown()
    let dropDown2 = MakeDropDown()
    let offset = CGSize(width: 0, height: 0)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel = CarViewModel()
        prepareViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
      //  setUpDropDownForMakeView(dropDownView: makeShadowView)
        setUpDropDownForModelView(dropDownView: modelShadowView)
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
        
        let carCellNib = UINib(nibName: CarViewHeaderCell.nibName, bundle: nil)
        self.tableView.register(carCellNib, forCellReuseIdentifier: CarViewHeaderCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.estimatedRowHeight = Constants.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    /// Add shadow and corner radius on filter view textfields
    private func addShadowAndCornerRadius() {
        
        makeShadowView.addShadow(opacity: Constants.shadowOpacity, color: .black, offset: offset, radius: Constants.shadowRadius)
        modelShadowView.addShadow(opacity: Constants.shadowOpacity, color: .black, offset: offset, radius: Constants.shadowRadius)
        [modelShadowView, makeShadowView, filterView].forEach({ $0?.layer.cornerRadius = Constants.viewRadius; })
    }
    
    func setUpDropDownForMakeView(dropDownView : UIView){
        
        dropDown.makeDropDownIdentifier = DropDownCell.dropDownIdentifier
        dropDown.cellReusableIdentifier = DropDownCell.identifier
        dropDown.makeDropDownDataSourceProtocol = self
        dropDown.setUpDropDown(viewPositionReference: (self.view.getConvertedFrame(fromSubview: dropDownView) ?? dropDownView.frame), offset: 2)
        dropDown.nib = UINib(nibName: DropDownCell.nibName, bundle: nil)
        dropDown.setRowHeight(height: DropDownCell.dropDownRowHeight)
        dropDown.width = dropDownView.frame.width
        self.view.addSubview(dropDown)
    }
    
    func setUpDropDownForModelView(dropDownView : UIView){
        
        dropDown2.makeDropDownIdentifier = DropDownCell.dropDownIdentifier
        dropDown2.cellReusableIdentifier = DropDownCell.identifier
        dropDown2.makeDropDownDataSourceProtocol = self
        dropDown2.setUpDropDown(viewPositionReference: (self.view.getConvertedFrame(fromSubview: dropDownView) ?? dropDownView.frame), offset: 2)
        dropDown2.nib = UINib(nibName: DropDownCell.nibName, bundle: nil)
        dropDown2.setRowHeight(height: DropDownCell.dropDownRowHeight)
        dropDown2.width = dropDownView.frame.width
        self.view.addSubview(dropDown2)
    }
    
    /// Make filter button action
    @IBAction func makeBtnAction(_ sender: UIButton) {
        
        dropDown.makeDropDownIdentifier = DropDownCell.dropDownIdentifier
        dropDown.cellReusableIdentifier = DropDownCell.identifier
        dropDown.makeDropDownDataSourceProtocol = self
        dropDown.setUpDropDown(viewPositionReference: (self.view.getConvertedFrame(fromSubview: makeShadowView) ?? makeShadowView.frame), offset: 2)
        dropDown.nib = UINib(nibName: DropDownCell.nibName, bundle: nil)
        dropDown.setRowHeight(height: DropDownCell.dropDownRowHeight)
        dropDown.width = makeShadowView.frame.width
        self.view.addSubview(dropDown)
        
        self.dropDown.showDropDown(height: DropDownCell.dropDownRowHeight * 5)
    }
    
    /// Model filter button action
    @IBAction func modelBtnAction(_ sender: UIButton) {
    
        self.dropDown2.showDropDown(height: DropDownCell.dropDownRowHeight * 5)
    }
}

//MARK:- TableView DataSource and Delegate
extension CarViewController: UITableViewDelegate, UITableViewDataSource {
    
    
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
        
        guard let cell = tableView.cellForRow(at: indexPath) as?  CarViewHeaderCell else { return }
        cell.isExpanded = true
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

//MARK:- DropDown DataSource
extension CarViewController: MakeDropDownDataSourceProtocol{
    
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, makeDropDownIdentifier: String) {
        
        if makeDropDownIdentifier == DropDownCell.dropDownIdentifier{
            
            let dropDownCell = cell as! DropDownCell
            dropDownCell.dropDownTitle.text = "Test"
            //customCell..text = self.cityModelArr[indexPos].countryName
        }
    }
    
    func numberOfRows(makeDropDownIdentifier: String) -> Int {
        
        //return self.cityModelArr.count
        return 5
    }
    
    func selectItemInDropDown(indexPos: Int, makeDropDownIdentifier: String) {
        
        //self.makeTxtField.text = "Country: \(self.cityModelArr[indexPos].countryName))"
        self.makeTxtField.text = "Test"
        self.dropDown.hideDropDown()
    }
}

