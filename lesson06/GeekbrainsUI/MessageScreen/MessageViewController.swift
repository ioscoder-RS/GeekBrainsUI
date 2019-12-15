//
//  MessageViewController.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 13/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

import UIKit

class MessageViewController: UITableViewController{
    
    var messageArray = ["longlonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtext","2","longlonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtextlonglonlongtext"]
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "SimpleMessage")
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleMessage", for: indexPath) as? MessageCell
        cell?.message.text = messageArray[indexPath.row]
        return cell!
    }
}// class MessageViewController
