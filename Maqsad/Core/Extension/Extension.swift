//
//  Extension.swift
//  IBIZI
//
//  Created by HudaMac-Sanjay on 26/02/2022.
//

import Foundation
import UIKit
import SDWebImage
import FittedSheets
typealias AlertViewController = UIAlertController
let CancelTitle     =   "Cancel"
let OKTitle         =   "OK"

extension UIImageView {
    func downloadAndSetImage(url: String?){
        guard let url = url else {
            self.sd_setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/ibizi-uat.appspot.com/o/CommonImagesUseInProject%2F1.png?alt=media&token=3c172cce-0004-43e6-b4fa-8fbcfbfea154"), placeholderImage: UIImage(named: "Ibizi-Logo-1"))
            return
        }
        self.sd_setImage(with: URL(string:url), placeholderImage: UIImage(named: "Ibizi-Logo-1"))
    }
    
}

struct AlertAction {
    
    var title: String = ""
    var type: UIAlertAction.Style? = .default
    var enable: Bool? = true
    var selected: Bool? = false
    
    init(title: String, type: UIAlertAction.Style? = .default, enable: Bool? = true, selected: Bool? = false) {
        self.title = title
        self.type = type
        self.enable = enable
        self.selected = selected
    }
}

extension UINavigationController{
    func push(_ viewControllers: [UIViewController]) {
        setViewControllers(self.viewControllers + viewControllers, animated: true)
    }
    func push(vc:UIViewController,animation:Bool = true,isNavBar:Bool = true,isTabBar:Bool = false) {
        isNavigationBarHidden = !isNavBar
        pushViewController(vc, animated: animation)
        vc.tabBarController?.tabBar.isHidden = !isTabBar
    }
}

extension UITableViewCell{
    static var identifire:String{
        get{return String(describing: self)}
    }
//    static func identifire() -> String {
//        return String(describing: self)
//    }
    static var nib:UINib{
        get{
            let id = String(describing: self)
            return UINib(nibName: id, bundle: nil)
        }
    }
    
    
    
    func detail() -> (nib:UINib,id:String) {
        let id = String(describing: self)
        return (nib:UINib(nibName: id, bundle: nil),id)
    }
}
extension UICollectionViewCell{
    static var identifire:String{
        get{return String(describing: self)}
    }
//    static func identifire() -> String {
//        return String(describing: self)
//    }
    static var nib: UINib{
        get{
            let id = String(describing: self)
            return UINib(nibName: id, bundle: nil)
        }
    }
    func detail() -> (nib:UINib,id:String) {
        let id = String(describing: self)
        return (nib:UINib(nibName: id, bundle: nil),id)
    }
}

extension UIViewController {

    var loading: Bool {
        set{
            view.isUserInteractionEnabled = !newValue
            view.tag = newValue ? 0:1
        }get{
            view.isUserInteractionEnabled = !(view.tag == 0)
            return view.tag == 0
        }
    }
    
    
    
    
    func embed(_ viewController:UIViewController, inView view:UIView){
        view.removeSubviews()
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    func getAlertViewController(type: UIAlertController.Style, with title: String?, message: String?, actions:[AlertAction], showCancel: Bool , actionHandler:@escaping ((_ title: String) -> ())) -> AlertViewController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: type)
        
        // items
        var actionItems: [UIAlertAction] = []
        
        // add actions
        for (index, action) in actions.enumerated() {
            
            let actionButton = UIAlertAction(title: action.title, style: action.type!, handler: { (actionButton) in
                actionHandler(actionButton.title ?? "")
            })
            
            actionButton.isEnabled = action.enable!
            if type == .actionSheet { actionButton.setValue(action.selected, forKey: "checked") }
            actionButton.setAssociated(object: index)
            
            actionItems.append(actionButton)
            alertController.addAction(actionButton)
        }
        
        // add cancel button
        if showCancel {
            let cancelAction = UIAlertAction(title: CancelTitle, style: .cancel, handler: { (action) in
                actionHandler(action.title!)
            })
            alertController.addAction(cancelAction)
        }
        return alertController
    }
    
    
    static func instantiate(type : StoryBoard) -> UIViewController {
        let id = String(describing: self)
        let storyboards = UIStoryboard(name: type.rawValue, bundle: nil)
        let vc = storyboards.instantiateViewController(withIdentifier: id)
        vc.navigationItem.backButtonTitle = ""
        return vc
    }
    
    
    /// pop back n viewcontroller
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    /// pop back to specific viewcontroller
    func popBack<T: UIViewController>(toControllerType: T.Type,isNavBar:Bool = true,isTabBar:Bool = false,animation:Bool = true) {
        
        if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            viewControllers = viewControllers.reversed()
            for currentViewController in viewControllers {
                if currentViewController .isKind(of: toControllerType) {
                    self.navigationController?.popToViewController(currentViewController, animated: animation)
                    navigationController?.isNavigationBarHidden = !isNavBar
                    tabBarController?.tabBar.isHidden = !isTabBar

                    break
                }
            }
        }
    }
    func fittedSheet(vc:UIViewController,self:UIViewController,height:CGFloat = 400,GripSizeWidth:CGFloat = 0,GripSizeHeight:CGFloat = 0 , inLineMode:Bool = true,isTabbar:Bool = true){
        
        let controller = vc
                let sheet = SheetViewController(
                    controller: controller,
                    sizes: [.fixed(height)],
                    options: SheetOptions(useInlineMode: inLineMode))
        
                sheet.gripSize = CGSize(width: GripSizeWidth, height: GripSizeHeight)
                sheet.gripColor = .gray
                sheet.cornerRadius = 20.0
                sheet.allowPullingPastMaxHeight = false
                sheet.allowPullingPastMinHeight = true
                self.tabBarController?.tabBar.isHidden = true
                    sheet.didDismiss = { [self] _ in
                    self.tabBarController?.tabBar.isHidden = !isTabbar
                }
                if vc.view != nil {
                    sheet.animateIn(to: self.view, in: self)
                } else {
                    self.present(sheet, animated: false, completion: nil)
                }
        
    }
// Usage : self.popBack(toControllerType: MyViewController.self)
}
extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
extension UIView{
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
      }
    
    func addTapGes(action:Selector) {
        let ges = UITapGestureRecognizer(target:parentViewController , action: action)
        addGestureRecognizer(ges)
    }
    func circle() {

        //self.layer.borderWidth = 1
        self.layer.masksToBounds = false
       // self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
//    func border(border:CGFloat = 1 , borderColor:UIColor = .borderColor){
//        layer.borderWidth = border
//        layer.borderColor = borderColor.cgColor
//    }
    func addShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 8
    }
    func removeShadow(){
        self.layer.shadowOpacity = 0
        self.layer.shadowRadius = 0
    }
    func setBorderWidthandColor(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    public func removeSubviews() {
        self.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
enum StoryBoard : String {
    case main = "Main"
}
extension UIView{

}


extension Date{
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


extension UITextField{
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
          datePicker.preferredDatePickerStyle = .wheels
          datePicker.sizeToFit()
        }
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    func setInputViewPicker( picker: inout UIPickerView,delegate:PickerDelegate,arr:[String]) {
        let pickerManager = PickerManager.shared
        pickerManager.arr = arr
        pickerManager.delegate = delegate
        pickerManager.picker = picker
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/3))
        picker.backgroundColor = .opaqueSeparator
        picker.translatesAutoresizingMaskIntoConstraints = true
        picker.delegate = pickerManager
        picker.dataSource = pickerManager
        //ToolBar
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tapCancel)) // 6
        
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tapDone)) //7
//        toolBar.tintColor = .themeGreen

        toolBar.setItems([cancel, flexible,barButton], animated: false) //8
        self.inputAccessoryView = toolBar//view.addSubview(toolBar)
        self.inputView = picker

    }
    @objc func tapDone() {
        self.resignFirstResponder()
        PickerManager.shared.tapDone(self)
    }
}



extension String {
    
    
    func stipeTxt() -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.strikethroughStyle:NSUnderlineStyle.single.rawValue,.font: UIFont.systemFont(ofSize: 12, weight: .light),.foregroundColor:UIColor.gray])
    }
    func attTxt() -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [:])
    }
    
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }

        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }

        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }

        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }

        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }

        return String(self[startIndex ..< endIndex])
    }

    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }

    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }

    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }

        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }

        return self.substring(from: from, to: end)
    }

    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }

        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }

        return self.substring(from: start, to: to)
    }
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()

        return label.frame.height
     }

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
extension JSONEncoder {
    
    
    static func encode<T: Encodable>(from data: T)->String {
        do {
            let jsonEncoder = JSONEncoder()
//            jsonEncoder.outputFormatting = .prettyPrinted
            let json = try jsonEncoder.encode(data)
            var jsonString = (String(data: json, encoding: .utf8) ?? "") as String
            jsonString = jsonString.replacingOccurrences(of: "{", with: "[")
            jsonString = jsonString.replacingOccurrences(of: "}", with: "]")
            return jsonString
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
}
extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }

    func compress(to kb: Int, allowedMargin: CGFloat = 0.2) -> Data {
        let bytes = kb * 1024
        var compression: CGFloat = 1.0
        let step: CGFloat = 0.05
        var holderImage = self
        var complete = false
        while(!complete) {
            if let data = holderImage.jpegData(compressionQuality: 0.5) {
                let ratio = data.count / bytes
                if data.count < Int(CGFloat(bytes) * (1 + allowedMargin)) {
                    complete = true
                    return data
                } else {
                    let multiplier:CGFloat = CGFloat((ratio / 5) + 1)
                    compression -= (step * multiplier)
                }
            }
            
            guard let newImage = holderImage.resized(withPercentage: compression) else { break }
            holderImage = newImage
        }
        return Data()
    }
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat , yOrigin: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 24, y: yOrigin , width: 54, height: lineWidth ))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
extension UIColor {
//    static let themeGreen = hexStringToUIColor(hex: "1E4620")
//    static let borderColor = hexStringToUIColor(hex: "E5E2EF")
//    static let lightGreenColor = hexStringToUIColor(hex: "93A346")
//    static let themeGray = hexStringToUIColor(hex: "7B7B7B")
//    static let themeBackgroundView = hexStringToUIColor(hex: "F8F8F8")
//    static let lblDateGray1 = hexStringToUIColor(hex: "A5A5A5")
//    static let lblDateGray2 = hexStringToUIColor(hex: "D2D2D2")
}
