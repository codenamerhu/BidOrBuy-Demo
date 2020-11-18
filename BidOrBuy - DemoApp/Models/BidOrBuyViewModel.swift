//
//  BidOrBuyViewModel.swift
//  BidOrBuy - DemoApp
//
//  Created by Jerry Boyd PTY on 2020/11/17.
//  Copyright © 2020 Codenamerhu. All rights reserved.
//

import Foundation
import UIKit

enum BidOrBuyViewModelItemType {
    case totalResults
    //case pageNumber
    //case resultsPerPage
    case trade
}

protocol BidOrBuyViewModelItem {
    var type: BidOrBuyViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class BidOrBuyViewModel : NSObject {
    var searchQueryParam = "includedKeywords"
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    
    
    var items = [BidOrBuyViewModelItem]()
    
    override init() {
        super.init()
        
        dataTask?.cancel()
         
        
         var urlBuilder = URLComponents(string: Constants.baseUrl+Constants.searchEndpont)
         urlBuilder?.queryItems = [
             URLQueryItem(name: searchQueryParam, value: "tv")
         ]

         guard let url = urlBuilder?.url else { return }

         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.setValue("kfpP9jzHLmoTqRBtzGvxkYYF2GzfWfWhtgHGZVpB", forHTTPHeaderField: "X-BOB-AUTHID")
        
        
        guard var dataTrade = dataFromFile("response"), var bidOrbuy = BidOrBuy(data: dataTrade) else {
            return
        }
        
         dataTask = defaultSession.dataTask(with: request) { (data, response, error) in
             defer {
                 self.dataTask = nil
             }
            
            bidOrbuy = BidOrBuy(data: data!)!
            
        }
        
        dataTask?.resume()
        //print(String(data: data, encoding: .utf8))
        
        
        if let totalResults = bidOrbuy.totalResults {
            let totalResultsItem = BidOrBuyViewModelTotalResults(totalResults: totalResults)
            items.append(totalResultsItem)
        } else {
            print("something went wrong")
        }
        
        let trades = bidOrbuy.trades
        let images = bidOrbuy.images
        
        if !bidOrbuy.trades.isEmpty {
            let tradesItem = BidOrBuyViewModelTradesItem(trades: trades, images: images )
            items.append(tradesItem)
        } else {
            print("something went wrong")
        }
    }
}

extension BidOrBuyViewModel : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("in table")
        let item = items[indexPath.section]
        
        switch item.type {
        case .totalResults:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.identifier, for: indexPath) as? ResultTableViewCell {
                cell.item = item
                return cell
            }
        case .trade:
            if let item = item as? BidOrBuyViewModelTradesItem, let cell = tableView.dequeueReusableCell(withIdentifier: TradeTableViewCell.identifier, for: indexPath) as? TradeTableViewCell {
                let trade = item.trades[indexPath.row]
                cell.item = trade
                return cell
                
            }
        }
        
        return UITableViewCell()
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return UITableView.automaticDimension
        } else {
            
            return 0.0001
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let item = items[indexPath.section]
        
        if let item = item as? BidOrBuyViewModelTradesItem {
            
            let trade = item.trades[indexPath.row]
            
            let viewController = DetailsViewController()
            viewController.item = trade
            
        }
        
        //print("selected \(items)")
        //print(items)
    }
    
    
}

class BidOrBuyViewModelTotalResults: BidOrBuyViewModelItem {
    
    var type: BidOrBuyViewModelItemType {
        return .totalResults
    }
    
    var sectionTitle: String {
        return "Results"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var totalResults: Int
    
    init(totalResults: Int) {
        self.totalResults = totalResults
    }
}

class BidOrBuyViewModelTradesItem: BidOrBuyViewModelItem{
    var type: BidOrBuyViewModelItemType {
        return .trade
    }
    
    var sectionTitle: String {
        return "Trades"
    }
    
    var trades: [Trade]
    var images: [Images]
    
    var rowCount: Int {
        return trades.count
    }
    
    init(trades: [Trade], images: [Images]) {
        self.trades = trades
        self.images = images
        
    }
}
