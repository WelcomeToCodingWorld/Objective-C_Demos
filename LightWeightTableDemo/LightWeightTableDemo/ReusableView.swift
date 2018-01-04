//
//  ReusableView.swift
//  AppDemo
//
//  Created by zz on 23/12/2017.
//  Copyright © 2017 com.lesta. All rights reserved.
//

import UIKit
// MARK: ReusableViewParent
protocol ReusableViewParent:class {
    associatedtype ReusableViewType:UIView
    func dequeueReusableCell(identifier:String,indexPath:IndexPath) -> ReusableViewType?
    func dequeueReusableSupplementaryView(ofKind kind:String,identifier:String,indexPath:IndexPath) -> ReusableViewType?
}

extension UITableView:ReusableViewParent {
    typealias ReusableViewType = UITableViewCell
    func dequeueReusableCell(identifier: String, indexPath: IndexPath) -> UITableViewCell? {
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    func dequeueReusableSupplementaryView(ofKind kind: String, identifier: String, indexPath: IndexPath) -> UITableViewCell? {
        return nil
    }
}

extension UICollectionView:ReusableViewParent {
    typealias ReusableViewType = UICollectionReusableView
    
    func dequeueReusableCell(identifier: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return dequeueReusableCell(withReuseIdentifier:identifier ,for:indexPath)
    }
    
    func dequeueReusableSupplementaryView(ofKind kind: String, identifier: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return dequeueReusableSupplementaryView(ofKind:kind,withReuseIdentifier:identifier,for:indexPath)
    }
 
}

// MARK: ReusableView
protocol ReusableView {
    associatedtype ParentView:UIView,ReusableViewParent
    var reuseIdentifier:String? {get}
    func prepareForReuse()
}

extension UITableViewCell:ReusableView {
    typealias ParentView = UITableView
}

extension UICollectionReusableView:ReusableView {
    typealias ParentView = UICollectionView
}
