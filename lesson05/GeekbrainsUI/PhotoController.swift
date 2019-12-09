

import UIKit

private let reuseIdentifier = "Photo"

class PhotoController: UICollectionViewController {

    var photoCollection = [1] //всегда одна фотография выводится
    var user_:String? //имя пользователя, пришедшее с пред. экрана
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollection.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as! PhotoCell
      
      var ls_defaultusername:String?
        
       ls_defaultusername = user_
      
        if let imageToLoad = ls_defaultusername {
        //Либо находим в Assets файл с именем imageToLoad или подставляем default картинку
           if (UIImage(named: "\(imageToLoad)") != nil) {
             cell.photo.image = UIImage(named: "\(imageToLoad).jpg")
           }
           else {
             cell.photo.image = UIImage(named: "NewUser.jpg")
           }
            cell.cell_username.text = imageToLoad
        }
        

        return cell
    }
 
    @IBAction func likeButtonPressed(_ sender: Any) {
     (sender as! LikeButton).like()
    }
    
    
}// class PhotoController

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var cell_username: UILabel!
   

      

}
