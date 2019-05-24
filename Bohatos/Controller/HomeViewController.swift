//
//  HomeViewController.swift
//  Bohatos
//
//  Created by Hatos Barbosa on 21/05/19.
//  Copyright © 2019 Hatos Barbosa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
   
    @IBOutlet weak var tableView: UITableView!
    var postItemList: [PostItem] = []
    var filteredPostItemList: [PostItem] = []
    var searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 400

        if let path = Bundle.main.path(forResource: "db", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                

                let decoder = JSONDecoder()
                let response = try decoder.decode([PostItem].self, from: data)
                
                
                let postWithImage = PostWithImage()
                postWithImage.date = "10/10/2019"
                postWithImage.description = "Você não pode fazer isso. Tenho certeza."
                postWithImage.word = "Não lamba seu cotovelo."
                postWithImage.image = UIImage(named: "Elbow")
                self.postItemList.append(postWithImage)
                
                
                for post in response{
                    self.postItemList.append(post)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("failed")
            }
        }
        
        
        // Searchbar - Setup
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true    // try changing that later
        searchController.searchBar.placeholder = "Buscar palavras"
        navigationItem.searchController = searchController
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditing))
        editButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = editButton
        
        
        definesPresentationContext = true
        
        
    }
    
    //MARK:- TableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredPostItemList.count
        }
        return postItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if( !isFiltering() && self.postItemList[indexPath.row] is PostWithImage) ||
          (isFiltering() && self.filteredPostItemList[indexPath.row] is PostWithImage)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "palavraComImagemCell", for: indexPath) as! CuriosidadeDaSemanaTableViewCell
            
            
            let curiosidade:PostWithImage
            
            if isFiltering() {
                curiosidade = filteredPostItemList[indexPath.row] as! PostWithImage
            } else {
                curiosidade = postItemList[indexPath.row] as! PostWithImage
            }
           
                cell.curiosidadeTitleLabel.text = curiosidade.word
                cell.curiosidadeDescriptionLabel.text = curiosidade.description
                cell.curiosidadeDate.text = curiosidade.date
                cell.curiosidadeImage = UIImageView(image: curiosidade.image)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "palavraDaSemanaCell", for: indexPath) as! PalavraDaSemanaTableViewCell
            
            
            let palavra:PostItem
            
            if isFiltering() {
                palavra = filteredPostItemList[indexPath.row]
            } else {
                palavra = postItemList[indexPath.row]
            }
            
            cell.palavraDaSemanaLabel.text = palavra.word
            cell.palavraDaSemanaDescription.text = palavra.description
            cell.palavraDaSemanaDate.text = palavra.date

            
            return cell
            
            
        }
    
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            postItemList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
            tableView.endUpdates()
           
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All")
    {
        filteredPostItemList = postItemList.filter({(post: PostItem) -> Bool in
            return post.word.lowercased().contains(searchText.lowercased())
        })
        
        self.tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    // MARK:- SearchBar - SearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    @objc private func toggleEditing() {
        self.tableView.setEditing(!self.tableView.isEditing, animated: true) // Set opposite value of current editing status
        navigationItem.rightBarButtonItem?.title = self.tableView.isEditing ? "Done" : "Edit" // Set title depending on the editing status
    }
    
}


