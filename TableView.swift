//
//  TableView.swift
//  DemoProject
//
//  Created by Frog Pepe on 24/06/2022.
//

import UIKit
import CoreData

class TableView: UIViewController {
    let CellId = "TableViewCell"
    var names: [String] = ["Tí",
                           "Tèo",
                           "Hùng",
                           "Lam",
                           "Thuỷ"
    ]
    var fetchedResultsController: NSFetchedResultsController<Entity>!
    
    @IBAction func AddButton(_ sender: Any) {
        save(name: "Trung666")
        //        tableview.beginUpdates()
        //        let indexPath : IndexPath = IndexPath(row:(fetchedResultsController.fetchedObjects!.count - 1),section: 0)
        //        tableview.insertRows(at: [indexPath], with: .left)
        //        tableview.endUpdates()
        tableview.reloadData()
    }
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFetchedResultsController()
        tableview.delegate = self
        tableview.dataSource = self
        let nibCell = UINib(nibName:CellId , bundle: .main)
        tableview.register(nibCell, forCellReuseIdentifier: CellId)
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
        
    }
    func save(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: managedContext)!
        
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        user.setValue(name, forKeyPath: "name")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension TableView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return names.count
        fetchedResultsController.fetchedObjects!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! TableViewCell
        let user = fetchedResultsController.object(at: indexPath)
        cell.label.text = user.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //            print("selected cell: \(names[indexPath.row])")
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "IOS"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // lấy AppDelegate
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            // lấy Managed Object Context
            let managedContext = appDelegate.persistentContainer.viewContext
            
            // lấy item ra để xoá
            let user = fetchedResultsController.object(at: indexPath)
            
            // delete
            managedContext.delete(user)
            
            //save context
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    
}

extension TableView : NSFetchedResultsControllerDelegate {
    func initializeFetchedResultsController() {
        
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // lấy AppDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // lấy Managed Object Context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: managedContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            print("insert")
            if let indexPath = newIndexPath {
                tableview.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            print("delete")
            if let indexPath = indexPath {
                tableview.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            print("update")
            tableview.reloadRows(at: [indexPath!], with: .automatic)
            break;
        default:
            print("default")
        }
    }
}
