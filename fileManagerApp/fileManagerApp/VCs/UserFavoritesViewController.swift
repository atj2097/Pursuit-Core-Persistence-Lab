//
//  UserFavoritesViewController.swift
//  fileManagerApp
//
//  Created by God on 10/1/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class UserFavoritesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var imageHit = [Hit]() {
        didSet {
            collectionView.reloadData()
        }
    }
    func loadData(){
        do {
            imageHit = try ImagePersistenceHelper.manager.getImages()
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UserFavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return imageHit.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hit = imageHit[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! UserCell
        ImageHelper.shared.getImage(urlStr: hit.largeImageURL!) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    cell.favImage.image = imageFromOnline
                }
            }
        }
        return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newImage = imageHit[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Details") as! DVCViewController
        nextViewController.imageHit = newImage
        self.present(nextViewController, animated:true, completion:nil)
    }
        
    }
    
    

