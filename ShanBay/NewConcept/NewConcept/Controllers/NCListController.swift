//
//  NCListController.swift：
//  NewConcept
//
//  Created by wcshinestar on 3/29/16.
//  Copyright © 2016 com.onesetp.WflytoC. All rights reserved.
//

import UIKit

private let ID = "cell"

class NCListController: UITableViewController {

    var titles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ID)
        loadTitles()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadTitles() -> Void {
        
        let titles = NSKeyedUnarchiver.unarchiveObjectWithFile(NCTools.getFilePath("titles"))
        self.titles = titles as! [String]
        self.tableView.reloadData()
    }
}



extension NCListController {
    
    // MARK: - Table view data source
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
        cell.textLabel!.text = self.titles[indexPath.row]
        return cell
    }
    
    
    //MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let chapter = indexPath.row
        let detailController = NCDetailController()
        detailController.chapter = chapter
        //在push时，会卡，而且内存瞬间飙升
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
}
