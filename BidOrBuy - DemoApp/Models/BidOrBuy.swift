//
//  BidOrBuy.swift
//  BidOrBuy - DemoApp
//
//  Created by Jerry Boyd PTY on 2020/11/17.
//  Copyright © 2020 Codenamerhu. All rights reserved.
//

import Foundation

public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

class BidOrBuy{
    
    var totalResults: Int?
    var pageNumber: Int?
    var resultsPerPage: Int?
    var trades = [Trade]()
    var images = [Images]()
    
    
    init?(data: Data) {
        
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] {
                
                
                self.totalResults = json["totalResults"] as? Int
                self.pageNumber = json["totalResults"] as? Int
                self.resultsPerPage = json["resultsPerPgae"] as? Int
                
                if let trades = json["trade"] as? [[String:Any]] {
                    self.trades = trades.map { Trade(json: $0) }
                }
            }
            
        } catch {
            print("Error deserializing \(error)")
            
        }
    }
    
}

class Trade {
    
    var images = [Images]()
    var amount: Double?
    var title: String?
    var type: String?
    var userId: Int?
    var hotSelling: Bool?
    var discountPercentage: Double?
    //var ancestorCategoryList = [AncestorCategoryList]()
    var categoryBreadCrumb: String?
    var buyNowAmount: Double?
    var userAlias: String?
    var closeTime: String?
    var bidCount: Int?
    var location: String?
    var homeCategoryId: Int?
    var openTime: String?
    var tradeId: Int?
    var status: String?
    
    var image: String?
    var thumbnail: String?
    
    init(json: [String:Any]) {
        self.amount                 = json["amount"] as? Double
        self.title                  = json["title"] as? String
        self.type                   = json["userId"] as? String
        self.userId                 = json["userId"] as? Int
        self.hotSelling             = json["hotSelling"] as? Bool
        self.discountPercentage     = json["discountPercentage"] as? Double
        self.categoryBreadCrumb     = json["categoryBreadCrumb"] as? String
        self.buyNowAmount           = json["buyNowAmount"] as? Double
        self.userAlias              = json["userAlias"] as? String
        self.closeTime              = json["closeTime"] as? String
        self.bidCount               = json["bidCount"] as? Int
        self.location               = json["location"] as? String
        self.homeCategoryId         = json["homeCategoryId"] as? Int
        self.openTime               = json["openTime"] as? String
        self.tradeId                = json["tradeId"] as? Int
        self.status                 = json["status"] as? String
        
        if let images = json["images"] as? [[String:Any]] {
            self.images = images.map { Images(json: $0) }
    
        }
        
        if let images = json["images"] as? [[String:Any]] {
            self.images = images.map { Images(json: $0) }
            
            print("uiu \(String(describing: images[0]["thumbnail"]!))")
            self.thumbnail = "\(String(describing: images[0]["thumbnail"]!))"
            self.image = "\(String(describing: images[0]["image"]!))"
        }
        
        
        
    }
}

class Images {
    
    var image: String?
    var thumbnail: String?
    
    init(json: [String:Any]) {
        
        self.image = json["image"] as? String
        self.thumbnail = json["thumbnail"] as? String
        print("tum \(thumbnail)")
    }
}


