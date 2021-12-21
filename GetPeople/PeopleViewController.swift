//
//  ViewController.swift
//  GetPeople
//
//  Created by Linah abdulaziz on 17/05/1443 AH.
//

import UIKit

class PeopleViewController: UITableViewController {
    
    var people = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://swapi.dev/api/people/?format=json")
        
               // create a URLSession to handle the request tasks
               let session = URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            do{
                            if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                if let result = jsonResult["results"] as? NSArray {
                                    for i in result {
                                        if let jsonObject = i as? NSDictionary{
                                            self.people.append(jsonObject["name"] as! String)
                                        }
                                    }
                                }
                            }
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }catch{
                            print("Error \(error)")
                        }
                    })
                  
                 task.resume()
                }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            people.count
        }

        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)

        cell.textLabel?.text = people[indexPath.row]

            return cell
        }

}
