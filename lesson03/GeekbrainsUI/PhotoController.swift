

import UIKit

private let reuseIdentifier = "Photo"

class PhotoController: UICollectionViewController {

    var photoCollection = [1] //всегда одна фотография выводится
    var user:String? //имя пользователя, пришедшее с пред. экрана
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollection.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as! PhotoCell
      
        //хулиганство - присваиваю пользователю NewUser5, NewUser6,...NewUserX текст NewUser и иконку с названием NewUser. Другим пользователям - иконку с названием равным имени пользователя
        var ls_defaultusername:String=""
        if user!.hasPrefix("NewUser") == true{
            //получается дефолтная иконка NewUser.jpg
        ls_defaultusername = "NewUser"
        }
        else{
        ls_defaultusername = user!
        }
        
        cell.cell_username.text = ls_defaultusername
        cell.photo.image = UIImage(named: "\(ls_defaultusername).jpg")

        return cell
    }
 
 
}// class PhotoController

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var cell_username: UILabel!
   
}
