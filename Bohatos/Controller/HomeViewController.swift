//
//  HomeViewController.swift
//  Bohatos
//
//  Created by Hatos Barbosa on 21/05/19.
//  Copyright © 2019 Hatos Barbosa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    var postItemList: [PostItem] = []
   // var 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/") else { return }
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let dataResponse = data, error == nil else {
                print (error?.localizedDescription ?? "Response Error")
                return }
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode([PostItem].self, from: dataResponse)
                print(response)
                
                for post in response
                {
                    self.postItemList.append(post)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "palavraDaSemanaCell", for: indexPath) as! PalavraDaSemanaTableViewCell
        
        let palavra = postItemList[indexPath.row]
        
        cell.palavraDaSemanaLabel.text = palavra.word
        cell.palavraDaSemanaDescription.text = palavra.description
        cell.palavraDaSemanaDate.text = palavra.date
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            postItemList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            self.tableView.reloadData()
        }
    }

//    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let favorite = favoriteAction(at: indexPath)
//        return UISwipeActionsConfiguration(actions: [favorite])
//    }
//    
//    func favoriteAction(at: IndexPath) -> UIContextualAction
//    {
//        
//    }
}
