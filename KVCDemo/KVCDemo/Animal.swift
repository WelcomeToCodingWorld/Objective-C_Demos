//
//  Animal.swift
//  KVCDemo
//
//  Created by zz on 2017/6/13.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import Foundation

class Animal : NSObject {
    @objc var name : String?
    var age : uint = 0
    init(name: String , age:uint) {
        self.name = name
        self.age = age
    }
}



class Person: NSObject {
    @objc var name: String
    @objc var age: uint
    @objc var friends: [Person] = []
    @objc var bestFriend: Person? = nil
    @objc var address: Address?
//    @objc var
    
    init(name: String,age:uint) {
        self.name = name
        self.age = age
    }
    
    override func setNilValueForKey(_ key: String) {
        if key == "age" {
            self.age = 0
        }else{
            super .setNilValueForKey(key)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        super .setValue(value, forUndefinedKey: key)
    }
}

class Address:NSObject{
    @objc var city: String
    init(city: String){
        self.city = city
    }
}

//interface Transaction : NSObject
//
//@property (nonatomic) NSString* payee;   // To whom
//@property (nonatomic) NSNumber* amount;  // How much
//@property (nonatomic) NSDate* date;      // When
//
//@end

class Transaction : NSObject {
    @objc var payee:String
    @objc var amount:Float
    @objc var date:Date
    
    init(payee:String,amount:Float,date:Date) {
        self.payee = payee
        self.amount = amount
        self.date = date
    }
}




//@interface BankAccount : NSObject
//
//@property (nonatomic) NSNumber* currentBalance;              // An attribute
//@property (nonatomic) Person* owner;                         // A to-one relation
//@property (nonatomic) NSArray< Transaction* >* transactions; // A to-many relation
//
//@end

class BankAccount: NSObject {
    @objc var currentBalance:NSNumber?
    @objc var owner:Person?
    @objc var transactions:[Transaction]?
}








