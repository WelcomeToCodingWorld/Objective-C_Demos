//
//  ViewController.swift
//  TableViewDemo
//
//  Created by zz on 2017/2/10.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,URLSessionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let rect = CGRect(x: 0, y: 20, width: 375, height: 500);
        
        let table  = UITableView(frame:rect, style:.grouped);
        
        table.delegate = self;
        table.dataSource = self;
        table.register(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: "CellID");
        self.view.addSubview(table);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let controller = DetailViewController();
        
        self.navigationController?.pushViewController(controller, animated:true)
    }
    
    func loadOrder() {
        let url = URL(string: "http://localhost/index1.php?uid=00001");
        let request = NSURLRequest(url: url!);
        
        let configuration = URLSessionConfiguration();
        configuration.allowsCellularAccess = true;
        configuration.httpShouldSetCookies = true;
        configuration.networkServiceType = .default;
        
        
        let queue = OperationQueue();
        
        
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:queue)
        
        let task = URLSessionDataTask();
        session.dataTask(with: url!);
        
        
        
    }
    
    
    let  data:Array = ["gaewerw","dgweg","dsgwergt"];
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID");
        cell?.accessoryType = .detailDisclosureButton;
        cell?.selectionStyle = .none;
        cell?.textLabel?.text = data[indexPath.row];
        cell?.detailTextLabel?.text = String(indexPath.row);
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
}

