//
//  hotelListViewController.swift
//  TravelApp
//
//  Created by Tiparpron Sukanya on 9/8/23.
//

import Foundation
import UIKit
class HotelListViewController: UIViewController{
    
    @IBOutlet weak var hotelListTableView: UITableView!
    var hotelList : [Hotel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        hotelListTableView.delegate = self
        hotelListTableView.dataSource = self
        self.getHotel()
    }
    func getHotel(){
        NetworkHelper().getHotel(cityCode: "PAR") { result in
            switch result {
            case .success(let data):
                self.hotelList = data
                DispatchQueue.main.async { 
                    self.hotelListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension HotelListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelList?.count ?? 0 //?? o if hotelList is not there it go 0 as default value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"hotelCell", for: indexPath) as? HotelListTableViewCell
        let hotelData = hotelList?[indexPath.row]
        cell?.hotelNameLabel.text = hotelData?.name
        cell?.hotelIDLabel.text = hotelData?.hotelId
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
