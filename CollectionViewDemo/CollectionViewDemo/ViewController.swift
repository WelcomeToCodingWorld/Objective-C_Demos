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
    private var data:Array<Product> = []
    
    let reuseIdentifier = "ProductCellID"
    
    
    
    let headerIdentifier = "SectionHeaderID"
    
    
    let footerIdentifier = "SectionFooterID"
    
    let decorationIdentifier = "DecorationViewID"
    
    let singleValueContainerJsonData = """
[
  "king",
  "paul",
  "lee"
]
""".data(using: .utf8)!
    
    let products = """
    [
  {
    "productName": "lucky0",
    "productId": "0000"
  },
  {
    "productName": "lucky1",
    "productId": "0001"
  },
  {
    "productName": "lucky2",
    "productId": "0002"
  },
  {
    "productName": "lucky3",
    "productId": "0003"
  },
  {
    "productName": "lucky4",
    "productId": "0004"
  },
  {
    "productName": "lucky5",
    "productId": "0005"
  }
]
""".data(using: String.Encoding.utf8)
    
    let responseArrayData = """
{
  "code": "50001",
  "data": [
    {
      "name": "lee",
      "age": 10
    },
    {
      "name": "king",
      "age": 20
    },
    {
      "name": "paul",
      "age": 25
    }
  ]
}
""".data(using: String.Encoding.utf8)

    let responseDicData = """
{
  "code": "50001",
  "data": {
      "name": "lee",
      "age": 10
    }
}
""".data(using: String.Encoding.utf8)
    
    
    
    let collectionRect = CGRect(x:EdgeWidth, y: TitleHeight , width:ScreenWidth - 2*EdgeWidth, height: ScreenHeight - TitleHeight)
    let layout = UICollectionViewFlowLayout()
    
   
    func configLayout() {
        self.layout.minimumInteritemSpacing = 20
        self.layout.minimumLineSpacing = 30
        self.layout.sectionHeadersPinToVisibleBounds = true
        self.layout.register(UINib(nibName: "DecorationCollectionReusableView", bundle: nil), forDecorationViewOfKind: "DecorationView")
//        self.layout.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil), forDecorationViewOfKind: UICollectionElementKindSectionFooter)
//        self.layout.scrollDirection = .horizontal
//        self.layout.layoutAttributesForDecorationView(ofKind: UICollectionElementKindSectionFooter, at: IndexPath(item: 3, section: 0))
//        self.layout.layoutAttributesForSupplementaryView(ofKind: "", at: IndexPath(item: 3, section: 0))
//        self.layout.layoutAttributesForItem(at: IndexPath(item: 3, section: 0))
//        self.layout.layoutAttributesForElements(in: CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width, height: 300))
    }
    
    
    
    func configCollectionView() {
        self.collectionView.collectionViewLayout = self.layout
        self.collectionView.register(UINib(nibName:"ProductCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.backgroundColor = UIColor.gray
        self.collectionView.delegate = self
        self.collectionView.dataSource = self;
        self.collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        self.collectionView.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier)
    }
    
    func loadData() {
        /*cache for sessionConfiguration*/
        let fileManager = FileManager.default
        let cacheDirectoryUrl = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        let cacheUrl = cacheDirectoryUrl?.appendingPathComponent("MyCache")
        var dishPath = cacheUrl?.path
        #if os(OSX)
            dishPath = cacheUrl?.absoluteString
        #endif
        let cache = URLCache(memoryCapacity: 20000, diskCapacity: 270000000, diskPath: dishPath)
        
        
        //configuration for session
        let defaultConfiguration = URLSessionConfiguration.default
        
        defaultConfiguration.urlCache = cache
        defaultConfiguration.requestCachePolicy = .useProtocolCachePolicy
        
        let defaultSession = URLSession(configuration: defaultConfiguration)
        
        
        //url for session
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
//                    print("Response:\(response)");
//                    print("DATA:\n\(string)\nEND DATA\n");
//                    let dataContainer = try! JSONSerialization.jsonObject(with:data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
//                    let dataArr = dataContainer["users"]
//                    for  dic  in (dataArr as! Array<Any>){
//                        let user = User(fromDic: dic as! Dictionary<String, AnyObject>)
//                        self.data.append(user)
//                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }).resume()
        }
        
        
        /*local dataSource*/
        let decoder = JSONDecoder()
//        let product = try decoder.decode(Product.self, from:users!)
        self.data = try! decoder.decode([Product].self, from: products!)
        self.collectionView.reloadData()
        
        
        let response = try! decoder.decode(Response<Antique>.self, from: self.responseArrayData!)
        print(response)
        
//        SingleValueDecodingContainer
        let dogs = try! decoder.decode([Dog].self, from: self.singleValueContainerJsonData)
        
        print(dogs)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLayout()
        self.configCollectionView()
        self.loadData()
        self.cities()
    }
    
    func cities() {
        let cityJson = """
[
  {
    "name": "重庆 ",
    "code": "500301",
    "isProvinceLevel": true,
    "population": 300
  },
  {
    "name": "太原",
    "code": "500303",
    "isProvinceLevel": false,
    "population": 100
  }
]
""".data(using: String.Encoding.utf8)
        let decoder = JSONDecoder()
        let cities = try? decoder.decode([CityDemo].self, from: cityJson!)
        
        print(cities!)
        
    }
    
//UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.product = self.data[indexPath.row]
        
        return cell
    }
    
    @available(tvOS 10.2, *)
    func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        return IndexPath(item: 3, section: 0)
    }
    
    @available(tvOS 10.2, *)
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return ["Wow"]
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath)
        }
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier, for: indexPath)
        
    }
    
    
    
    //    UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 15, 10, 15)
    }
    
    
    
//    UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
    }
    
    
    
    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
    @available(iOS 11.0, *)
    func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        
    }
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

struct Product:Decodable {
    var productId:String
    var productName:String
}

struct Response<T:Decodable>:Decodable {
    var code:String
    var data:Any
    var responseType:ResponseType
    
    enum ResponseType : String{
        case ReponseTypeDictionary,ReponseTypeArray
    }
    
    enum CodingKeys:String,CodingKey {
        case code
        case data
    }
    
    init(_ code:String,_ data:Any,_ responseType:ResponseType) {
        self.code = code
        self.data = data
        self.responseType = responseType
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let code = try values.decode(String.self, forKey: .code)
        if let additionalInfo = try? values.nestedUnkeyedContainer(forKey: .data) {//Array
            print(additionalInfo.count!)
            print("Array")
            let antiques = try values.decode([T].self, forKey: .data)
            self.init(code, antiques, ResponseType.ReponseTypeArray)
        }else{//Dictionary
            print("Dictionary")
            let antique = try values.decode(T.self, forKey: .data)
            self.init(code, antique,ResponseType.ReponseTypeDictionary)
        }
    }
}

class Antique:Decodable{
    var name:String
    var age: UInt
    
    
    init(_ name:String,_ age:UInt){
        self.name = name
        self.age = age
    }
}

struct Dog:Decodable {
    var name:String
//    var aga:UInt
    init(_ name:String) {
        self.name = name
    }
    
    init(from decoder:Decoder) {
        let singleValueContainter = try! decoder.singleValueContainer()
        let dogName = try! singleValueContainter.decode(String.self)
        print(dogName)
        self.init(dogName)
    }
}




