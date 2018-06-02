//
//  CoreTableViewController.swift
//  SwiftStorage
//
//  Created by new on 28/05/18.
//  Copyright © 2018 yuvraj. All rights reserved.
//

import UIKit

class CoreTableViewController: UITableViewController {
    
    var listNotes : [Notes]? = nil
    @IBOutlet var noteTableView: UITableView!
    @IBOutlet var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        self.listNotes = CoreDataHandler().getNotesList()
    }
    
    @IBAction func buttonCreateNote(_ sender: Any) {
        performSegue(withIdentifier: "create", sender: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var numOfSections: Int = (self.listNotes?.count)!
        if numOfSections > 0{
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }else{
            tableView.backgroundView  = emptyView
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes_cell", for: indexPath) as! NotesTableViewCell
        
        // Configure the cell...
        let image = self.listNotes?[indexPath.row].image
        
        //        var imageData: Data? = nil
        //        do {
        //            let u = URL(fileURLWithPath:image!)
        //            imageData = try Data(contentsOf: u)
        //        }catch {
        //            print("catastrophe loading file?? \(error)")
        //        }
        //
        //        if imageData != nil {
        //            cell.imageNotes?.image = UIImage(data: imageData!)
        //            print("that seemed to work")
        //        }
        
        let imagePath = getDocumentsDirectory().appendingPathComponent(image!)
        
        cell.imageNotes?.image = UIImage(contentsOfFile: imagePath.path)
        
        cell.contentNotes?.text = self.listNotes?[indexPath.row].content
        cell.locationNotes?.text = self.listNotes?[indexPath.row].location
        
        print(listNotes?[indexPath.row] as Any)
        
        return cell
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDir = paths.first!
        return documentDir
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listNotes = CoreDataHandler().getNotesList()
        noteTableView.reloadData()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
