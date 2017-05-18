//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/3/22.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionView: UICollectionView!
    private var data:Array<User> = []
    
    let reuseIdentifier = "BusinessCardID"
    
    let collectionRect = CGRect(x:EdgeWidth, y: TitleHeight , width:ScreenWidth - 2*EdgeWidth, height: ScreenHeight - TitleHeight)
    let layout = UICollectionViewFlowLayout()
    
   
    func configLayout() {
        self.layout.minimumInteritemSpacing = 20
        self.layout.minimumLineSpacing = 30
        self.layout.sectionHeadersPinToVisibleBounds = true
    }
    
    func configCollectionView() {
        self.collectionView.collectionViewLayout = self.layout
        self.collectionView.register(UINib(nibName:"BusinessCardCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self;
    }
    
    func loadData() {
        let fileManager = FileManager.default
        let cacheDirectoryUrl = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        let cacheUrl = cacheDirectoryUrl?.appendingPathComponent("MyCache")
        var dishPath = cacheUrl?.path
        #if os(OSX)
            dishPath = cacheUrl?.absoluteString
        #endif
        let cache = URLCache(memoryCapacity: 20000, diskCapacity: 270000000, diskPath: dishPath)
        
        let defaultConfiguration = URLSessionConfiguration.default
        
        defaultConfiguration.urlCache = cache
        defaultConfiguration.requestCachePolicy = .useProtocolCachePolicy
        
        let defaultSession = URLSession(configuration: defaultConfiguration)
        
        
        let userUrl = "http://192.168.0.191:6969/SpringDemo/privateapi/allusers"
        
        if let url = URL(string: userUrl.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("text/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let error = error{
                    print("Error\(error)")
                }else if let response = response,
                    let data = data,
                    let string = String(data: data, encoding: String.Encoding.utf8){
                    print("Response:\(response)");
                    print("DATA:\n\(string)\nEND DATA\n");
                    let dataContainer = try! JSONSerialization.jsonObject(with:data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                    let dataArr = dataContainer["users"]
                    for  dic  in (dataArr as! Array<Any>){
                        let user = User(fromDic: dic as! Dictionary<String, AnyObject>)
                        self.data.append(user)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }).resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLayout()
        self.configCollectionView()
        self.loadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:BusinessCardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BusinessCardCollectionViewCell
        cell.user = self.data[indexPath.row]
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}



