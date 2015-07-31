//
//  ViewController.swift
//  CBMyPhone
//
//  Created by LJ on 15/7/31.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate {

    @IBOutlet weak var list: UITableView!
    
    var valiableArr = [AnyObject](){
        didSet{
            list.reloadData()
        }
    }
    var manager:CBCentralManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager(delegate: self, queue: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func scanAction(sender: AnyObject) {
        manager?.scanForPeripheralsWithServices(nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:true])
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valiableArr.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = valiableArr[indexPath.row] as? String
        return cell
    }
    func centralManagerDidUpdateState(central: CBCentralManager!){
        
    }
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        println(peripheral.name)
    }
    
}

