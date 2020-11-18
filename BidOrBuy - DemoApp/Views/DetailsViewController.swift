//
//  DetailsViewController.swift
//  BidOrBuy - DemoApp
//
//  Created by Jerry Boyd PTY on 2020/11/17.
//  Copyright © 2020 Codenamerhu. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController : UIViewController {
    
    
    @IBOutlet weak var tradeImage: UIImageView!
    @IBOutlet weak var tradeTitle: UILabel!
    @IBOutlet weak var bidNow: UILabel!
    @IBOutlet weak var buyNow: UILabel!
    @IBOutlet weak var closeTime: UILabel!
    
    var item: Trade?
    
    var tit: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationController!.navigationBar.isHidden = false
        let img = (String(describing: item?.image))
        print("bug \(item?.amount)")
        tit = item?.title
                
        guard let url = URL(string: img) else { return }
        UIImage.loadFrom(url: url) { image in
                    
            //self.tradeImage.image = image
        }
            
        
    }
    
    
}
