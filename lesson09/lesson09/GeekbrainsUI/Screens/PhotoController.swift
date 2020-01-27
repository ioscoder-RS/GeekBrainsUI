

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotoController: UICollectionViewController {
    
    var photoCollection = [5] //всегда одна фотография выводится
    var inputUser:String? //имя пользователя, пришедшее с пред. экрана
    var avatarPath:String? //путь на фото пользователя,  пришедшее с пред. экрана
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollection.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        var imageToLoad: String
        
        guard let defaultUsername = inputUser else {return cell}
        guard let defaultAvatarPath = avatarPath else {return cell}
        
        imageToLoad = defaultAvatarPath
 
            cell.cellUsername.text = defaultUsername
        
            //Либо находим в Assets файл с именем imageToLoad или подставляем default картинку
            if (UIImage(named: "\(imageToLoad)") != nil) {
                cell.photo.image = UIImage(named: "\(imageToLoad).jpg")
            }
            else {
                cell.photo.image = UIImage(named: "NewUser.jpg")
            }


        return cell
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        (sender as! LikeButton).like()
    }
    
    
}// class PhotoController


