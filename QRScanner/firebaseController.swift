//
//  firebaseController.swift
//  QRScanner
//
//  Created by Rudra Rupani on 5/24/20.

import Foundation
import Firebase

class fireBaseController{
    let currentPhoneIdentifier = model.identifier
    var shopID = ""
    var time = [Double]()
    var counterTime = 0
    let itemConst = 0.1
    var shortestTime = [Int]()
    var counterMaxCount = 0
    
    let refObj = Database.database().reference()
    func addCustomer(counterID: Int, itemCount:Int) -> Double{
        refObj.child("projecteasyQ/shopId\(shopID)/CountedId\(counterID)/customerId\(currentPhoneIdentifier)").setValue(["itemCount": itemCount])
        refObj.child("projecteasyQ/shopId\(shopID)/CountedId\(counterID)/estimatedTime\(counterID)").observeSingleEvent(of: .value){
            (snapshot) in
            self.counterTime = snapshot.value as! Int
            
        }
        let time = (Double(itemCount) * itemConst) + Double(counterTime)
        refObj.child("projecteasyQ/shopId\(shopID)/CountedId\(counterID)/estimatedTime\(counterID)").setValue(time)
        
        return time
        
    }
    func deleteCustomer(counterID: Int, itemCount: Int){
        refObj.child("projecteasyQ/shopId\(shopID)/CountedId\(counterID)/customerId\(currentPhoneIdentifier)").removeValue()
        refObj.child("projecteasyQ/shopId\(shopID)/CountedId\(counterID)/estimatedTime\(counterID)").observeSingleEvent(of: .value){
            (snapshot) in
            self.counterTime = snapshot.value as! Int
            
        }
        refObj.child("projecteasyQ/shopId\(shopID)/CountedId\(counterID)/estimatedTime\(counterID)").setValue(Double(counterTime) - (Double(itemCount) * itemConst))
    }
    func findShortestLine() -> Int{
        for index in 0...counterMaxCount{
            refObj.child("projecteasyQ/shopId\(shopID)/CountedId\(index)/estimatedTime\(index)").observeSingleEvent(of: .value){
                (snapshot) in
                self.shortestTime.append(index)
            }
        }
        return shortestTime.min()!
    }
}
