//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by zz on 2017/3/22.
//  Copyright © 2017 zzkj. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionRect = CGRect(x:EdgeWidth, y: TitleHeight , width:ScreenWidth - 2*EdgeWidth, height: ScreenHeight - TitleHeight)
        
        
        //布局
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 30
        layout.sectionHeadersPinToVisibleBounds = true
    
        
        
        //创建CollectionView
        let collectionView = UICollectionView(frame: collectionRect, collectionViewLayout: layout)
        collectionView.register(UINib(nibName:"BusinessCardCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "BusinessCardID")
        collectionView.backgroundColor = UIColor.white
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
        
        
        let cell:BusinessCardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessCardID", for: indexPath) as! BusinessCardCollectionViewCell
        cell.titleLabel.text = "Hello"
        
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



