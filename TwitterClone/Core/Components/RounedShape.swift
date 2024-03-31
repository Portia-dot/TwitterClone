//
//  RounedShape.swift
//  TwitterClone
//
//  Created by Modamori Oluwayomi on 2024-03-20.
//

import SwiftUI

struct RounedShape: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 80, height: 80))
        return Path(path.cgPath)
    }
}
