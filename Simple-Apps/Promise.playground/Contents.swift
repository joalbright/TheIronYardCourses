//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

class PromiseRequest {
    
    private var success: (info: AnyObject?) -> () = { info in }
    private var failure: (error: NSError?) -> () = { error in }
    
    func onSuccess(success:(info: AnyObject?) -> ()) -> PromiseRequest {
        
        self.success = success
        return self
        
    }
    
    func onFailure(failure:(error: NSError?) -> ()) -> PromiseRequest {
        
        self.failure = failure
        return self
        
    }
    
    class func makeRequest(request: NSURLRequest) -> PromiseRequest {
        
        let pr = PromiseRequest()
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if error != nil {
                
                pr.failure(error: error)
                
            } else {
                
                guard let d = data else { return pr.success(info: nil) }
                
                let json = try? NSJSONSerialization.JSONObjectWithData(d, options: .MutableContainers)
                
                pr.success(info: json)
                
            }
            
        }
        
        task.resume()
        
        return pr
        
    }
    
}

func runPromise() {
    
    guard let url = NSURL(string: "http://google.com") else { return }
    
    PromiseRequest.makeRequest(NSURLRequest(URL: url)).onSuccess { (info) -> () in
        
        print(info)
        
    }.onFailure { (error) -> () in
            
        print(error)
            
    }
    
}

runPromise()
