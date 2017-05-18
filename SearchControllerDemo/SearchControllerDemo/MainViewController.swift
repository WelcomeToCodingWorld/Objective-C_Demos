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
        searchController.obscuresBackgroundDuringPresentation = false
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
        let searchResults = products
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        // Build all the "AND" expressions for each value in the searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            // Each searchString creates an OR predicate for: name, yearIntroduced, introPrice.
            //
            // Example if searchItems contains "iphone 599 2007":
            //      name CONTAINS[c] "iphone"
            //      name CONTAINS[c] "599", yearIntroduced ==[c] 599, introPrice ==[c] 599
            //      name CONTAINS[c] "2007", yearIntroduced ==[c] 2007, introPrice ==[c] 2007
            //
            var searchItemsPredicate = [NSPredicate]()
            
            // Below we use NSExpression represent expressions in our predicates.
            // NSPredicate is made up of smaller, atomic parts: two NSExpressions (a left-hand value and a right-hand value).
            
            // Name field matching.
            let titleExpression = NSExpression(forKeyPath: "title")
            let searchStringExpression = NSExpression(forConstantValue: searchString)
            
            let titleSearchComparisonPredicate = NSComparisonPredicate(leftExpression: titleExpression, rightExpression: searchStringExpression, modifier: .direct, type: .contains, options: .caseInsensitive)
            
            searchItemsPredicate.append(titleSearchComparisonPredicate)
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .none
            numberFormatter.formatterBehavior = .default
            
            let targetNumber = numberFormatter.number(from: searchString)
            
            // `searchString` may fail to convert to a number.
            if targetNumber != nil {
                // Use `targetNumberExpression` in both the following predicates.
                let targetNumberExpression = NSExpression(forConstantValue: targetNumber!)
                
                // `yearIntroduced` field matching.
                let yearIntroducedExpression = NSExpression(forKeyPath: "yearIntroduced")
                let yearIntroducedPredicate = NSComparisonPredicate(leftExpression: yearIntroducedExpression, rightExpression: targetNumberExpression, modifier: .direct, type: .equalTo, options: .caseInsensitive)
                
                searchItemsPredicate.append(yearIntroducedPredicate)
                
                // `price` field matching.
                let lhs = NSExpression(forKeyPath: "introPrice")
                
                let finalPredicate = NSComparisonPredicate(leftExpression: lhs, rightExpression: targetNumberExpression, modifier: .direct, type: .equalTo, options: .caseInsensitive)
                
                searchItemsPredicate.append(finalPredicate)
            }
            
            // Add this OR predicate to our master AND predicate.
            let orMatchPredicate = NSCompoundPredicate(orPredicateWithSubpredicates:searchItemsPredicate)
            
            return orMatchPredicate
        }
        
        // Match up the fields of the Product object.
        let finalCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        
        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }
        
        // Hand over the filtered results to our search results table.
        let resultsController = searchController.searchResultsController as! ResultsTableController
        resultsController.filteredProducts = filteredResults
        resultsController.tableView.reloadData()
    }

}
