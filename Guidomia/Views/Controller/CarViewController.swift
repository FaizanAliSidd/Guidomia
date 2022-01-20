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
    let offset = CGSize(width: 0, height: 0)
    @IBOutlet weak var makeShadowView: UIView!
    @IBOutlet weak var modelShadowlView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var makeTxtField: UITextField!
    
    @IBOutlet weak var modelTxtField: UITextField!
    var viewModel: CarVM?
    var hiddenSections = Set<Int>()
    let dropDown = MakeDropDown()
    var header = Bundle.main.loadNibNamed(CarViewHeaderCell.nibName, owner: self, options: nil)?.first as! CarViewHeaderCell
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel = CarVM()
        self.navigationController?.setBarColor()
        self.navigationController?.setLeftTitle(label: Constants.navigationTitle)
        prepareViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        //Call this in viewDidAppear to get correct frame values
        setUpDropDownForMakeView(dropDownView: makeShadowView)
        setUpDropDownForMakeView(dropDownView: modelShadowlView)
    }
  
    private func prepareViews() {
        
        tableView.separatorStyle = .none
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.estimatedRowHeight = Constants.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        self.addShadow(view: makeShadowView,
                      opacity: 0.5,
                      color: .black,
                      offset: offset,
                      radius: 3)
        
        self.addShadow(view: modelShadowlView,
                              opacity: 0.5,
                              color: .black,
                              offset: offset,
                              radius: 3)
        
        [modelShadowlView, makeShadowView, filterView].forEach({ $0?.layer.cornerRadius = Constants.viewRadius; })
        let carHeaderView = UINib(nibName: CarViewHeaderCell.nibName, bundle: nil)
        self.tableView.register(carHeaderView, forCellReuseIdentifier: CarViewHeaderCell.identifier)
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
           
           dropDown.makeDropDownIdentifier = DropDownCell.dropDownIdentifier
           dropDown.cellReusableIdentifier = DropDownCell.identifier
           dropDown.makeDropDownDataSourceProtocol = self
           dropDown.setUpDropDown(viewPositionReference: (self.view.getConvertedFrame(fromSubview: dropDownView) ?? dropDownView.frame), offset: 2)
           dropDown.nib = UINib(nibName: DropDownCell.nibName, bundle: nil)
           dropDown.setRowHeight(height: DropDownCell.dropDownRowHeight)
           dropDown.width = dropDownView.frame.width
           self.view.addSubview(dropDown)
       }

    
    func addShadow(view : UIView, opacity: Float = 1.0, color: UIColor, offset: CGSize, radius: CGFloat) {
        
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowColor = color.cgColor
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }
    
    @IBAction func makeBtnAction(_ sender: UIButton) {
        
        print("make filter btn")
        self.dropDown.showDropDown(height: DropDownCell.dropDownRowHeight * 5)
    }
    
    @IBAction func modelBtnAction(_ sender: UIButton) {
    
        print("model filter btn")
        self.dropDown.showDropDown(height: DropDownCell.dropDownRowHeight * 5)
    }
}

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
//MARK:- CarVM Delegate -
extension CarViewController: CarVMDelegate {
    
    func updateCarModel() {
        
        self.tableView.reloadData()
    }
}

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

