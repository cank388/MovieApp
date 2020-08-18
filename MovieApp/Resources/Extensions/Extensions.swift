//
//  Extensions.swift
//  MovieApp
//
//  Created by Can Kalender on 17.08.2020.
//  Copyright © 2020 Can Kalender. All rights reserved.
//


import Foundation
import UIKit


public enum Model : String {
    case simulator   = "simulator/sandbox",
    iPod1            = "iPod 1",
    iPod2            = "iPod 2",
    iPod3            = "iPod 3",
    iPod4            = "iPod 4",
    iPod5            = "iPod 5",
    iPad2            = "iPad 2",
    iPad3            = "iPad 3",
    iPad4            = "iPad 4",
    iPhone4          = "iPhone 4",
    iPhone4S         = "iPhone 4S",
    iPhone5          = "iPhone 5",
    iPhone5S         = "iPhone 5S",
    iPhone5C         = "iPhone 5C",
    iPadMini1        = "iPad Mini 1",
    iPadMini2        = "iPad Mini 2",
    iPadMini3        = "iPad Mini 3",
    iPadAir1         = "iPad Air 1",
    iPadAir2         = "iPad Air 2",
    iPadPro9_7       = "iPad Pro 9.7\"",
    iPadPro9_7_cell  = "iPad Pro 9.7\" cellular",
    iPadPro10_5      = "iPad Pro 10.5\"",
    iPadPro10_5_cell = "iPad Pro 10.5\" cellular",
    iPadPro12_9      = "iPad Pro 12.9\"",
    iPadPro12_9_cell = "iPad Pro 12.9\" cellular",
    iPhone6          = "iPhone 6",
    iPhone6plus      = "iPhone 6 Plus",
    iPhone6S         = "iPhone 6S",
    iPhone6Splus     = "iPhone 6S Plus",
    iPhoneSE         = "iPhone SE",
    iPhone7          = "iPhone 7",
    iPhone7plus      = "iPhone 7 Plus",
    iPhone8          = "iPhone 8",
    iPhone8plus      = "iPhone 8 Plus",
    iPhoneX          = "iPhone X",
    unrecognized     = "?unrecognized?"
}

public extension UIDevice {
    public var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
                
            }
        }
        var modelMap : [ String : Model ] = [
            "i386"       : .simulator,
            "x86_64"     : .simulator,
            "iPod1,1"    : .iPod1,
            "iPod2,1"    : .iPod2,
            "iPod3,1"    : .iPod3,
            "iPod4,1"    : .iPod4,
            "iPod5,1"    : .iPod5,
            "iPad2,1"    : .iPad2,
            "iPad2,2"    : .iPad2,
            "iPad2,3"    : .iPad2,
            "iPad2,4"    : .iPad2,
            "iPad2,5"    : .iPadMini1,
            "iPad2,6"    : .iPadMini1,
            "iPad2,7"    : .iPadMini1,
            "iPhone3,1"  : .iPhone4,
            "iPhone3,2"  : .iPhone4,
            "iPhone3,3"  : .iPhone4,
            "iPhone4,1"  : .iPhone4S,
            "iPhone5,1"  : .iPhone5,
            "iPhone5,2"  : .iPhone5,
            "iPhone5,3"  : .iPhone5C,
            "iPhone5,4"  : .iPhone5C,
            "iPad3,1"    : .iPad3,
            "iPad3,2"    : .iPad3,
            "iPad3,3"    : .iPad3,
            "iPad3,4"    : .iPad4,
            "iPad3,5"    : .iPad4,
            "iPad3,6"    : .iPad4,
            "iPhone6,1"  : .iPhone5S,
            "iPhone6,2"  : .iPhone5S,
            "iPad4,1"    : .iPadAir1,
            "iPad4,2"    : .iPadAir2,
            "iPad4,4"    : .iPadMini2,
            "iPad4,5"    : .iPadMini2,
            "iPad4,6"    : .iPadMini2,
            "iPad4,7"    : .iPadMini3,
            "iPad4,8"    : .iPadMini3,
            "iPad4,9"    : .iPadMini3,
            "iPad6,3"    : .iPadPro9_7,
            "iPad6,11"   : .iPadPro9_7,
            "iPad6,4"    : .iPadPro9_7_cell,
            "iPad6,12"   : .iPadPro9_7_cell,
            "iPad6,7"    : .iPadPro12_9,
            "iPad6,8"    : .iPadPro12_9_cell,
            "iPad7,3"    : .iPadPro10_5,
            "iPad7,4"    : .iPadPro10_5_cell,
            "iPhone7,1"  : .iPhone6plus,
            "iPhone7,2"  : .iPhone6,
            "iPhone8,1"  : .iPhone6S,
            "iPhone8,2"  : .iPhone6Splus,
            "iPhone8,4"  : .iPhoneSE,
            "iPhone9,1"  : .iPhone7,
            "iPhone9,2"  : .iPhone7plus,
            "iPhone9,3"  : .iPhone7,
            "iPhone9,4"  : .iPhone7plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,2" : .iPhone8plus,
            "iPhone10,3" : .iPhoneX
        ]
        
        if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
            return model
        }
        return Model.unrecognized
    }
}

extension UIButton{
    func radiusTop(_ radiusSize: CGFloat){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.topLeft , .topRight],
                                     cornerRadii:CGSize(width: radiusSize, height: radiusSize))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
    func radiusBottom(_ radiusSize: CGFloat){
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: [.bottomLeft , .bottomRight],
                                     cornerRadii:CGSize(width: radiusSize, height: radiusSize))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}


extension Date {
    
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    mutating func setHour(_ hour:Int){
        var gregorian = Calendar(identifier: .gregorian)
        let now = self
        gregorian.timeZone = TimeZone(abbreviation: "UTC")!
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        components.hour = hour
        self = gregorian.date(from: components)!
    }
    
    mutating func setMinute(_ minute:Int){
        var gregorian = Calendar(identifier: .gregorian)
        let now = self
        gregorian.timeZone = TimeZone(abbreviation: "UTC")!
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        components.minute = minute
        self = gregorian.date(from: components)!
    }
    
    mutating func addDay(_ count:Int){
        self = Calendar.current.date(byAdding: .day, value: count, to: self)!
    }
    
    mutating func addMonth(_ count:Int){
        self = Calendar.current.date(byAdding: .month, value: count, to: self)!
    }
    
    mutating func addYear(_ count:Int){
        self = Calendar.current.date(byAdding: .year, value: count, to: self)!
    }
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return end - start
    }
    
    func getDay() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    func getMonth() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    func getYear() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
    func getHourAndMinute() -> String{
        return String(format:"%.2d:%.2d",Calendar.current.component(.hour, from: self),Calendar.current.component(.minute, from: self))
    }

    
    func getDayDisplayName() -> String {
        let format = "EE"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getFullDayDisplayName() -> String {
        let format = "EEEE"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getMonthDisplayName() -> String {
        let format = "MMM"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}




extension String {
    func isEmptyAndContainsNoWhitespace() -> Bool {
        guard self.isEmpty, self.trimmingCharacters(in: .whitespaces).isEmpty
            else {
                return false
        }
        return true
    }
    
    func isDomestic() -> Bool{
//        return self.contains("TÜRKİYE")
        return self.contains("Türkiye")
        
    }
    
    func toHotelCityType() -> String {
        if(self.contains(",")){
            return self.substring(fromIndex: 0, toIndex: (self.range(of: ",")?.lowerBound.encodedOffset)!).trimmingCharacters(in: .whitespacesAndNewlines)
        }else if(self.contains("(")){
            return self.substring(fromIndex: 0, toIndex: (self.range(of: "(")?.lowerBound.encodedOffset)!).trimmingCharacters(in: .whitespacesAndNewlines)
        }else {
            return self
        }
    }
    
    func toCityDisplayType() -> String {
        if(self.contains("(")){
            return self.substring(fromIndex: 0, toIndex: (self.range(of: "(")?.lowerBound.encodedOffset)!).trimmingCharacters(in: .whitespacesAndNewlines)
        }else {
            return self
        }
    }
    
    func substring(fromIndex from: Int, toIndex to:Int) -> String {
        var template = self
        if(template.count >= to  && template.count >= from) {
            let indexStartOfText = template.index(template.startIndex, offsetBy: from)
            let indexEndOfText = template.index(template.endIndex, offsetBy: -(template.count - to))
            template = String(template[indexStartOfText..<indexEndOfText])
        }
        return template
    }
    func replaceUtf8Chars() -> String {
        var replacedText = self
        replacedText = replacedText.replacingOccurrences(of: "Ş", with: "S")
        replacedText = replacedText.replacingOccurrences(of: "İ", with: "I")
        replacedText = replacedText.replacingOccurrences(of: "Ğ", with: "G")
        replacedText = replacedText.replacingOccurrences(of: "Ç", with: "C")
        replacedText = replacedText.replacingOccurrences(of: "Ö", with: "O")
        replacedText = replacedText.replacingOccurrences(of: "Ü", with: "U")
        return replacedText
    }
    
    func encodeCaeser(shift: Int) -> String {
        let unicodeScalars = self.unicodeScalars.map { UnicodeScalar(Int($0.value) + shift)! }
        return String(String.UnicodeScalarView(unicodeScalars))
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func validateTC(ID: String) -> Bool{
        let digits = ID.map { Int(String($0)) ?? 0 }
        
        if digits.count == 11
        {
            if (digits.first != 0)
            {
                let first   = (digits[0] + digits[2] + digits[4] + digits[6] + digits[8]) * 7
                let second  = (digits[1] + digits[3] + digits[5] + digits[7])
                
                let digit10 = (first - second) % 10
                let digit11 = (digits[0] + digits[1] + digits[2] + digits[3] + digits[4] + digits[5] + digits[6] + digits[7] + digits[8] + digits[9]) % 10
                
                if (digits[10] == digit11) && (digits[9] == digit10)
                {
                    return true
                }
            }
        }
        return false
    }
    
}
extension UITableView {
    func setEmptyView(image: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageLabel = UILabel()
        var image = UIImage(named: image);
        let bgImage = UIImageView(image: image)
        //bgImage.frame = CGRect(x: self.center.x/2, y: self.center.y/4, width: 150, height: 150)
        bgImage.center.x = emptyView.center.x
        bgImage.center.y = emptyView.center.y/2
        bgImage.frame.size.width = 150
        bgImage.frame.size.height = 150
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 19)
        
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(bgImage)
        messageLabel.topAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
       
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


extension UIColor {
    struct MyColor {
        static let AppRed = UIColor(netHex: 0x89373b)
        static let DarkGreen = UIColor( netHex: 0x1f4c50)
        static let LightGreen = UIColor(netHex: 0xc5ff69)
//        static let FrameBG = UIColor(netHex: 0xab1f4c50)
        static let FrameBG = UIColor(netHex: 0x89373b)

        
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    
    class var hepsiPurple: UIColor{
        return UIColor(red: 154/255, green: 27/255, blue: 129/255, alpha: 1.0)
    }
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width:1, height:1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIPickerView {
    func pickerTapped(nizer: UITapGestureRecognizer, onPick: @escaping (Int) -> ()) {
        if nizer.state == .ended {
            let rowHeight = self.rowSize(forComponent: 0).height
            let selectedRowFrame = self.bounds.insetBy(dx: 0, dy: (self.frame.height - rowHeight) / 2)
            
            // check if begin and end tap locations both fall into the row frame:
            if selectedRowFrame.contains(nizer.location(in: self)) &&
                selectedRowFrame.contains(nizer.location(ofTouch: 0, in: self)) {
                onPick(self.selectedRow(inComponent: 0))
            }
        }
    }
}

extension UIPageViewController{
    func newVc(viewController: String,storyboardName: String) -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
}
extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.keyWindow else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 40
        return sizeThatFits
    }
}

extension UIView {
    
    func setGradientBackground(colorOne: UIColor,colorTwo: UIColor){
        let gradientLayer = CAGradientLayer();
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor,colorTwo.cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UITableView {

    func showTableViewEmptyLabel(message: String, containerView: UIView) {
        DispatchQueue.main.async {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: containerView.bounds.size.width, height: containerView.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = UIColor.lightGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
            messageLabel.sizeToFit()

            self.backgroundView = messageLabel
            self.separatorStyle = .none
        }
    }

    func hideTableViewEmptyMessage() {
        DispatchQueue.main.async {
            self.backgroundView = UIView()
        }
    }
}

