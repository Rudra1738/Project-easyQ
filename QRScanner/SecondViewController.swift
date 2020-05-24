//
//  SecondViewController.swift
//  QRScanner
//
//  Created by Rudra Rupani on 5/24/20.

import Foundation
import UIKit

class secondViewController: UIViewController{
    var segueToScreen = false
    let fbDatabase = fireBaseController()
    var qrdata = ""
    var items = ""
    var line = 0
    var time = 0.0
    
    override func viewDidLoad() {
        if segueToScreen == true{
            fbDatabase.shopID = qrdata
            line = fbDatabase.findShortestLine()
            time = fbDatabase.addCustomer(counterID: line, itemCount: Int(items)!)
        }
        counterNo.text = String(line)
        estimatedTime.text = String(time)
    }
    @IBOutlet weak var counterNo: UILabel!
    @IBOutlet weak var estimatedTime: UILabel!
    
    @IBAction func doneShopping(_ sender: UIButton) {
        fbDatabase.deleteCustomer(counterID: line, itemCount: Int(items)!)
    }
}
