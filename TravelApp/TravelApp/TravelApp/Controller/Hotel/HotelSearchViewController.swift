//
//  HotelSearchViewController.swift
//  TravelApp
//
//  Created by Tiparpron Sukanya on 8/22/23.
//

import Foundation
import UIKit
class  HotelSearchViewController:UIViewController{
    enum SelectedField:String{
        case city
        case room
        case guest
        case none
        //none nothing selected
    }
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    @IBOutlet weak var roomButton: UIButton!
    @IBOutlet weak var NumGuestButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var pickerOverlayView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    
    var cityCode = ""
    var checkInDate = ""
    var checkOutDate = ""
    var numofRoom = "1"
    var numofGuest = "1"
    var selectedField = SelectedField.none
    var selectedCityName = ""
    var selectedValue = ""
//    when use value for pickerView selectedValue -once we select all option above it will go to var selectedValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerOverlayView.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
        destinationTextField.delegate = self
    }
//    below action areas step 2
    
    @IBAction func checkInDateAction(_ sender: UIDatePicker) {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        checkInDate = formater.string(from:sender.date)
    }
    
    @IBAction func checkOutDatePickerAction(_ sender: UIDatePicker) {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        checkOutDate = formater.string(from:sender.date)
    }
    
    @IBAction func numberofRoomButtonAction(_ sender: Any) {
        selectedField = .room
        pickerView.reloadAllComponents()
        pickerOverlayView.isHidden = false
    }
    @IBAction func numberGuestButtonAction(_ sender: Any) {
        selectedField = .guest
        pickerView.reloadAllComponents()
        pickerOverlayView.isHidden = false
    }
    @IBAction func searchButtonAction(_ sender: Any) {
        let searchData = ["destination": cityCode,"checkInDate": checkInDate, "checkOutDate": checkOutDate, "numofRoom": numofRoom,"numofGuest":numofGuest ]
        print(searchData)
//        NetworkHelper().getHotel(cityCode: cityCode)
        self.performSegue(withIdentifier: "hotelListNav", sender: searchData
        )
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        switch selectedField{
        case .city:
            cityCode = selectedValue.isEmpty ? cityCode : selectedValue
            destinationTextField.text = selectedCityName
        case .room:
            numofRoom = selectedValue.isEmpty ? numofRoom : selectedValue
            roomButton.setTitle(numofRoom, for:.normal)
        case .guest:
            numofGuest = selectedValue.isEmpty ? numofGuest : selectedValue
            NumGuestButton.setTitle(numofGuest, for:.normal)
        case .none:
            print("Do nothing")
        }
        selectedField = .none
        selectedValue = ""
        pickerOverlayView.isHidden = true
    }
}

extension HotelSearchViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch selectedField{
        case .city:
            return Constant.cityData.count
        case .room:
            return 9
        case .guest:
            return 9
        case .none:
            return 0
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch selectedField{
        case .city:
            return Constant.cityData[row].name
        case .room:
            return "\(row+1)"
        case .guest:
            return "\(row+1)"
        case .none:
            return "\(row+1)"
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch selectedField{
        case .city:
            selectedCityName = Constant.cityData[row].name
            selectedValue = Constant.cityData[row].code
        case .room:
            selectedValue = "\(row+1)"
        case .guest:
            selectedValue = "\(row+1)"
        case .none:
            print("Do nothing")
            
        }
    }
}
extension HotelSearchViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        selectedField = .city
        pickerView.reloadAllComponents()
        pickerOverlayView.isHidden = false
    }
}
