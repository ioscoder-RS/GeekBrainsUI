

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotoController: UICollectionViewController,  UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
  
    var tmpFriend: Friend? //текущий элемент Друг типа структура, на котором стоим
    var viewClicked: ((UIView)->())? = nil
    var photoArray: [VKPhoto]?
    

    private var selectedFrame: CGRect? = .zero
    var customInteractor: CustomInteractor?
    var tmpImage: UIImage? // текущая картинка, на которой стоим
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.navigationController?.delegate = self
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return photoCollection.count
        guard let tmpPhotoarray = photoArray?.count else {return 1}
    return tmpPhotoarray
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        var imageToLoad: String
        
        guard let defaultUsername = tmpFriend?.userName else {return cell}
        guard let defaultAvatarPath = photoArray?[indexPath.row] else {return cell}
        
//      imageToLoad = defaultAvatarPath
 
            cell.cellUsername.text = defaultUsername
        
        //асинхронная загрузка фотографий из интернета
        let url = URL(string: defaultAvatarPath.sizes[0].url)
           DispatchQueue.global().async {
               if let data = try? Data(contentsOf: url!) {
               DispatchQueue.main.async {
                   cell.photo.image = UIImage(data: data)
               }
               } else{
                   cell.photo.image = UIImage(named: "NewUser.jpg")
               }
               
           }//DispatchQueue.global().async
        

        return cell
    }
    
        //вызывает экран MusicPlayerViewController
    //запоминает выбранную (песню = экземпляр структуры) и фрейм
      override  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       //       self.selectedSong = songs[indexPath.row]
              let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
              selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "FriendsPhotoViewController") as! FriendsPhotoViewController
    // viewController.friend = tmpFriend
    //    tmpImage = UIImage(named:(photoArray![indexPath.row]))
        viewController.indexImage = indexPath.row
        viewController.indexText = tmpFriend?.userName
     self.navigationController?.pushViewController(viewController, animated: true)
          }
    

        //вызывает анимацию перехода
    //    We want to create a property that stores the frame of the selected cell.  In the didSelectItem function, we want to modify it a little bit so we grab the cells frame, but specifically the frame of the cell relative to that of the ViewController:
     func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = self.selectedFrame else { return nil }
         guard let tmpimage = self.tmpImage else {return nil}
      
     //       Now we have the selectedFrame, and we can access the selected image from our array of songs, we’re finally ready to implement the CustomAnimator. Because we’ve inherited from UINavigationControllerDelegate, we can implement the method that is used to override the default animation.
        switch operation {
        case .push:
             self.customInteractor = CustomInteractor(attachTo: toVC)
             return CustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: true, originFrame: frame, image: tmpimage)
        default:
         return CustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: false, originFrame: frame, image: tmpimage)
        }
        }//func navigationController(_ navigationController: UINavigationController, animationControllerFor operation:
     
     func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
         guard let ci = customInteractor else { return nil }
         return ci.transitionInProgress ? customInteractor : nil
     }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        (sender as! LikeButton).like()
    }
        
}// class PhotoController

