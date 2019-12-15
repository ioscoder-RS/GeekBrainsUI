

import UIKit

private let reuseIdentifier = "Photo"

class PhotoController: UICollectionViewController {

    var photoCollection = [5] //всегда одна фотография выводится
    var inputUser:String? //имя пользователя, пришедшее с пред. экрана
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollection.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as! PhotoCell
      
      var defaultUsername:String?
        
       defaultUsername = inputUser
      
        if let imageToLoad = defaultUsername {
        //Либо находим в Assets файл с именем imageToLoad или подставляем default картинку
           if (UIImage(named: "\(imageToLoad)") != nil) {
             cell.photo.image = UIImage(named: "\(imageToLoad).jpg")
           }
           else {
             cell.photo.image = UIImage(named: "NewUser.jpg")
           }
            cell.cellUsername.text = imageToLoad
        }
        

        return cell
    }
 
    @IBAction func likeButtonPressed(_ sender: Any) {
     (sender as! LikeButton).like()
    }
    
    
}// class PhotoController

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!   
    @IBOutlet weak var cellUsername: UILabel!
    
      

}
