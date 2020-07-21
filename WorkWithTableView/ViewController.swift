//
//  ViewController.swift
//  WorkWithTableView
//
//  Created by Apple on 21/07/20.
//  Copyright © 2020 TestOrganization. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    //#MARK: Outlets
    @IBOutlet weak var directoryTableView: NSTableView!
    
    //#MARK: Declaration
    var employeeData = [EmployeeDetails(empId: "1231", name: "name1", joiningDate: "1/1/20", projectName: "project1", address: "address1"),
                        EmployeeDetails(empId: "1232", name: "name2", joiningDate: "2/1/20", projectName: "project2", address: "address2"),
    EmployeeDetails(empId: "1233", name: "name3", joiningDate: "3/1/20", projectName: "project3", address: "address3"),
    EmployeeDetails(empId: "1234", name: "name4", joiningDate: "4/1/20", projectName: "project4", address: "address4"),
    EmployeeDetails(empId: "1235", name: "name5", joiningDate: "5/1/20", projectName: "project5", address: "address5")]
    
    //#MARK: Default view methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

    }
    
    func setupTableView() {
        directoryTableView.dataSource = self
        directoryTableView.delegate = self
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Delete Row", action: #selector(tableViewDeleteItemClicked(_:)), keyEquivalent: ""))
        directoryTableView.menu = menu
        
//        if let tableData = UserDefaults.value(forKey: "tableSortedData") {
//            self.employeeData = (tableData as! NSArray) as! [EmployeeDetails]
//            directoryTableView.reloadData()
//        }
    }

    @objc private func tableViewDeleteItemClicked(_ sender: AnyObject) {
        guard directoryTableView.clickedRow >= 0 else { return }
        employeeData.remove(at: directoryTableView.clickedRow)
        directoryTableView.reloadData()
    }
}

extension ViewController : NSTableViewDataSource, NSTableViewDelegate {
    
    //#MARK: TableView functions
    func numberOfRows(in tableView: NSTableView) -> Int {
        employeeData.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        let cellId = tableColumn!.identifier.rawValue
        switch cellId {
        case "employeeId":
            return employeeData[row].empId
        case "nameCell":
            return employeeData[row].name
        case "joiningDateCell":
            return employeeData[row].joiningDate
        case "projectCell":
            return employeeData[row].projectName
        case "addressCell":
            return employeeData[row].address
        default:
            return " "
        }
    }

    
   func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        
        let dataArrayMutable = NSMutableArray(array: self.employeeData)
        print("before :", dataArrayMutable)
        dataArrayMutable.sort(using: tableView.sortDescriptors)
        print("after :", dataArrayMutable)
        self.employeeData = (dataArrayMutable as NSArray) as! [EmployeeDetails]
        directoryTableView.reloadData()
   }
    
}

@objcMembers class EmployeeDetails: NSObject {
    var empId: String
    var name: String
    var joiningDate: String
    var projectName: String
    var address: String

    init(empId:String, name:String, joiningDate:String, projectName:String, address:String) {
        self.empId = empId
        self.name = name
        self.joiningDate = joiningDate
        self.projectName = projectName
        self.address = address
    }
}
