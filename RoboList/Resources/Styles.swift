//
//  Styles.swift
//  RoboList
//
//  Created by Chico Han on 27/09/2024.
//


import Foundation

import SwiftUI

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .autocapitalization(.none)
    }
}

struct HomeTitleFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.custom("Poppin-SemiBold", size: 25))
            .foregroundColor(.cyan)
            .cornerRadius(8)
            .autocapitalization(.none)
            .multilineTextAlignment(.center)
    }
}
struct HomeMediumFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Poppin-SemiBold", size: 16))
            .cornerRadius(8)
            .autocapitalization(.none)
            .multilineTextAlignment(.center)
    }
}


struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            .cornerRadius(20)
    }
}


extension View {
    func loginFormtextFieldStyle() -> some View {
        self.modifier(TextFieldStyle())
    }
    
    func loginButtonStyle() -> some View {
        self.modifier(ButtonStyle())
    }
    func todayDateTitleStyle() -> some View{
        self.modifier(HomeTitleFieldStyle())
    }
    func homeMediumTextStyle() -> some View{
        self.modifier(HomeMediumFieldStyle())
    }
    
    
}
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let red = Double((rgbValue & 0xff0000) >> 16) / 255
        let green = Double((rgbValue & 0xff00) >> 8) / 255
        let blue = Double(rgbValue & 0xff) / 255
        self.init(red: red, green: green, blue: blue)
    }
}

extension View {
    @ViewBuilder
    var conditionalVerticalContainerFrame: some View {
        if #available(iOS 17.0, *) {
            self.containerRelativeFrame(.vertical) { size, axis in
                size * 0.6
            }
        } else {
            let screenSize = UIScreen.main.bounds.size
            let height = screenSize.height * 0.6
            self.frame(height: height)
        }
    }
}

extension View {
    @ViewBuilder
    func conditionalHorizontalContainerFrame(dimens: CGFloat) -> some View {
        if #available(iOS 17.0, *) {
            self.containerRelativeFrame(.horizontal) { size, axis in
                size * dimens
            }
        } else {
            let screenSize = UIScreen.main.bounds.size
            let height = screenSize.height * dimens
            self.frame(height: height)
        }
    }
}

extension View {
    @ViewBuilder
    func conditionalContainerFrame(for axis: Axis.Set) -> some View {
        if #available(iOS 17.0, *) {
            self.containerRelativeFrame(axis) { size, axis in
                size * 0.6
            }
        } else {
            let screenSize = UIScreen.main.bounds.size
            if axis == .horizontal {
                let width = screenSize.width * 0.6
                self.frame(width: width)
            } else {
                let height = screenSize.height * 0.6
                self.frame(height: height)
            }
        }
    }
}

extension View {
    @ViewBuilder
    func axisRelativeFrame(for axis: Axis.Set) -> some View {
        if #available(iOS 17.0, *) {
            self.containerRelativeFrame(axis) { length, axis in
                if axis == .horizontal {
                    return length / 2
                } else {
                    return length / 5
                }
            }
            .padding()
        } else {
            let screenSize = UIScreen.main.bounds.size
            if axis.contains(.horizontal) && axis.contains(.vertical) {
                self.frame(width: screenSize.width / 2, height: screenSize.height / 5)
            } else if axis.contains(.horizontal) {
                self.frame(width: screenSize.width / 2)
            } else if axis.contains(.vertical) {
                self.frame(height: screenSize.height / 5)
            } else {
                self
            }
           
        }
    }
}
