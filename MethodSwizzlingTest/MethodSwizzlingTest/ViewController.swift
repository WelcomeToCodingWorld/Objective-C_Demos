//
//  ViewController.swift
//  MethodSwizzlingTest
//
//  Created by zz on 02/11/2017.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func tap(_ sender: Any) {
        let ttVC = TTViewController()
        navigationController?.pushViewController(ttVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testLabel = UILabel()
        testLabel.text = "Hello"
        view.addSubview(testLabel)
        
        
//        For example, SomeClass.self returns SomeClass itself, not an instance of SomeClass. And SomeProtocol.self returns SomeProtocol itself, not an instance of a type that conforms to SomeProtocol at runtime.
        
        // MARK: Test
//        print("\(UILabel.self is UILabel.Type)")// warning:'is' test is always true
        
//        let testLab1 = UILabel.self.init(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
//        let testLab2 = UILabel.init(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
//        print("\(testLab1 is UILabel)")// warning:'is' test is always true
//        print("\(testLab2 is UILabel)")// warning:'is' test is always true
//        print("\(UILabel.self)")// UILabel
//          print("\(UILabel)")// Error: Expected member name or constructor call after type name
//        print(type(of: UILabel.self))// UILabel.Type
        
        
        
        
        // MARK: Test Self vs self
        print("\(#function)[\(#line)]\(UIView() is UILabel)")//false
        
        let cache = Cache()
        cache.greet()
        cache.kick()
        Cache.support()
        
        
        let materials : [Material] = Array(repeating: Material(name: "机油", code: "1002"), count: 4)
        var kit = Kit(name: "Kit", code: "10", materials: materials)
        kit.materials = [Material(name: "机油", code: "1003")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


// MARK: Test: MethodSwizzling
extension UILabel {
    @objc func al_setText(_ :String) {
        print("UILabel's newMethod called")
    }
}

extension UIView {
    @objc func al_layoutSubviews() {
//        print("UIView's newMethod called")
    }
}



// MARK: Test: static vs class
class Cache {
    // conformance
    static var name:String {
        get {
            return "\(#function)[\(#line)]"
        }
        
        set {
            
        }
    }
    
    // custom
    // if static,cannot be override
    class var identifier:String {
        return "binggo"
    }
}

class subCache: Cache {
    // if static,cannot be override
    override class var identifier:String {
        get {
            return "\(#function)[\(#line)]"
        }
        
        set{
            
        }
    }
}

class decendentSubCache: subCache {
    override static var identifier:String {
        get{
            return "\(#function)[\(#line)]"
        }
        
        set{
            
        }
    }
}

extension Cache:unbelievable {
    
}

protocol unbelievable {
    // There's no let requirement in protocol,use var and get,set instead
    // Always prefix type property requirements with the static keyword when you define them in a protocol.
    // This rule pertains even though type property requirements can be prefixed with the class or static keyword when implemented by a class:
    // see:https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID267
    static var name:String  {get set}
    func greet()
    static func support()
}

extension unbelievable where Self:Cache {
    func greet() {
        print("\(#function)[\(#line)]\(self)")
        print("\(#function)[\(#line)]\(Self.self)")
        
//        print("\(#function)[\(#line)]\(self is Self)")//Cast from 'Self.Type' to unrelated type 'Self' always fails
//        print(self == Self.self)//Binary operator '==' cannot be applied to operands of type 'Self' and 'Self.Type'
        
//        print("\(#function)[\(#line)]\(self.name)")//Static member 'name' cannot be used on instance of type 'Self'
        print("\(#function)[\(#line)]\(Self.name)")
    }
    
    static func support() {
//        print("\(#function)\(#line)\(UILabel() is UIView)")//'is' test is always true
        print("\(#function)[\(#line)]\(self)")
        print("\(#function)[\(#line)]\(Self.self)")
        
//        print("\(#function)[\(#line)]\(self is Self)")//Cast from 'Self.Type' to unrelated type 'Self' always fails
        print("\(#function)[\(#line)]\(self == Self.self)")//true
        
        print("\(#function)[\(#line)]\(self.name)")
        print("\(#function)[\(#line)]\(Self.name)")
    }
    
    // Note : It is also a method requirement,though not declared in protocol's declaration
    func kick() {
        print("\(#function):[\(#line)]\(Self.name)")
    }
}

struct Material {
    var name : String
    var code : String
}

struct Kit {
    var name : String
    var code : String
    var materials:[Material] {
        didSet{
            print("didSet")
        }
    }
}



