//
//  ViewController.swift
//  UITableVIewTestWithSwift
//
//  Created by SeungWon Kim on 11/20/29 H.
//  Copyright © 29 Heisei SEUNGWON KIM. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  let cellId = "cellId"
  
  var twoDimensionalArray = [
    ExpandableNames(isExpanded: true, names: ["Amy", "Bill", "Caly", "Steve", "Zack", "Jill", "Mary"]),
    ExpandableNames(isExpanded: true, names: ["Carl", "Chris", "Colin", "Cameron"]),
    ExpandableNames(isExpanded: true, names: ["Dany", "Dino", "Doly", "Dalsim"])
  ]
  
  var showIndexPaths = false
  
  @objc func handleShowIndexPath(){
    print("reload animation of indexpath")
    
    var indexPathsToReload = [IndexPath]()
    
    for section in twoDimensionalArray.indices {
      for row in twoDimensionalArray[section].names.indices {
        let indexPath = IndexPath(row: row, section: section)
        indexPathsToReload.append(indexPath)
      }
    }
//    for index in towDimensionalArray[0].indices {
//      let indexPath = IndexPath(row: index, section: 0)
//      indexPathsToReload.append(indexPath)
//    }
    showIndexPaths = !showIndexPaths
    
    let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
    
    tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
    navigationItem.title = "Contacts"
  
    // only for iOS 11.1
    navigationController?.navigationBar.prefersLargeTitles = true
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let button = UIButton(type: .system)
    button.setTitle("Close", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .brown
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    
    button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
    button.tag = section
    
    return button
  }
  
  @objc func handleExpandClose(button: UIButton) {
    print("Expand and close seciton..")
    
    let section = button.tag
    var indexPaths = [IndexPath]()
    for row in twoDimensionalArray[section].names.indices {
      let indexPath = IndexPath(row: row, section: section)
      indexPaths.append(indexPath)
    }
    
    let isExpanded = twoDimensionalArray[section].isExpanded
    twoDimensionalArray[section].isExpanded = !isExpanded
    
    button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
    
    if isExpanded {
      tableView.deleteRows(at: indexPaths, with: .fade)
    }else {
      tableView.insertRows(at: indexPaths, with: .fade)
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 36
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return twoDimensionalArray.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if !twoDimensionalArray[section].isExpanded {
      return 0
    }

    return twoDimensionalArray[section].names.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for:indexPath)
    
//    let name = self.names[indexPath.row]
    let name = twoDimensionalArray[indexPath.section].names[indexPath.row]
    cell.textLabel?.text = name
    if showIndexPaths {
      cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row:\(indexPath.row)"
    }
    return cell
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

