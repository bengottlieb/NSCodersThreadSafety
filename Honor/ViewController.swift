//
//  ViewController.swift
//  Honor
//
//  Created by Ben Gottlieb on 2/28/17.
//  Copyright © 2017 Ben Gottlieb. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func saveDataInBackground() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let moc = delegate.persistentContainer.viewContext
        
        DispatchQueue.global(qos: .utility).async {
            let request = NSFetchRequest<DataRecord>(entityName: "Data")
            let items = (try? moc.fetch(request)) ?? []
            
            if items.count == 0 {
                for i in 0...100 {
                    let entity = NSEntityDescription.insertNewObject(forEntityName: "Data", into: moc) as! DataRecord
                    entity.id = "id #\(i)"
                }
                try? moc.save()
                self.label.text = "Records Added"
            } else {
                self.label.text = "Records Exist"
            }
        }
    }

}

