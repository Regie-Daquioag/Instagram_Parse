//
//  HomeFeedViewController.swift
//  instagram
//
//  Created by Regie Daquioag on 2/24/18.
//  Copyright © 2018 Regie Daquioag. All rights reserved.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts : [PFObject] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeFeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        retrieveData()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        retrieveData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            // PFUser.current() will now be nil
            self.performSegue(withIdentifier: "OnLogout", sender: nil)
        }
    }
   
    
    @IBAction func OnCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "OnCompose", sender: nil)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
//        // put code in here that deals with the PostCell
        let post = posts[indexPath.row]
        let caption = post["caption"] as! String
        cell.PostCellLabel.text = caption
        print(caption)
        if let imageFile : PFFile = post["media"] as? PFFile{
            imageFile.getDataInBackground(block: { (data, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        // Async main thread
                        let image = UIImage(data: data!)
                        cell.PostCellImage.image = image
                    }
                } else {
                    print(error!.localizedDescription)
                }
            })
        }
        return cell
    }
    
    func retrieveData(){
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (Post, error: Error?) -> Void in
            if let posts = Post {
                // do something with the data fetched
                print(posts)
                // passing over my local posts to my global posts
                self.posts = posts
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                // handle error
                print("Could not retrieve info from database")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OnDetail"{
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let post = posts[indexPath.row]
            let detailViewController = segue.destination as! DetaillViewController
            detailViewController.post = post
        }
        }
    }
    
    
}
