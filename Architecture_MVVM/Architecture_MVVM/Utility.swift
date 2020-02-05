//
//  Utility.swift
//
//
//
//  Created by shahn on 2020/01/28.
//  Copyright © 2020 shahn. All rights reserved.
//
//

import Foundation
import UIKit


class Utilty: Any {
    /*
     싱글톤으로 사용할것
     */
    
    static let shared = Utilty()
    
    private init(){}
    
    
    //MARK: Log
    /**
    print() 함수가 DEBUG 플래그일 때만 로그 출력하도록 처리
    - Parameters:
        - filename: 파일이름
        - line: 라인번호
        - funcname: 함수 명
        - output: 출력할 내용
    */
    func print(filename: NSString = #file, line: Int = #line, funcname: String = #function, output: Any...) {
        #if DEBUG
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.sss"
        
        let outputs = output.map { "*** \($0) ***" }.joined(separator: " ")
        Swift.print("[\(dateFormatter.string(from: now))][\(filename.lastPathComponent)[\(funcname)][Line : \(line)] \(outputs)", terminator: "\n")
        #endif
    }
    
    //MARK: Application
    /**
    앱 버전 가져오기
    */
    var getVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /**
    앱 Bundle ID 가져오기
    */
    var getBundleID: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    /**
    앱 스키마로 해당 앱 설치 여부 검사
    - Parameters:
        - scheme : 실행 할 앱의 URL Scheme
    - Returns:
        앱 설치 여부
    */
    func appInstallYn(scheme:String) -> Bool {
        if UIApplication.shared.canOpenURL(URL.init(string: scheme)!) {
            return true
        }
        return false
    }
    
    /**
    단말기의 푸시 허용 여부
    - Parameters:
        - handler: 실행 핸들러
        - granted: 푸시 허용 여부
    */
    func checkPushEnable(handler: @escaping (_ granted: Bool) -> Void) {
        if #available(iOS 10.0, *) {
            let current = UNUserNotificationCenter.current()
            current.getNotificationSettings(completionHandler: { (settings) in
                DispatchQueue.main.async {
                    if settings.authorizationStatus == .authorized {
                        handler(true)
                    } else {
                        handler(false)
                    }
                }
            })
        } else {
            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            if isRegisteredForRemoteNotifications {
                handler(true)
            } else {
                handler(false)
            }
        }
    }
    
    //MARK: String
    /**
    숫자에 콤마 추가하기
    - Parameters:
       - number: 콤마 추가할 숫자
    - Returns:
       콤마 추가된 문자열
    */
    func addCommaToNumber(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let str = formatter.string(from: NSNumber(value: number)) {
            return str
        } else {
            return ""
        }
    }
    
    /**
    숫자로 된 문자열 판단
    - Parameters:
       - string: 판단할 문자열
    - Returns:
       숫자로만 이루어졌는지 여부
    */
    func isNumber(string: String) ->Bool {
        return !string.isEmpty && !(string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil)
    }
    
    //MARK: UIViewController
    /**
     Storyboard에서 특정 ViewController를 반환
     - Parameters:
        - strSBName: Storyboard 이름
        - strControllerName: ViewController 이름
     - Returns:
        해당 ViewController. 없으면 nil
     */
    func getStoryboardWithController(strSBName: String, strControllerName: String) -> UIViewController? {
        let str: String? = strSBName
        if (strSBName == "" || str == nil) {
            return nil
        }
        
        let str2 : String? = strControllerName
        if (strControllerName == "" || str2 == nil) {
            return nil
        }

        let storyboard = UIStoryboard(name: strSBName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: strControllerName)
        return vc
    }
    
    //MARK: UIColor
    /**
      RGB 값으로 UIColor 생성하여 반환
      - Parameters:
        - red: red 수치
        - green: green 수치
        - blue: blue 수치
      - Returns:
        변환된 UIColor 객체
      */
     func rgbToUIColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
         return self.rgbaToUIColor(red: red, green: green, blue: blue, alpha: 1.0)
     }
     
     /**
      RGB 값으로 UIColor 생성하여 반환
      - Parameters:
        - red: red 수치
        - green: green 수치
        - blue: blue 수치
        - alpha: alpha 수치
      - Returns:
        변환된 UIColor 객체
      */
     func rgbaToUIColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
         return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
     }
     
     /**
      색상 HEX 값으로 UIColor 생성하여 반환
      - Parameters:
        - hex: hex 코드
      - Returns:
        변환된 UIColor 객체
      */
     func hexToUIColor(hex: String) -> UIColor {
         var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
         
         if (cString.hasPrefix("#")) {
             cString.remove(at: cString.startIndex)
         }
         
         if ((cString.count) != 6) {
             return UIColor.gray
         }
         
         var rgbValue: UInt32 = 0
         Scanner(string: cString).scanHexInt32(&rgbValue)
         
         return UIColor(
             red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
             green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
             blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
             alpha: CGFloat(1.0)
         )
     }
}

class CommonAlert {
    
    ////////////////////////// 공통 //////////////////////////
    // MARK: - 뷰 컨트롤러 생명주기
    static var viewController: UIViewController? {
        if let navi = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            return navi.viewControllers.first
        }
        return nil
    }
    
    /// 공통얼럿 : 버튼 1개 타입
    static func showAlertType1(vc:UIViewController? = viewController, title:String = "", message:String = "", completeTitle:String = "확인", _ completeHandler:(() -> Void)? = nil){
        if let viewController = vc {
            let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
            let action1 = UIAlertAction(title:completeTitle, style: .default) { action in
                completeHandler?()
            }
            alert.addAction(action1)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    /// 공통얼럿 : 버튼 2개 타입
    static func showAlertType2(vc:UIViewController? = viewController, title:String = "", message:String = "", cancelTitle:String = "취소", completeTitle:String = "확인",  _ cancelHandler:(() -> Void)? = nil, _ completeHandler:(() -> Void)? = nil){
        if let viewController = vc {
            let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
            let action1 = UIAlertAction(title:cancelTitle, style: .cancel) { action in
                cancelHandler?()
            }
            let action2 = UIAlertAction(title:completeTitle, style: .default) { action in
                completeHandler?()
            }
            alert.addAction(action1)
            alert.addAction(action2)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
