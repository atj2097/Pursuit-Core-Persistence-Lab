//
//  InitialViewController.swift
//  fileManagerApp
//
//  Created by God on 10/1/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var imageHits: [Hit] = [] {
        didSet {
            imageCollectionView.reloadData()
        }
    }
        var searchString: String? = nil {
            didSet {
                loadDataFromSearch()
                imageCollectionView.reloadData()
                
            }
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    
        private func loadDataFromSearch() {
            if let searchString = searchString {
                PixabayAPIManager.shared.getImages(searchWord: searchString) { (result) in
                    DispatchQueue.main.async {
                       switch result {
                        case .success(let imagesFromOnline):
                            print(self.imageHits)
                            self.imageHits = imagesFromOnline
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
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
extension InitialViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return  imageHits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageHit = imageHits[indexPath.row]
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageView", for: indexPath) as? ImageCollectionViewCell
            else { return UICollectionViewCell() }
        ImageHelper.shared.getImage(urlStr: imageHit.largeImageURL!) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    cell.currentImage.image = imageFromOnline
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newImage = imageHits[indexPath.row]
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Details") as! DVCViewController
        nextViewController.imageHit = newImage
self.present(nextViewController, animated:true, completion:nil)
    }
    
}
extension InitialViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText
    }
}
extension String {
    func replaceSpaces() -> String {
       
       return self.replacingOccurrences(of: " ", with: "+")
        
    }
}
