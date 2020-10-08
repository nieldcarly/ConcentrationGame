//
//  Shapes.swift
//  concentration
//
//  Created by Carly Nield on 10/6/20.
//

import SwiftUI

struct SquiggleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 1040, y: 150))
        path.addCurve(to: CGPoint(x: 630, y: 540),
                      control1: CGPoint(x: 1124, y: 369),
                      control2: CGPoint(x: 897, y: 608))
        path.addCurve(to: CGPoint(x: 270, y: 530),
                      control1: CGPoint(x: 523, y: 513),
                      control2: CGPoint(x: 422, y: 420))
        path.addCurve(to: CGPoint(x: 50, y: 400),
                      control1: CGPoint(x: 96, y: 656),
                      control2: CGPoint(x: 54, y: 583))
        path.addCurve(to: CGPoint(x: 360, y: 120),
                      control1: CGPoint(x: 46, y: 220),
                      control2: CGPoint(x: 191, y: 97))
        path.addCurve(to: CGPoint(x: 890, y: 140),
                      control1: CGPoint(x: 592, y: 152),
                      control2: CGPoint(x: 619, y: 315))
        path.addCurve(to: CGPoint(x: 1040, y: 150),
                      control1: CGPoint(x: 953, y: 100),
                      control2: CGPoint(x: 1009, y: 69))

        let scale: CGFloat = rect.height / path.boundingRect.height

        path = path.applying(
            CGAffineTransform(scaleX: scale, y: scale)
                .rotated(by: CGFloat.pi / 2)
        )

        return path.offsetBy(
            dx: (rect.minX - path.boundingRect.minX + rect.width) / 2,
            dy: rect.midY - path.boundingRect.midY
        )
    }
}

struct Star: Shape {
    // store how many corners the star has, and how smooth/pointed it is
    let corners: Int
    let smoothness: CGFloat

    func path(in rect: CGRect) -> Path {
        // ensure we have at least two corners, otherwise send back an empty path
        guard corners >= 2 else { return Path() }

        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)

        // start from directly upwards (as opposed to down or to the right)
        var currentAngle = -CGFloat.pi / 2

        // calculate how much we need to move with each star corner
        let angleAdjustment = .pi * 2 / CGFloat(corners * 2)

        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        // we're ready to start with our path now
        var path = Path()

        // move to our initial position
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))

        // track the lowest point we draw to, so we can center later
        var bottomEdge: CGFloat = 0

        // loop over all our points/inner points
        for corner in 0..<corners * 2  {
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: CGFloat

            // if we're a multiple of 2 we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this Y position
                bottom = center.y * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // we're not a multiple of 2, which means we're drawing an inner point

                // store this Y position
                bottom = innerY * sinAngle

                // …and add a line to there
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }

            // if this new bottom point is our lowest, stash it away for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }

            // move on to the next corner
            currentAngle += angleAdjustment
        }

        // figure out how much unused space we have at the bottom of our drawing rectangle
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2

        // create and apply a transform that moves our path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}
