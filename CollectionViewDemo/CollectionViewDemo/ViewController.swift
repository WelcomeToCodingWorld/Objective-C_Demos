//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/3/22.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        var collectionRect = CGRect(x: 20, y: 300, width: 100, height: 200)
        collectionRect.origin = CGPoint(x: 50, y: 120)
        
        //布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.sectionHeadersPinToVisibleBounds = true
        
        
        //创建CollectionView
        let collectionView = UICollectionView(frame: collectionRect, collectionViewLayout: layout)
        collectionView.register(UINib(nibName:"BusinessCardTableViewCell", bundle:nil), forCellWithReuseIdentifier: "BusinessCardID")
        collectionView.delegate = self
        collectionView.dataSource = self;
        
        self.view.addSubview(collectionView)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "BusinessCardID", for: indexPath)
        return cell;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}



