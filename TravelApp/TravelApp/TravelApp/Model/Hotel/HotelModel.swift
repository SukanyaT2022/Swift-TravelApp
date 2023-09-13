//
//  HotelModel.swift
//  TravelApp
//
//  Created by Tiparpron Sukanya on 9/5/23.
// this page we crate model /structure that we got from api
//https://developers.amadeus.com/self-service/category/hotels/api-doc/hotel-list/api-reference

import Foundation
struct Hotel:Codable{
    var chainCode:String?
    var iataCode:String?
    var dupeId:Int?
    var name:String?
    var hotelId:String?
    var geoCode: GeoCode?//copy key for geoCode where is dictonary
    var address: Address?
    var distance: Distance?
}
struct GeoCode:Codable{
    var latitude: Double?
    var longitude: Double?
}
struct Address:Codable{
    var countryCode:String?
}
struct Distance:Codable{
    var Value: Double?
    var unit:String?
}

//
//    {
//      "chainCode": "ZZ",
//      "iataCode": "NCE",
//      "dupeId": 504813011,
//      "name": "HOTEL 3",
//      "hotelId": ":",

//below is dictionary so we create another sctructure
//      "geoCode": {
//        "latitude": 43.66665,
//        "longitude": 7.21465
//      },
//      "address": {
//        "countryCode": "FR"
//      },
//      "distance": {
//        "value": 0.92,
//        "unit": "KM"
//      }
//    }
//
