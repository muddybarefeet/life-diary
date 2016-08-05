//
//  TheySaidSoQuoteClient.swift
//  lifeDiary
//
//  Created by Anna Rogers on 8/4/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class TheySaidSoQuoteClient {
    
    static let sharedInstance = TheySaidSoQuoteClient()
    private init() {}
    
    func getInspirationalQuote (completionHandlerForQuote: (data: AnyObject?, error: String?) -> Void) {
        print("sending request")
        let request = NSMutableURLRequest(URL: NSURL(string: "http://quotes.rest/qod.json?category=inspire")!)
        sendRequest(request) { (data, response, error) in
            if error == nil {
                guard let data = data!["contents"]! else {
                    completionHandlerForQuote(data: nil, error: "Not have content key on response")
                    return
                }
                guard let quotes = data["quotes"] else {
                    completionHandlerForQuote(data: nil, error: "Not have quotes key on response")
                    return
                }
                guard let quoteObj = quotes![0] else {
                    completionHandlerForQuote(data: nil, error: "No quote data")
                    return
                }
                completionHandlerForQuote(data: quoteObj, error: nil)
            } else {
                print("bad request", error)
                completionHandlerForQuote(data: nil, error: "No quote data")
            }
        }
    }
    
    private func sendRequest (request: NSMutableURLRequest, completionHandlerForRequest: (data: AnyObject?, response: NSHTTPURLResponse?, error: String?) -> Void) {
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if error != nil {
                completionHandlerForRequest(data: nil, response: nil, error: "There was an error in the request response")
                return
            }
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                completionHandlerForRequest(data: nil, response: (response as! NSHTTPURLResponse), error: "The status code returned was not a OK")
                return
            }
            guard let data = data else {
                completionHandlerForRequest(data: nil, response: (response as! NSHTTPURLResponse), error: "No data returned from the API")
                return
            }
            var parsedResult: AnyObject?
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                completionHandlerForRequest(data: nil, response: (response as! NSHTTPURLResponse), error: "Could not parse the response to a readable format")
                return
            }
            completionHandlerForRequest(data: parsedResult, response: (response as! NSHTTPURLResponse), error: nil)
        }
        task.resume()
    }

    
}
