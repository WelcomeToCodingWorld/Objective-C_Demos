//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var str1 = "Hey,buddy!"
print(str1)
var var1 = 53
var1 = 98
let meaningOfLife = 99
let catCharacters:[Character] = ["C","a","t","!","🐱"];
let catString = String(catCharacters)
let string1 = "Hello"
let string2 = " there"
var welcome = string1+string2
var exclamationMark:Character = "!"
welcome.append(exclamationMark)

class Vehicle {
    var haha : String {
        get{
            return "4144"
        }
    }
        
    
    var currentSpeed : Double {
        get{
            return 3.0
        }
        set{
            
        }
    }
    var description:String = "" {
        willSet{
            
        }
    }
    func makeNoise() {
        
    }
}

class Bicycle:Vehicle{
    var hasBasket = false
    override var description: String{
        get{
            return super.description + "dddd";
        }
        
        set{
            
        }
    }
    
    override var currentSpeed: Double {
        get{
            return super.currentSpeed
        }
        
        set{
            
        }
    }
}








