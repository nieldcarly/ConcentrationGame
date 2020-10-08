////
////  Rectangle.swift
////  concentration
////
////  Created by Carly Nield on 10/6/20.
////
//
import SwiftUI

struct Rectang: Shape {
    var percentage: CGFloat

    var animatableData: CGFloat {
        get {
            AnimatableData(percentage)
        }
        set {
            percentage = newValue
        }
    }
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.maxY)
        let rightSide = rect.maxX * percentage
        
        var p = Path()
        
        p.move(to: start)
        p.addLine(to: CGPoint(x: rightSide, y: start.y))
        p.addLine(to: CGPoint(x: rightSide, y: start.y-5))
        p.addLine(to: CGPoint(x: start.x, y: start.y-5))
        
        return p
    }
}

struct Rectang_Previews: PreviewProvider {
    static var previews: some View {
        Rectang(percentage: 0.5)
            .foregroundColor(.orange)
    }
}
