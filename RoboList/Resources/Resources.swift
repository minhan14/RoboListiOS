//
//  Resources.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//

import Foundation
import SwiftUI
import Combine
import SwiftData


public extension UIDevice {
    var type: Models {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        
        let modelMap : [String: Models] = [
            
            //Simulator
            "i386"      : .simulator,
            "x86_64"    : .simulator,
            
            //iPod
            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,
            
            //iPad
            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPad6,11"  : .iPad5, //iPad 2017
            "iPad6,12"  : .iPad5,
            "iPad7,5"   : .iPad6, //iPad 2018
            "iPad7,6"   : .iPad6,
            "iPad7,11"  : .iPad7, //iPad 2019
            "iPad7,12"  : .iPad7,
            "iPad11,6"  : .iPad8, //iPad 2020
            "iPad11,7"  : .iPad8,
            
            //iPad Mini
            "iPad2,5"   : .iPadMini,
            "iPad2,6"   : .iPadMini,
            "iPad2,7"   : .iPadMini,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPad5,1"   : .iPadMini4,
            "iPad5,2"   : .iPadMini4,
            "iPad11,1"  : .iPadMini5,
            "iPad11,2"  : .iPadMini5,
            
            //iPad Pro
            "iPad6,3"   : .iPadPro9_7,
            "iPad6,4"   : .iPadPro9_7,
            "iPad7,3"   : .iPadPro10_5,
            "iPad7,4"   : .iPadPro10_5,
            "iPad6,7"   : .iPadPro12_9,
            "iPad6,8"   : .iPadPro12_9,
            "iPad7,1"   : .iPadPro2_12_9,
            "iPad7,2"   : .iPadPro2_12_9,
            "iPad8,1"   : .iPadPro11,
            "iPad8,2"   : .iPadPro11,
            "iPad8,3"   : .iPadPro11,
            "iPad8,4"   : .iPadPro11,
            "iPad8,9"   : .iPadPro2_11,
            "iPad8,10"  : .iPadPro2_11,
            "iPad8,5"   : .iPadPro3_12_9,
            "iPad8,6"   : .iPadPro3_12_9,
            "iPad8,7"   : .iPadPro3_12_9,
            "iPad8,8"   : .iPadPro3_12_9,
            "iPad8,11"  : .iPadPro4_12_9,
            "iPad8,12"  : .iPadPro4_12_9,
            
            //iPad Air
            "iPad4,1"   : .iPadAir,
            "iPad4,2"   : .iPadAir,
            "iPad4,3"   : .iPadAir,
            "iPad5,3"   : .iPadAir2,
            "iPad5,4"   : .iPadAir2,
            "iPad11,3"  : .iPadAir3,
            "iPad11,4"  : .iPadAir3,
            "iPad13,1"  : .iPadAir4,
            "iPad13,2"  : .iPadAir4,
            
            
            //iPhone
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPhone7,1" : .iPhone6Plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6SPlus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,3" : .iPhone7,
            "iPhone9,2" : .iPhone7Plus,
            "iPhone9,4" : .iPhone7Plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8Plus,
            "iPhone10,5" : .iPhone8Plus,
            "iPhone10,3" : .iPhoneX,
            "iPhone10,6" : .iPhoneX,
            "iPhone11,2" : .iPhoneXS,
            "iPhone11,4" : .iPhoneXSMax,
            "iPhone11,6" : .iPhoneXSMax,
            "iPhone11,8" : .iPhoneXR,
            "iPhone12,1" : .iPhone11,
            "iPhone12,3" : .iPhone11Pro,
            "iPhone12,5" : .iPhone11ProMax,
            "iPhone12,8" : .iPhoneSE2,
            "iPhone13,1" : .iPhone12Mini,
            "iPhone13,2" : .iPhone12,
            "iPhone13,3" : .iPhone12Pro,
            "iPhone13,4" : .iPhone12ProMax,
            
            //Apple TV
            "AppleTV5,3" : .AppleTV,
            "AppleTV6,2" : .AppleTV_4K
        ]
        
        if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
            if model == .simulator {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    if let simModel = modelMap[String.init(validatingUTF8: simModelCode)!] {
                        return simModel
                    }
                }
            }
            return model
        }
        return Models.unrecognized
    }
}
public extension UIDevice {

    static let modelName: String = {
           var systemInfo = utsname()
           uname(&systemInfo)
           let machineMirror = Mirror(reflecting: systemInfo.machine)
           let identifier = machineMirror.children.reduce("") { identifier, element in
               guard let value = element.value as? Int8, value != 0 else { return identifier }
               return identifier + String(UnicodeScalar(UInt8(value)))
           }

           func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
               print("Identifier----\(identifier)")
               #if os(iOS)
               switch identifier {
               case "iPod5,1":                                       return "iPod touch (5th generation)"
               case "iPod7,1":                                       return "iPod touch (6th generation)"
               case "iPod9,1":                                       return "iPod touch (7th generation)"
               case "iPhone SE (3rd generation)":                    return "iPhone SE"
               case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return "iPhone 4"
               case "iPhone4,1":                                     return "iPhone 4s"
               case "iPhone5,1", "iPhone5,2":                        return "iPhone 5"
               case "iPhone5,3", "iPhone5,4":                        return "iPhone 5c"
               case "iPhone6,1", "iPhone6,2":                        return "iPhone 5s"
               case "iPhone7,2":                                     return "iPhone 6"
               case "iPhone7,1":                                     return "iPhone 6 Plus"
               case "iPhone8,1":                                     return "iPhone 6s"
               case "iPhone8,2":                                     return "iPhone 6s Plus"
               case "iPhone9,1", "iPhone9,3":                        return "iPhone 7"
               case "iPhone9,2", "iPhone9,4":                        return "iPhone 7 Plus"
               case "iPhone10,1", "iPhone10,4":                      return "iPhone 8"
               case "iPhone10,2", "iPhone10,5":                      return "iPhone 8 Plus"
               case "iPhone10,3", "iPhone10,6":                      return "iPhone X"
               case "iPhone11,2":                                    return "iPhone XS"
               case "iPhone11,4", "iPhone11,6":                      return "iPhone XS Max"
               case "iPhone11,8":                                    return "iPhone XR"
               case "iPhone12,1":                                    return "iPhone 11"
               case "iPhone12,3":                                    return "iPhone 11 Pro"
               case "iPhone12,5":                                    return "iPhone 11 Pro Max"
               case "iPhone13,1":                                    return "iPhone 12 mini"
               case "iPhone13,2":                                    return "iPhone 12"
               case "iPhone13,3":                                    return "iPhone 12 Pro"
               case "iPhone13,4":                                    return "iPhone 12 Pro Max"
               case "iPhone14,4":                                    return "iPhone 13 mini"
               case "iPhone14,5":                                    return "iPhone 13"
               case "iPhone14,2":                                    return "iPhone 13 Pro"
               case "iPhone14,3":                                    return "iPhone 13 Pro Max"
               case "iPhone14,7":                                    return "iPhone 14"
               case "iPhone14,8":                                    return "iPhone 14 Plus"
               case "iPhone15,2":                                    return "iPhone 14 Pro"
               case "iPhone15,3":                                    return "iPhone 14 Pro Max"
               case "iPhone8,4":                                     return "iPhone 8"
               case "iPhone12,8":                                    return "iPhone 12 (2nd generation)"
               case "iPhone14,6":                                    return "iPhone SE"
               case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return "iPad 2"
               case "iPad3,1", "iPad3,2", "iPad3,3":                 return "iPad (3rd generation)"
               case "iPad3,4", "iPad3,5", "iPad3,6":                 return "iPad (4th generation)"
               case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
               case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
               case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
               case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
               case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
               case "iPad13,18", "iPad13,19":                        return "iPad (10th generation)"
               case "iPad4,1", "iPad4,2", "iPad4,3":                 return "iPad Air"
               case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
               case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
               case "iPad13,1", "iPad13,2":                          return "iPad Air (4th generation)"
               case "iPad13,16", "iPad13,17":                        return "iPad Air (5th generation)"
               case "iPad2,5", "iPad2,6", "iPad2,7":                 return "iPad mini"
               case "iPad4,4", "iPad4,5", "iPad4,6":                 return "iPad mini 2"
               case "iPad4,7", "iPad4,8", "iPad4,9":                 return "iPad mini 3"
               case "iPad5,1", "iPad5,2":                            return "iPad mini 4"
               case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
               case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
               case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
               case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
               case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch) (1st generation)"
               case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
               case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
               case "iPad14,3", "iPad14,4":                          return "iPad Pro (11-inch) (4th generation)"
               case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch) (1st generation)"
               case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
               case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
               case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
               case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
               case "iPad14,5", "iPad14,6":                          return "iPad Pro (12.9-inch) (6th generation)"
               case "i386", "x86_64", "arm64":                       return "\(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
               default:                                              return identifier
               }
               #endif
           }

           return mapToDevice(identifier: identifier)
       }()

}

public enum Models : String {
   
    
    //Simulator
    case simulator     = "simulator/sandbox",
         
         //iPod
         iPod1              = "iPod 1",
         iPod2              = "iPod 2",
         iPod3              = "iPod 3",
         iPod4              = "iPod 4",
         iPod5              = "iPod 5",
         
         //iPad
         iPad2              = "iPad 2",
         iPad3              = "iPad 3",
         iPad4              = "iPad 4",
         iPadAir            = "iPad Air ",
         iPadAir2           = "iPad Air 2",
         iPadAir3           = "iPad Air 3",
         iPadAir4           = "iPad Air 4",
         iPad5              = "iPad 5", //iPad 2017
         iPad6              = "iPad 6", //iPad 2018
         iPad7              = "iPad 7", //iPad 2019
         iPad8              = "iPad 8", //iPad 2020
         
         //iPad Mini
         iPadMini           = "iPad Mini",
         iPadMini2          = "iPad Mini 2",
         iPadMini3          = "iPad Mini 3",
         iPadMini4          = "iPad Mini 4",
         iPadMini5          = "iPad Mini 5",
         
         //iPad Pro
         iPadPro9_7         = "iPad Pro 9.7\"",
         iPadPro10_5        = "iPad Pro 10.5\"",
         iPadPro11          = "iPad Pro 11\"",
         iPadPro2_11        = "iPad Pro 11\" 2nd gen",
         iPadPro12_9        = "iPad Pro 12.9\"",
         iPadPro2_12_9      = "iPad Pro 2 12.9\"",
         iPadPro3_12_9      = "iPad Pro 3 12.9\"",
         iPadPro4_12_9      = "iPad Pro 4 12.9\"",
         
         //iPhone
         iPhone4            = "iPhone 4",
         iPhone4S           = "iPhone 4S",
         iPhone5            = "iPhone 5",
         iPhone5S           = "iPhone 5S",
         iPhone5C           = "iPhone 5C",
         iPhone6            = "iPhone 6",
         iPhone6Plus        = "iPhone 6 Plus",
         iPhone6S           = "iPhone 6S",
         iPhone6SPlus       = "iPhone 6S Plus",
         iPhoneSE           = "iPhone SE",
         iPhone7            = "iPhone 7",
         iPhone7Plus        = "iPhone 7 Plus",
         iPhone8            = "iPhone 8",
         iPhone8Plus        = "iPhone 8 Plus",
         iPhoneX            = "iPhone X",
         iPhoneXS           = "iPhone XS",
         iPhoneXSMax        = "iPhone XS Max",
         iPhoneXR           = "iPhone XR",
         iPhone11           = "iPhone 11",
         iPhone11Pro        = "iPhone 11 Pro",
         iPhone11ProMax     = "iPhone 11 Pro Max",
         iPhoneSE2          = "iPhone SE 2nd gen",
         iPhone12Mini       = "iPhone 12 Mini",
         iPhone12           = "iPhone 12",
         iPhone12Pro        = "iPhone 12 Pro",
         iPhone12ProMax     = "iPhone 12 Pro Max",
         
         //Apple TV
         AppleTV            = "Apple TV",
         AppleTV_4K         = "Apple TV 4K",
         unrecognized       = "?unrecognized?"
}

enum DeviceTypeAndOrientation {
    static var isIpad: Bool {
        return UIView().traitCollection.horizontalSizeClass == .regular && UIView().traitCollection.verticalSizeClass == .regular
    }
    
    static var isLandscape: Bool {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
    }
    
    static var isPhoneSmallDevice: Bool {
        var isSmall:Bool = false
        switch UIDevice().type {
        case .iPhoneSE, .iPhone5, .iPhone5S, .iPhoneSE2, .iPhone6S: isSmall = true
        default: break
        }
        return isSmall
    }
    
    static var isPhoneLargeDevice: Bool {
        var isTrue:Bool = false
        switch UIDevice.modelName {
        case "iPhone 11", "iPhone 12", "iPhone 14 Pro Max", "iPhone 14 Pro", "iPhone 14" : isTrue = true
        default: break
        }
        return isTrue
    }
    static var isIphone11and12: Bool {
        var isTrue:Bool = false
        switch UIDevice().type {
        case .iPhone11, .iPhone12: isTrue = true
        default: break
        }
        return isTrue
    }
}

enum AppFontSize {
        static var headingFontSize: Font {
            if (DeviceTypeAndOrientation.isPhoneSmallDevice) {
                return .system(size: 25)
            } else {
                return .system(size: 32)
            }
        }
    static var titleFontSize: Font {
        if (DeviceTypeAndOrientation.isPhoneSmallDevice) {
            return .system(size: 20)
        } else {
            return .system(size: 25)
        }
    }
    static var subTitleFontSize: Font {
        if (DeviceTypeAndOrientation.isPhoneSmallDevice) {
            return .headline
        } else {
            return .title2
        }
    }
    static var bodyFontSize: Font {
        if (DeviceTypeAndOrientation.isPhoneSmallDevice) {
            return .system(size: 13)
        } else {
            return .subheadline
        }
    }

    static var bigFontSize: Font {
        if (DeviceTypeAndOrientation.isPhoneSmallDevice) {
            return .system(size: 15)
        } else {
            return .system(size: 20)
        }
    }
    static var smallFontSize: Font {
        if (DeviceTypeAndOrientation.isPhoneSmallDevice) {
            return .system(size: 10)
        } else {
            return .system(size: 15)
        }
    }
    static var xxsmallFontSize: Font {
        if (DeviceTypeAndOrientation.isPhoneSmallDevice) {
            return .system(size: 8)
        } else {
            return .system(size: 13)
        }
    }
    
    static var buttonFontSize: Font {
        //        if (DeviceTypeAndOrientation.isPhoneSmallDevice) {
        //            return .system(size: 15)
        //        } else {
        return .system(size: 20)
        //        }
    }
    static var errorFontSize: Font {
        if (DeviceTypeAndOrientation.isPhoneSmallDevice) {
            return .system(size: UIScreen.main.bounds.width * 0.03)
        } else {
            return .system(size: UIScreen.main.bounds.width * 0.04)
        }
    }
   
}
func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}


struct DependencyProvider {
    static func makeModelContext() -> ModelContext {
        let schema = Schema([User.self, Character.self])
        let container = try! ModelContainer(for: schema, configurations: [])
        return ModelContext(container)
    }
    
    static func makeAuthenticationViewModel() -> AuthenticationViewModel {
        let context = makeModelContext()
        let userRepo = UserRepositoryImpl(context: context)
        let userUseCase = UserUseCase(repo: userRepo)
        return AuthenticationViewModel(userRepository: userUseCase)
    }
    
    //      static func makeFavViewModel() -> FavoriteViewModel {
    //          let context = makeModelContext()
    //          return FavoriteViewModel(context: context)
    //      }
}

extension View {
    func withAuthenticationViewModel() -> some View {
        self.environmentObject(DependencyProvider.makeAuthenticationViewModel())
    }
    
}
