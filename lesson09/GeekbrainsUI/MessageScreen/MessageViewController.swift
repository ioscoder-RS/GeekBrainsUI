//
//  MessageViewController.swift
//  GeekbrainsUI
//
//  Created by raskin-sa on 13/12/2019.
//  Copyright © 2019 raskin-sa. All rights reserved.
//

//3. Создать экран новостей. Добавить туда таблицу и сделать ячейку для новости. Ячейка должна содержать то же самое, что и в оригинальном приложении ВКонтакте: надпись, фотографии, кнопки «Мне нравится», «Комментировать», «Поделиться» и индикатор количества просмотров. Сделать поддержку только одной фотографии, которая должна быть квадратной формы и растягиваться на всю ширину ячейки. Высота ячейки должна вычисляться автоматически.

import UIKit


class NewsDatabase {
    static func getNews() -> [News]{
        return myNews
    }
}

class MessageViewController: UITableViewController{
    
    var messageArray = NewsDatabase.getNews()
    
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
        cell?.message.text = messageArray[indexPath.row].newsText
        cell?.username.text = messageArray[indexPath.row].writer
        cell?.avatar.image = UIImage(named: messageArray[indexPath.row].imagePath)
        return cell!
    }
    
    
}// class MessageViewController
