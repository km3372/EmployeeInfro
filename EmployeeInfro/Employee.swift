//
//  Employee.swift
//  EmployeeInfro
//
//  Created by kenneth moody on 5/21/17.
//  Copyright © 2017 iMoody Studios. All rights reserved.
//

import Foundation


public struct Employee {
    
   // static let APIKEY = "" 
    // insert into URLRequested if needed "key=\(APIKEY)"
    
   public var name:String!
   public var surname:String!
   public  var email:String!
   public var photo:String!
   public  var role:String!
    
    
    public init(name:String, surname:String, email:String, photo:String, role:String) {
        
        
        self.name = name
        self.surname = surname
        self.email = email
        self.photo = photo
        self.role = role
    }
    
    private static func getEmployeeData (with completion:@escaping (_ success:Bool, _ object:AnyObject?)->()) {
        
        let session = URLSession(configuration: .default)
        
        let request  = URLRequest(url: URL(string: "http://nielsmouthaan.nl/backbase/members.php")!)
        
        session.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode{
                    completion(true, json as AnyObject?)
                    
                }else{
                    completion(false, json as AnyObject?)
            }
        }
    }.resume()
 }
    
    public static func nowPlaying (with completion:@escaping (_ sucess:Bool, _ employees:[Employee]?)->()) {
        Employee.getEmployeeData { (succes, object) in
            
            if succes {
                var employeeArray = [Employee]()
                
                if let departLead = object?["Launchpad"] as? [Dictionary<String,AnyObject>] {
                    for employee in departLead {
                    
                       
                        let name = employee["name"] as! String
                        let surname = employee["surname"] as! String
                        let emailAddress = employee["email"] as! String
                        let role = employee["role"] as! String
                        
                        
                        guard let posterImage = employee["photo"] as? String else {continue}
                        
                        let employeeObj = Employee(name: name, surname: surname, email: emailAddress, photo: posterImage, role: role)
                        
                        employeeArray.append(employeeObj)
                }
                    
                completion(true, employeeArray)
                    
                }else{
                    completion(false, nil)
                
                }
                
                if let departCXP = object?["CXP"] as? [Dictionary<String,AnyObject>] {
                    for employee in departCXP {
                        
                        
                        let name = employee["name"] as! String
                        let surname = employee["surname"] as! String
                        let emailAddress = employee["email"] as! String
                        let role = employee["role"] as! String
                        
                        
                        guard let posterImage = employee["photo"] as? String else {continue}
                            
                            
                        let employeeObj = Employee(name: name, surname: surname, email: emailAddress, photo: posterImage, role: role)
                        
                        employeeArray.append(employeeObj)
                    }
                    
                    completion(true, employeeArray)
                    
                }else{
                    completion(false, nil)
            }
                
                if let departMobile = object?["Mobile"] as? [Dictionary<String,AnyObject>] {
                    for employee in departMobile {
                        
                        
                        let name = employee["name"] as! String
                        let surname = employee["surname"] as! String
                        let emailAddress = employee["email"] as! String
                        let role = employee["role"] as! String
                        
                        
                        guard let posterImage = employee["photo"] as? String else {continue}
                        
                        let employeeObj = Employee(name: name, surname: surname, email: emailAddress, photo: posterImage, role: role)
                        
                        employeeArray.append(employeeObj)
                    }
                    
                    completion(true, employeeArray)
                    
                }else{
                    completion(false, nil)
                }
                
            
            }

        }

      }
    
    private static func getDocumentsDirectory () -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let documents:String = paths.first else {return nil}
        
        return documents
    }
    
    
}




    

