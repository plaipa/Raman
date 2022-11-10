//
//  HistoryViewController.swift
//  Raman
//
//  Created by plaipa on 11/9/22.
//

import UIKit

class HistoryViewController: UIViewController {

    
    let modelArray = UserDefaults.standard.array(forKey: "checks") as? [String] ?? [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismissVC()
    }
    

    @IBOutlet weak var historyTableView: UITableView!
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = historyTableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell {
            
            cell.cellLabel.text = modelArray[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
