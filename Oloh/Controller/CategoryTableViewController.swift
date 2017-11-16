//
//  CategoryViewController.swift
//  Oloh
//
//  Created by mickael on 08/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper


class CategoryTableViewCell: UITableViewCell{
    
    @IBOutlet weak var catTitle: UILabel!
    @IBOutlet weak var catDesc: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
}

class CategoryTableViewController: UITableViewController {
    let realm = try! Realm()
    var category: Results<Categories>?
    var cat = ["Cat1", "Cat2", "Cat3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.category = self.realm.objects(Categories.self)
print(realm.configuration.fileURL)
        FetchData.get(type: Categories.self , success: {
            self.infoAlert(title: "Category", message: "Successful fetched Movie information\n\(self.category!.count)")
            print(self.category!.description)
        }) { (error) in
            print("error")
            self.infoAlert(title: "Movie", message: "Unsuccessful fetched Movie information\n\(error.description)")
        }
        
        
        // Get the default Realm
        print( realm.objects(Category.self).first?.categoryName)
        print( realm.objects(Product.self).count)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cat.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! CategoryTableViewCell
                
        let catName = cat[indexPath.row]
        cell.catTitle?.text = catName
        cell.catDesc?.text = "Great!"
        cell.catImageView?.image = UIImage(named: "AppIcon")
        
        return cell
    }
    
    
    func infoAlert(title: String, message: String) -> Void {
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
    }

    
}
