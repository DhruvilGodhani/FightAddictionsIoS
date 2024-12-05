//
//  ViewController.swift
//  FightAddictionsSegment
//
//  Created by ADMIN on 05/12/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var table2: UITableView!
    var quotes: [QuoteModel] = []
    var quotesCD: [QuoteModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        table1.dataSource = self
        table1.delegate = self
        table2.dataSource = self
        table2.delegate = self
        table2.isHidden = true
        table1.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        table2.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        segment.selectedSegmentIndex = 0
        callApi{
            res in
            switch res{
            case .success(let data):
                self.quotes = data
                self.table1.reloadData()
            case .failure(let err):
                debugPrint(err)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func changeSegment(_ sender: Any) {
        DispatchQueue.main.async {
            if self.segment.selectedSegmentIndex == 0{
                self.table1.isHidden = true
                self.table2.isHidden = false
            }else{
                self.quotesCD = CDManager().readFromCd()
                self.table2.reloadData()
                self.table1.isHidden = false
                self.table2.isHidden = true
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table1.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.label.text = quotes[indexPath.row].quote
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .insert:
            CDManager().AddToCd(quoteToAdd: quotes[indexPath.row])
        case .none:
            <#code#>
        case .delete:
            <#code#>
        @unknown default:
            <#code#>
        }
    }
}

