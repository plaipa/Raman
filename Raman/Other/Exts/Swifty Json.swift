//
//  Swifty Json.swift
//  Sakhtman CEO
//
//  Created by plaipa on 12/18/21.
//

import Foundation
import Alamofire
import SwiftyJSON
// makes http calls

struct HttpUtility
{
    
    private init() {}
    static let shared: HttpUtility = HttpUtility()
    let accessToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMTZiOWEyNTYzYjA5OTI2NGI2Zjk5ODFmODJiNGI0Njc3MjliYmZmZjAyMjkxYWQ2NDE2Y2I2MDkzMzRhMzllYWYwMTg2NTZjOGNhNTNlOTkiLCJpYXQiOiIxNjU4OTg3MDIzLjYzMDU2NSIsIm5iZiI6IjE2NTg5ODcwMjMuNjMwNTY3IiwiZXhwIjoiMTY5MDUyMzAyMy42Mjc3NjMiLCJzdWIiOiIxODkiLCJzY29wZXMiOltdfQ.ZLheYtCJccF3wopSvxikcccA1OTtUTMh2Y2Q7FKgpU0Ej2R7AlFKyDqacN2f-er4ugXp_GHaun91j7bi0qjvvtOYiYzVLlzC4WUMIl2hnJvy-fRfrfwLP4TjN0wdxlnlyqJW8o_9NBs1zj6Fdz0-ayLluZ4vTrHRXART1jb9ZwxSX4iD0-GDacGm6lJ_FMsFUWOk4sssSblAlbpwvQ8kJOE9w8gxtm3W61yFINcVb8-LZbsLDNfVpgp54v6V1_VLU7atltAPZ8cG6jIekVyJSS_O4liu0xVhNZIwfpGxPWBVaX3GDoK15ZyTCZc3LvCGFVboqdl2p56_oQDI2ulXpsBekFrlG7tHL23p_D_diqjz6CBKMkuVzVOHhYXGxPQ8zYJ_Xh0M831nP5v2as7Fm39NrLp0C9kTCw6HOD91V39iRYexQThCdDVHoSSXHDPQkVL6bDQhUQ2NeyurRSCz-vbFQ9eQsLNW3PnfHTJ1ECKUJPgdWta1QfPmjqa7FdWefEi7_aL1RVqzfTbC8UOH2dQqBysND65D2x7a3iLtDLqHgVPJDWnMtf3794K7ZE68qp4aLwovDseBnD6G1VpFJH5y_4TgJ7T8UIfdIR0dszD1GnMfLaeC5WZpgy4yDig9lhdYFAibdAQw4GolssQjw4GRMD5ey8Nj2begbtW1E_c"
    
    let userToken = "YWRtaW5AZ21haWwuY29tTU1UUlI5Tk9nb2dxMFgxTFAyQm55NjZ0UU1mbXR6"
    
    
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        
        headers["Accept"] = "application/json"
        headers["access-token"] = userToken
        headers["Authorization"] = accessToken
        return headers
    }
    
    
    func getApiDataJson(requestUrl: String,param:[String:Any], completionHandler:@escaping(_ result: JSON)-> Void)
    {

        
        
        let param = param
        AF.request(requestUrl,method: .get, parameters: param, headers: headers).responseJSON{ (response) in
               
                if response.response?.statusCode == 200{
                    switch response.result {
                    case .success:
                        guard let result = response.value else {
                            return
                        }
                        let json = JSON(result)
                        completionHandler(json)
                    case .failure(let error):
                        print(error)
                    }
                }else{
                    
                }
            }
        
    }
    
    
    
    
    func postApiDataJson(requestUrl: String,param:[String:Any], completionHandler:@escaping(_ result: JSON)-> Void)
    {
        
        
        let param = param
        AF.request(requestUrl,method: .post, parameters: param, headers: headers).responseJSON{ (response) in
               
                if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                    switch response.result {
                    case .success:
                        guard let result = response.value else {
                            return
                        }
                        let json = JSON(result)
                        completionHandler(json)
                    case .failure(let error):
                        print(error)
                    }
                }else{
                    let json = JSON(response.result)
                    completionHandler(json)
                }
            }
        
    }
    
    func postApiWithImageDataJson(requestUrl: String, param: [String:Any],images:[ImageData], completionHandler:@escaping(_ result: JSON)-> Void)
    {
        AF.upload(multipartFormData: { multiPart in
            for p in param {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            for image in images
            {
                multiPart.append(image.data, withName: image.name, fileName: "\(image.name).jpg", mimeType: "image/jpg")
            }
        }, to: requestUrl, method: .post) .uploadProgress(queue: .main, closure: { progress in
//            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
//            print("upload finished: \(data)")
        }).responseJSON { (response) in
            switch response.result {
            case .success(let resut):
//                print("upload success result: \(resut)")
                guard let result = response.value else {
//                    print(response.error.debugDescription)
                 //   showAlert(message: response.error.debugDescription)
                    return
                }
//                print(result)
                let json = JSON(result)
//                print(json)
                completionHandler(json)
            case .failure(let error):
                print(error)
//                showAlert(message: error
//                            .localizedDescription)
            }
        }
    }
    
    func deleteApiDataJson(requestUrl: String,param:[String:Any], completionHandler:@escaping(_ result: JSON?)-> Void)
    {


        let param = param
        AF.request(requestUrl,method: .delete, parameters: param).responseJSON{ (response) in
               
                if response.response?.statusCode == 200  {
                    switch response.result {
                    case .success:
                        guard let result = response.value else {
                            return
                        }
                        let json = JSON(result)

                        completionHandler(json)
                    case .failure(let error):
                        print(error)
                    }
                }else{
                    completionHandler(nil)
                
                }
            }
    }
    
    
    private func decodeJSONResponse<T:Decodable>(responseData:Data, resultType: T.Type) -> T?
    {
        let result = try? JSONDecoder().decode(T.self, from: responseData)
        return result
    }
    
    func getDefaultHeaders() -> HTTPHeaders{
        
        let headers: HTTPHeaders = [
            "access_token": "YWRtaW5AZ21haWwuY29tTU1UUlI5Tk9nb2dxMFgxTFAyQm55NjZ0UU1mbXR6"
   
        ]
        return headers
    }
}

//?=
struct Response<T: Decodable>: Decodable {
    var success:Bool?
    var data:T?
    var message: String?
}

struct ImageData {
    var name:String
    var data:Data
}
