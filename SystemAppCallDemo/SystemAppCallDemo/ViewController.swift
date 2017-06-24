//
//  ViewController.swift
//  SystemAppCallDemo
//
//  Created by zz on 2017/6/8.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var customView: MyCustomView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textFields[0].placeholder = "0000"
        textFields[1].placeholder = "1111"
        textFields[2].placeholder = "2222"
        customView.backgroundColor = customView.textColor
//        var height = customView.iconHeight
        
        var str : String?
        str = "Me"
        var tempArr = [Any?]()
        tempArr.append(str! as Any)
        tempArr.append(nil)
        print(tempArr)
        
        
        let f = MyClass.method
        let object = MyClass()
        let result = f(object)(1)
        print(result)
        
        
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        
        DispatchQueue.main.async {
            sleep(2)
            stepCounter.totalSteps = 400
            
            sleep(2)
            stepCounter.totalSteps = 500
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}




class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

// a general city belong to a const country,this country doesn't depent on a  general but capital city
class City {//so a county should not be initialize with the city here
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}


class MyClass {
    func method(number:Int) -> Int{
        return number + 1;
    }
}


class StepCounter {
    static let stepSound : String = "Xixuxuxux"
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet(old) {
            if totalSteps > old  {
                print("Added \(totalSteps - old) steps")
            }
        }
    }
    
    var testComputePro : Float {
        get{
            return 3.0
        }
        
        set{
            
        }
    }
    
}

class TestCounter: StepCounter {
    override var totalSteps: Int {
        willSet{
            
        }
        
        didSet{
            
        }
    }
    
}


