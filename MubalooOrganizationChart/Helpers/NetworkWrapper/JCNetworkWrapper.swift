//
//  Created by João Carreira on 24/01/16.
//  Copyright © 2016 jpcarreira. All rights reserved.
//

import Foundation

struct JCNetworkWrapper {
    
    static func get(fromUrl: NSURL, headers: Dictionary<String, String>?, parameters: Dictionary<String, String>?, completionHandler: (AnyObject?, JCNetworkError?) -> Void) {
        
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        if let getHeaders = headers {
            
            sessionConfiguration.HTTPAdditionalHeaders = getHeaders
        }
        
        let session = NSURLSession(configuration: sessionConfiguration)
        let dataTask = session.dataTaskWithURL(fromUrl) { (data, response, error) in
            
            if error == nil {
                
                let httpResponse = response as! NSHTTPURLResponse
                
                if httpResponse.statusCode == 200 {
                    
                    if let jsonData = data {
                        
                        do {
                            
                            let unserializedJson = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
                            
                            if let parsedJsonDictionary = unserializedJson as? [String: AnyObject] {
                                
                                completionHandler(parsedJsonDictionary, nil)
                            } else if let parsedJsonArray = unserializedJson as? Array<AnyObject> {
                                
                                completionHandler(parsedJsonArray, nil)
                            }
                        } catch let error as NSError {
                            
                            completionHandler(nil, JCNetworkError(errorCode: JCNetworkErrorCode.Other.rawValue, errorDetails: error.userInfo))
                        }
                    }
                } else {
                    
                    completionHandler(nil, JCNetworkError(errorCode: httpResponse.statusCode, errorDetails: nil))
                }
            } else {
                
                completionHandler(nil, JCNetworkError(errorCode: JCNetworkErrorCode.NoResponse.rawValue, errorDetails: error?.userInfo))
            }
        }
        
        dataTask.resume()
    }
    
    static func post(toUrl: NSURL, headers: Dictionary<String, String>?, formData: Dictionary<String, String>?, completionHandler: (NSDictionary?, JCNetworkError?) -> Void) {
        
        JCNetworkWrapper.performHttpMethod("POST", url: toUrl, headers: headers, formData: formData, completionHandler: completionHandler)
    }
    
    static func put(toUrl: NSURL, headers: Dictionary<String, String>?, formData: Dictionary<String, String>?, completionHandler: (NSDictionary?, JCNetworkError?) -> Void) {
        
        JCNetworkWrapper.performHttpMethod("PUT", url: toUrl, headers: headers, formData: formData, completionHandler: completionHandler)
    }
    
    static func delete(url: NSURL, headers: Dictionary<String, String>?, formData: Dictionary<String, String>?, completionHandler: (NSDictionary?, JCNetworkError?) -> Void) {
        
        JCNetworkWrapper.performHttpMethod("DELETE", url: url, headers: headers, formData: formData, completionHandler: completionHandler)
    }
    
    private static func performHttpMethod(httpMethod: String, url: NSURL, headers: Dictionary<String, String>?, formData: Dictionary<String, String>?, completionHandler: (NSDictionary?, JCNetworkError?) -> Void) {
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = httpMethod
        
        if let postHeaders = headers {
            
            for (key, value) in postHeaders {
                
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters = formData {
            
            var jsonString: String = ""
            for (key, value) in parameters {
                
                jsonString += key + "=" + value + "&"
            }
            
            let bodyString = jsonString.substringToIndex(jsonString.endIndex.predecessor())
            request.HTTPBody = (bodyString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            if error == nil {
                
                let httpResponse = response as! NSHTTPURLResponse
                
                if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                    
                    if let jsonData = data {
                        
                        do {
                            
                            let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)
                            
                            if let parsedJsonDictionary = jsonDictionary as? [String: AnyObject] {
                                
                                completionHandler(parsedJsonDictionary, nil)
                            }
                        } catch let error as NSError {
                            
                            completionHandler(nil, JCNetworkError(errorCode: JCNetworkErrorCode.Other.rawValue, errorDetails: error.userInfo))
                        }
                    }
                } else if httpResponse.statusCode == 204 {
                  
                    completionHandler(Dictionary<String, String>(), nil)

                } else {
                    
                    completionHandler(nil, JCNetworkError(errorCode: httpResponse.statusCode, errorDetails: nil))
                }
            } else {
                
                completionHandler(nil, JCNetworkError(errorCode: JCNetworkErrorCode.NoResponse.rawValue, errorDetails: error?.userInfo))
            }
        }
        
        task.resume()
    }
}
