//
//  TradeTableViewCell.swift
//  BidOrBuy - DemoApp
//
//  Created by Rhulani Ndhlovu on 2020/11/15.
//  Copyright © 2020 Codenamerhu. All rights reserved.
//

import UIKit

protocol TradeDataCellDelegate {
}

class TradeTableViewCell: UITableViewCell {

    @IBOutlet weak var tradeImage: UIImageView!
    @IBOutlet weak var tradeTitle: UILabel!
    @IBOutlet weak var expiryDateTme: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var addToWishListButton: UIButton!
    var view = UIView()
    
    static let identifier = "TradeCell"
    
    var item: Trade? {
        didSet {
            guard let item = item else {
                return
            }
            
            
            tradeTitle.text = item.title
            amountLabel.text = "\(item.amount!)"
            let closeTime = item.closeTime
            
            
            
            let isoDate = closeTime

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from:isoDate!)!
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            
            var mon = ""
            
            switch components.month! {
            case 12:
                mon = "Dec"
            case 11:
                mon = "Nov"
            case 10:
                mon = "Oct"
            case 9:
                mon = "Sep"
            case 8:
                mon = "Aug"
            case 7:
                mon = "Jul"
            case 6:
                mon = "Jun"
            case 5:
                mon = "May"
            case 4:
                mon = "Apr"
            case 3:
                mon = "Mar"
            case 2:
                mon = "Feb"
            case 1:
                mon = "Jan"
            default:
                mon = "jan"
            }
                
            
            expiryDateTme.text = "End \(components.day!) \(mon) \(components.hour!):\(components.minute!)"

            
            print("yuy \(item.thumbnail!)")
            guard let url = URL(string: item.image!) else { return }

            UIImage.loadFrom(url: url) { image in
                
                self.tradeImage.image = image
            }
            
        }
    }
    
    
    var delegate: TradeDataCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func configure() {
        
        
    }

}

extension UIImage {

    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}

