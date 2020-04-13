//
//  PlanningViewController.swift
//  Me and Mine
//
//  Created by Amaya Finklea on 3/19/20.
//  Copyright © 2020 Logan. All rights reserved.
//


import Foundation
import UIKit
import CodableFirebase
import Firebase


// UI
// Network Request
// Tap a cell to see info about the movie
// Custom cell


//get rid of UItextfeild delegate
class PlanningViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article]=[]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.articles.count
        
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleTableViewCell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.displayText
       // cell.imageView?.image = article.displayImage
        return cell
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.isViewLoaded {
            self.tableView.reloadData()
        }
    }
    
    
    func fetchArticles() {

        
        let basicQuery = Firestore.firestore().collection("Articles").limit(to: 50)
        basicQuery.getDocuments { (snapshot, error) in
            if let error = error {
                print("Oh no! Got an error! \(error.localizedDescription)")
                return
            }
            guard let snapshot = snapshot else { return }
            let allDocuments = snapshot.documents
            for articleListing in allDocuments {
              //  print("I have this restaurant \(restaurantDocument.data())")
                
                let article  = try! FirestoreDecoder().decode(Article.self, from: articleListing.data())
                
                self.articles.append(article)
            }
            self.tableView.reloadData()
            
        }
        
    }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     guard let articleViewController = segue.destination as? ArticleViewController else {
        return}
       
      if let indexPath = tableView.indexPathForSelectedRow,
        segue.identifier == "articleDetailSegue" {
        articleViewController.article = articles[indexPath.row]
      }
    }
    

}

struct Article: Codable  {
    let website: String
    let displayText: String
    
}

