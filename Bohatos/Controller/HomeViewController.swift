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
//    var palavraDaSemanaList: [PalavraDaSemana] = [PalavraDaSemana(postDate: "10/10/2018", word: "Zigmeutica", description: "subst. fem. Aquilo que é zigmo"),
//                                                  PalavraDaSemana(postDate: "10/10/2018", word: "Zigmeutica", description: "subst. fem. Aquilo que é zigmo"),
//                                                  PalavraDaSemana(postDate: "10/10/2018", word: "Pentateuco", description: "do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
//                                                  PalavraDaSemana(postDate: "10/10/2018", word: "Zigmeutica", description: "subst. fem. Aquilo que é zigmo")]
   // var palavraDaSemanaList: [PalavraDaSemana] = []
    var postItemList: [PostItem] = []
    
    
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
                    let postItem: PostItem = PostItem(userId: post.userId, id: post.id, title: post.title, body: post.body)
                    self.postItemList.append(postItem)
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
    
    override func viewWillAppear(_ animated: Bool) {
        

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "palavraDaSemanaCell", for: indexPath) as! PalavraDaSemanaTableViewCell
        
        let palavra = postItemList[indexPath.row]
        
        cell.palavraDaSemanaLabel.text = palavra.title
        cell.palavraDaSemanaDescription.text = palavra.body
        cell.palavraDaSemanaDate.text = String(palavra.userId)
        
        
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        <#code#>
    }
    
    
}
