//
//  ResultTableViewCell.swift
//  BidOrBuy - DemoApp
//
//  Created by Rhulani Ndhlovu on 2020/11/15.
//  Copyright © 2020 Codenamerhu. All rights reserved.
//

import UIKit

protocol ResultDataCellDelegate {
}

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    
    static let identifier = "ResultCell"
    
    var item: BidOrBuyViewModelItem? {
        didSet {
            guard let item = item as? BidOrBuyViewModelTotalResults else {
                return
            }
            resultsLabel?.text = "Results(\(item.totalResults))"
        }
    }
    
    var delegate: ResultDataCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(){
        
        self.resultsLabel.text = "2"
    }

}
