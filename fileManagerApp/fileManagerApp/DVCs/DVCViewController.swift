//
//  DVCViewController.swift
//  fileManagerApp
//
//  Created by God on 10/1/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

class DVCViewController: UIViewController {
    var imageHit: Hit!
    @IBOutlet weak var imageUrl: UIImageView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBAction func favAction(_ sender: UIButton) {
//        let newSloth = Sloth(appendages: Int(appendagesStepper.value), speed: Int(appendagesStepper.value))
//        DispatchQueue.global(qos: .utility).async {
//            try? SlothPersistenceHelper.manager.save(newSloth: newSloth)
//            DispatchQueue.main.async {
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
        let imageHitNew = imageHit!
        DispatchQueue.global(qos: .utility).async {
            try? ImagePersistenceHelper.manager.save(newImage: imageHitNew)
            DispatchQueue.main.async {
    
                
                
                
                
                
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    func setUp() {
        ImageHelper.shared.getImage(urlStr: imageHit.largeImageURL!) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    self.imageUrl.image = imageFromOnline
                }
            }
        }
        viewLabel.text = "Views: \(imageHit.views!)"
        likesLabel.text = "Likes:\(imageHit.likes!)"
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
