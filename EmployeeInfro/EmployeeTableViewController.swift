//
//  EmployeeTableViewController.swift
//  EmployeeInfro
//
//  Created by kenneth moody on 5/21/17.
//  Copyright © 2017 iMoody Studios. All rights reserved.
//

import UIKit

class EmployeeTableViewController: UITableViewController {
    
    var nowPlaying = [Employee]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    
    }

       func loadData() {
           
            Employee.nowPlaying { (success:Bool, employeeList:[Employee]?) in
                
                
                if success {
                    self.nowPlaying = employeeList!
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

        }
    
    }
        
       
 }
  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nowPlaying.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let staffList = nowPlaying[indexPath.row]
        
        cell.textLabel?.text = staffList.name
       // cell.textLabel?.text = Launchpad.surname
        cell.detailTextLabel?.text = staffList.role

        return cell
    }
    
 

 }
