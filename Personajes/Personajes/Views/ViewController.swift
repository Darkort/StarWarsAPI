//
//  ViewController.swift
//  Personajes
//
//  Created by Alejandro Cantos on 05/04/2019.
//  Copyright © 2019 Alejandro Cantos. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var connection = MoyaConnection()
    var nextPage: Int?
    var characters: [Character] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var log: UILabel!
    
    
    override func viewDidLoad() {
        refresh()
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func refreshClick(_ sender: Any) {
        refresh()
    }
    @IBAction func CancelClick(_ sender: Any) {
        if(connection.request != nil){
            connection.request?.cancel()
        }
    }
    
    
    func refresh(){
        characters.removeAll()
        nextPage = 1
        
        tableView.reloadData()
        cancelButton.isEnabled = true
        spinner.startAnimating()
        refreshButton.isEnabled = false
        log.text = ""

        getNextPage()
    }
    
    func getNextPage(){
        
        
        if let next = nextPage{
            connection.getPage(page: next){ page, error in
                if error != nil{
                    self.updateUIonRequestFinished(error: error)
                } else {
                    if let results = page?.results{
                        for character in results{
                            self.characters.append(character)
                        }
                    }
                    if page?.next != nil{
                        self.nextPage = next + 1
                    }else{
                        self.nextPage = nil;
                    }
                    self.updateUIonRequestFinished(error: nil)
                }
            }
        }else if !characters.isEmpty{
            self.updateUIonRequestFinished(error: nil)
            self.log.textColor = UIColor.orange
            self.log.text = "Todas las páginas cargadas"
            
        }
        
    }
    
    func updateUIonRequestFinished(error: Error?){
        self.tableView.reloadData()
        cancelButton.isEnabled = false
        spinner.stopAnimating()
        refreshButton.isEnabled = true
        
        if error == nil{
            log.textColor = UIColor.green
            log.text = "Petición Completada"
        }else{
            self.log.textColor = UIColor.red
            self.log.text = error?.localizedDescription
        }
    }
  
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "toDetail"{
            let detailView = segue.destination as! DetailViewController
            
            let indexPath = tableView.indexPathForSelectedRow!
        
            detailView.character =  characters[indexPath.row]
            
        }
        
    }

    
    //TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell{
            cell.updateText(character: characters[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as UITableViewCell
            return cell
        }
        
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height)+10 {
            tableView.reloadData()
            cancelButton.isEnabled = true
            spinner.startAnimating()
            refreshButton.isEnabled = false
            log.text = ""
            
            getNextPage()
        }
    }
    
    
}
