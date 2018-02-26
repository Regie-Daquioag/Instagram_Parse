//
//  DetaillViewController.swift
//  instagram
//
//  Created by Regie Daquioag on 2/25/18.
//  Copyright © 2018 Regie Daquioag. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetaillViewController: UIViewController {
    
    var post : PFObject?
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailPostDateLabel: UILabel!
    @IBOutlet weak var detailCaption: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let post = post {
            self.detailCaption.text = post["caption"] as! String
            
            let dateCreated = post.createdAt! as Date
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "EEE, MMM d, h:mm a"
            detailPostDateLabel.text = NSString(format: "%@", dateFormat.string(from: dateCreated)) as String
            
            if let imageFile : PFFile = post["media"] as? PFFile{
                imageFile.getDataInBackground(block: { (data, error) in
                    if error == nil {
                        DispatchQueue.main.async {
                            // Async main thread
                            let image = UIImage(data: data!)
                            self.detailImageView.image = image
                        }
                    } else {
                        print(error!.localizedDescription)
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
