//
//  ViewController.swift
//  GenericsSample
//
//  Created by Alexandru Corut on 30/06/2018.
//  Copyright © 2018 Alexandru Corut. All rights reserved.
//

import UIKit

//MARK:-Generic TableViewController
class BaseTableViewController<T: BaseCell<U>, U>: UITableViewController {
    
    let cellId = "cellId"
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(T.self, forCellReuseIdentifier: cellId)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BaseCell<U>
        
        cell.item = items[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BaseCell<U>
        
        cell.item = items[indexPath.row]
        print(cell.item, "\(indexPath.row)")
        
    }
    
}

//MARK:-Generics TableViewCell
class BaseCell<U>: UITableViewCell {
    var item: U!
}


//Models
struct Dog {
    let name: String
}

struct Cat {
    let name: String
}


//MARK:-TableView Cells
class DogCell: BaseCell<Dog> {
    override var item: Dog! {
        didSet {
            textLabel?.text = item.name
        }
    }
}

class CatCell: BaseCell<Cat> {
    override var item: Cat! {
        didSet {
            textLabel?.text = item.name
        }
    }
}


//MARK:-Controllers
class CatController: BaseTableViewController<CatCell, Cat> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [
            Cat(name: "Miau miau"),
            Cat(name: "Purr purr purr")
        ]
    }
    
}

class DogController: BaseTableViewController<DogCell, Dog> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [
            Dog(name: "Woof woof"),
            Dog(name: "Ruff ruff ruff")
        ]
    }
}
