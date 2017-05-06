//
//  MainViewController.swift
//  SearchControllerDemo
//
//  Created by zz on 2017/5/6.
//  Copyright © 2017年 zzkj. All rights reserved.
//

import UIKit

class MainViewController: BaseTableViewController,UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating {

    var products = [Product]()
    var searchController:UISearchController!
    var resultsTableController:ResultsTableController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultsTableController = ResultsTableController()
        resultsTableController.tableView.delegate = self
        
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableViewController.tableViewCellID, for: indexPath)
        let product = products[indexPath.row]
        
        configCell(cell, forProduct: product)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct : Product
        
        if tableView === self.tableView {
            selectedProduct = products[indexPath.row]
        }else{
            selectedProduct = resultsTableController.filteredProducts[indexPath.row]
        }
        let detailViewController = DetailViewController.detailViewControllerForProduct(selectedProduct)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

}
