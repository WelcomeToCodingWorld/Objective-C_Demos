//
//  ViewController.swift
//  RequestDemo
//
//  Created by zz on 2017/3/15.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController,UITableViewDelegate {
    
    fileprivate var products = NSMutableArray();
    fileprivate var users = NSMutableArray();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tableRect = CGRect(x: 0, y: 0, width: 375, height: 580)
        
        let table = UITableView(frame: tableRect, style:.plain);
        
        table.delegate = self
        table.tableFooterView = UIView();
        self.view.addSubview(table)
        self.loadData()
        
    }
    
//    struct User {
//        var name: String
//        var age : UInt
//        var address : String
//        var gender : Bool
//        var phone:String
//    }
    
    
    func loadData() {
        //create session configuration
        let defaualtConfiguration = URLSessionConfiguration.default;
//        let ephemeralConfiguration = URLSessionConfiguration.ephemeral;
//        let backgoundConfiguration = URLSessionConfiguration.background(withIdentifier: "com.myapp.networking.background");
        
        //configuring caching behavior for the default session
        let fileManager = FileManager.default;
        let cacheDirectoryUrl = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first;
        let cacheUrl = cacheDirectoryUrl?.appendingPathComponent("MyCache");
        var diskPath = cacheUrl?.path;
        
        /* Note:
         
         iOS requires the cache path to be
         
         a path relative to the ~/Library/Caches directory,
         
         but OS X expects an absolute path.
         
         */
        #if os(OSX)
            diskPath = cacheURL.absoluteString
        #endif
        
        let cache = URLCache(memoryCapacity: 16384, diskCapacity: 268435456, diskPath: diskPath);
        defaualtConfiguration.urlCache = cache;
        defaualtConfiguration.requestCachePolicy = .useProtocolCachePolicy;
        
//        let operationQueue = OperationQueue.main
        
        
        let defaultSession = URLSession(configuration: defaualtConfiguration)
//        let ephemeralSession = URLSession(configuration: ephemeralConfiguration)
//        let backgoundSession = URLSession(configuration: backgoundConfiguration)
//        let testUrl = "https://www.baidu.com"
        
        let userUrl = "http://192.168.0.191:6969/SpringDemo/privateapi/allusers"
        let orderUrl = "http://192.168.0.191/~zz/jd_order.php"
        
        
        //MARK:Alomofire
        if let url = URL(string: userUrl) {
            Alamofire.request(url).responseJSON(completionHandler: { (dataResponse) in
                if let data = dataResponse.data{
                    let dataContainer = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                    let dataArr = dataContainer["users"]
                    print(dataArr as Any)
                    
                    for  dic  in (dataArr as! Array<Any>){
                        let user = User(fromDic: dic as! Dictionary<String, AnyObject>)
                        self.users.add(user)
                    }
                    print(self.users.count);
                }
            })
        }
      
        //MARK:Apache
        if let url = URL(string: orderUrl.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("text/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            //for orderUrl
            request.addValue("00001", forHTTPHeaderField:"uid")
            print(request.allHTTPHeaderFields ?? "No HeaderField")
            
            (defaultSession.dataTask(with: request, completionHandler: { (data , response , error) in
                if let error = error
                {
                    print("Error:\(error)");
                }else if let response = response,
                    let data = data,
                    let string = String(data:data,encoding:.utf8){
                    print("Response:\(response)");
                    print("DATA:\n\(string)\nEND DATA\n");
                    
                    let dataContainer = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                    
                    for  dic  in dataContainer{
                        let product = Product(fromDic: dic as! Dictionary<String, AnyObject>)
                        self.products.add(product)
                    }
                    print(self.products.count);
                    
                }})).resume();
        }
        
        
        //MARK:GlassFish
        if let url = URL(string: userUrl.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("text/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print(request.allHTTPHeaderFields ?? "No HeaderField")
            
            (defaultSession.dataTask(with: request, completionHandler: { (data , response , error) in
                if let error = error
                {
                    print("Error:\(error)");
                }else if let response = response,
                    let data = data,
                    let string = String(data:data,encoding:.utf8){
                    print("Response:\(response)");
                    print("DATA:\n\(string)\nEND DATA\n");
                    
                    let dataContainer = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                    
                    let dataArr = dataContainer["users"]

                    for  dic  in (dataArr as! Array<Any>){
                        let user = User(fromDic: dic as! Dictionary<String, AnyObject>)
                        self.users.add(user)
                    }
                    print(self.users.count);
                    
                }})).resume();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

