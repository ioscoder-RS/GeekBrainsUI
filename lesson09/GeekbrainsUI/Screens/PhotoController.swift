

import UIKit
import INSPhotoGallery


private let reuseIdentifier = "PhotoCell"


@objc public protocol INSPhotoViewable: class {
    var image: UIImage? { get }
    var thumbnailImage: UIImage? { get }

    func loadImageWithCompletionHandler(completion: (_ image: UIImage?, _ error: NSError?) -> ())
    func loadThumbnailImageWithCompletionHandler(completion: (_ image: UIImage?, _ error: NSError?) -> ())

    var attributedTitle: NSAttributedString? { get }
}

class PhotoController: UICollectionViewController {
    
    lazy var photos: [INSPhotoViewable] = {
        return [
            INSPhoto(image: UIImage(named: "NewUser.jpg"),  thumbnailImage: UIImage(named: "UserOne.jpg")!),
    INSPhoto(image: UIImage(named: "NewUser.jpg"),  thumbnailImage: UIImage(named: "UserOne.jpg")!),
        INSPhoto(image: UIImage(named: "NewUser.jpg"),  thumbnailImage: UIImage(named: "UserOne.jpg")!)
        ]
        }() as! [INSPhotoViewable]

    
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

        let currentPhoto = photos[indexPath.row]
        let galleryPreview = INSPhotosViewController(photos: photos as! [INSPhotoGallery.INSPhotoViewable] , initialPhoto: currentPhoto as! INSPhotoGallery.INSPhotoViewable, referenceView: cell)

  /*      galleryPreview.referenceViewForPhotoWhenDismissingHandler = { [weak self] photo in
            if let index = self?.photos.indexOf({$0 === photo}) {
          //      let indexPath = NSIndexPath(forItem: index, inSection: 0)
                return collectionView.cellForItemAtIndexPath(indexPath) as? ExampleCollectionViewCell
            }
            return nil
        }*/
        present(galleryPreview, animated: true, completion: nil)

        return cell
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        (sender as! LikeButton).like()
    }
    
    
}// class PhotoController


