//
//  PickerManager.swift
//  Qarya
//
//  Created by Maaz Bin Tausif on 18/07/2022.
//

import Foundation
import UIKit

protocol PickerDelegate {
    func doneSelectPicker(selectStr:String,row:Int,picker:UIPickerView,isDone:Bool)
}
extension PickerDelegate{
    func doneSelectPicker(selectStr:String,row:Int,picker:UIPickerView,isDone:Bool){}
}


class PickerManager:NSObject{
    static var shared:PickerManager = PickerManager()
    var arr:[String] = []
    var picker = UIPickerView()//1 frame: CGRect(x: 0, y: screenHeight-216, width: screenWidth, height: 216)
    var toolBar = UIToolbar() //4frame: CGRect(x: 0.0, y: 260, width: screenHeight-screenWidth, height: 44.0)
    var delegate:PickerDelegate?
    var selectedIndex:Int = 0
    
    
    
    
    
    @objc func tapDone(_ sender:UITextField) {
        if arr.indices.contains(selectedIndex){
            
            let select = arr[selectedIndex]
            sender.text = select
            delegate?.doneSelectPicker(selectStr: select, row: selectedIndex, picker: picker,isDone: true)
        }
    }
    
    
}


extension PickerManager :UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        selectedIndex = 0
        return arr.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(arr[row])
        return arr[row]
    }
    //    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    //        return NSAttributedString(string: arr[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    //
    //    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        if arr.indices.contains(selectedIndex){
            let select = arr[selectedIndex]
            delegate?.doneSelectPicker(selectStr: select, row: selectedIndex, picker: picker,isDone: false)
        }
        
    }
}
