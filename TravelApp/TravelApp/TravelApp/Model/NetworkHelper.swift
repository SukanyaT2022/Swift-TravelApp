//
//  NetworkHelper.swift
//  TravelApp
//
//  Created by Tiparpron Sukanya on 8/22/23.
//

import Foundation
import UIKit
class NetworkHelper{
    //we use api key for generate token
   let api_key = "rA7R23GhjXVdKoBGZup76QrrA3pLPMDi"
    let api_secret_key = "iRuwnrhTaLdpEAzz"
    func getToken(completion: @escaping((Bool)->Void)){
        if let url = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token"){
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
          // next create data
            let data :Data = "grant_type=client_credentials&client_id=\(api_key)&client_secret=\(api_secret_key)".data(using: .utf8)!
            request.httpBody = data
            
            // we got data convert to json
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data{
                    if let json = try? JSONSerialization.jsonObject(with:data) as? [String: Any]{
                        print(json)
                        //then  next access token
                        let token = "\(json["token_type"]!) \(json["access_token"]!)"
                        DispatchQueue.main.async {
                            (UIApplication.shared.delegate as? AppDelegate)?.accessToken = token
                        }
                        completion(true)
                    }
                }else{
                 completion(false)
                }
            }.resume()
        }
    }
    func getHotel(cityCode:String,completion: @escaping(Result<[Hotel]?, Error>)-> Void){
        //we return some data
//    https://test.api.amadeus.com/v1/reference-data/locations/hotels/by-city?cityCode=PAR&radius=5&radiusUnit=KM&hotelSource=ALL
        var path = "https://test.api.amadeus.com/v1/reference-data/locations/hotels/by-city?cityCode="
        path.append(cityCode)
        if let url = URL(string:path),let token = (UIApplication.shared.delegate as? AppDelegate)?.accessToken{
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
          request.setValue(token, forHTTPHeaderField:"Authorization")
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error{
                    print(error)
                    completion(.failure(error))
                }else{
                    if let data = data,
                       let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
                    let hotelJson = json["data"],
                       let hotelData = try? JSONSerialization.data(withJSONObject: hotelJson),
                       let passObject = try? JSONDecoder().decode([Hotel].self, from: hotelData)
                    {
                        print(json)
                        print(passObject)
                        completion(.success(passObject))
                    }
                }
            }
            task.resume()
        }
    }
}
