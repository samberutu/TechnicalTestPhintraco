//
//  GetDeviceSize.swift
//  Technical Test Phintraco
//
//  Created by Samlo Berutu on 03/03/23.
//

import SwiftUI

extension UIScreen {
    static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
    static let screenSize: CGSize = UIScreen.main.bounds.size
    static let pkmCardWidth: CGFloat = (screenWidth-64)/2
    static let pkmCardGeight: CGFloat = ((screenWidth-64)/2) + 8
    static let viewPadding: CGFloat = 16.0
    static let pkmCornerRadius: CGFloat = 8.0
}
