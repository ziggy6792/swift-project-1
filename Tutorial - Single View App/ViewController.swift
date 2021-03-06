//
//  ViewController.swift
//  Tutorial - Single View App
//
//  Created by Jacque Crossett on 3/25/19.
//  Copyright © 2019 Jacque Crossett. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items.sorted() {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
       
        cell.textLabel?.font = UIFont (name: "HelveticaNeue-UltraLight", size: 30)
        
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
                vc.selectedImage = pictures[indexPath.row]
                vc.imageTitle = "Storm \(indexPath.row + 1) of \(pictures.count)"
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            // Fallback on earlier versions
        }
    }

}

