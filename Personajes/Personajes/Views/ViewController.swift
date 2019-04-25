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
    var nextPage: Int = 1
    var pages: [Page] = []
    
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
        pages.removeAll()
        nextPage = 1
        
        tableView.reloadData()
        cancelButton.isEnabled = true
        spinner.startAnimating()
        refreshButton.isEnabled = false
        log.text = ""

        getNextPage()
    }
    
    func getNextPage(){
        
        if !pages.isEmpty && pages.last?.next == nil{
            self.updateUIonRequestFinished(error: nil)
            self.log.textColor = UIColor.orange
            self.log.text = "Todas las páginas cargadas"
            return
        }
        
        connection.getPage(page: nextPage){ page, error in
            if error != nil{
                self.updateUIonRequestFinished(error: error)
            } else {
                self.pages.append(page!)
                self.nextPage += 1
                self.updateUIonRequestFinished(error: nil)
            }
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
            let page = getRowPosition(indexPath: indexPath)[0]
            let index = getRowPosition(indexPath: indexPath)[1]
            
            detailView.pages = pages
            detailView.character = pages[page].results[index]
            
        }
        
    }

    
    //TableView Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
            for page in pages{
                count += page.results.count
            }
        
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //unwraping!
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        
        let page = getRowPosition(indexPath: indexPath)[0]
        let index = getRowPosition(indexPath: indexPath)[1]
        
        cell.characterName.text = pages[page].results[index].name
        cell.characterBirth.text = pages[page].results[index].birth
        cell.characterGender.text = pages[page].results[index].gender
        cell.characterHeight.text = pages[page].results[index].height
        cell.characterWeight.text = pages[page].results[index].weight
        
        return cell
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
    
    func getRowPosition(indexPath: IndexPath)->[Int]{
        // coord[0] = people page, coord[1] = character index
        var position = [0,indexPath.row]
        while pages[position[0]].results.count-1 < position[1]{
            position[1] -= pages[position[0]].results.count
            position[0] += 1
        }
        return position
    }
}
