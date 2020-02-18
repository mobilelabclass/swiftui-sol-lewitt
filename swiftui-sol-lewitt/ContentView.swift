//
//  ContentView.swift
//  swiftui-sol-lewitt
//
//  Created by Sebastian Buys on 2/13/20.
//  Copyright © 2020 Sebastian Buys. All rights reserved.
//

import SwiftUI

/**
 Simple SwiftUI View demonstrating declarative drawing.
 
 Given an array of integers, draw concentric circles with
 radius, color, size, and offset determined by the integer value
 
 Inspired by Sol LeWitt
 https://massmoca.org/event/walldrawing915/
*/

/**
 Create an array of integers in descending order n --> 0.0.
 
 - Start with a Range 0 --> n
 - Reverse the Range to become n --> 0
 - Create an Array from the range
 */
let numbers = Array((0..<10).reversed())

// Create an array of Colors
let colors = [
    Color.red,
    Color.green,
    Color.orange,
    Color.blue,
    Color.purple,
    Color.yellow
]

// Band size is the delta between consecutive circle radii
// let bandSize: CGFloat = 20.0

struct ContentView: View {
    
    // Returns a Color for a given array index
    func colorAtIndex(_ index: Int) -> Color {
        // The % (modulo) operator returns the remainder
        // allowing us to cycle through the colors array
        colors[index % colors.count]
    }
    
    // Returns the radius length for a given array index
    func radiusAtIndex(_ index: Int) -> CGFloat {
        return CGFloat(40.0)
        // return CGFloat(index) * bandSize
    }
    
    func distanceFromCenterAtIndex(_ index: Int) -> CGFloat {
        return CGFloat(100.0)
    }

    // Returns a position offset for a given array index
    func offsetAtIndex(_ index: Int) -> CGSize {
        let count = numbers.count
        // let delta = Float(Angle.degrees(360).radians) / count
        let delta = (CGFloat.pi * 2) / CGFloat(count)
        let angle = CGFloat(index) * delta
        
        let x = cos(angle) * distanceFromCenterAtIndex(index)
        let y = sin(angle) * distanceFromCenterAtIndex(index)
        
        return CGSize(width: x, height: y)
        
        // return CGSize.zero
        // return CGSize(width: CGFloat(index) * 10.0, height: CGFloat(index) * 10.0)
    }
    
    var body: some View {
        // Circles are embedded in a ZStack
        // The reason we reversed the array earlier was
        // So that larger circles are drawing in the back
        
        ZStack {
            // ForEach is like the Map function.
            // It runs over each element in the collection, passing the
            // current value at each array position to the provided closure.
            
            // The closure returns a circle
            // with radius, color, size, and offset determined by the integer value
            
            ForEach(numbers, id: \.self) { number in
                Circle()
                    .fill(self.colorAtIndex(number))
                    .frame(width: self.radiusAtIndex(number),
                           height: self.radiusAtIndex(number))
                    .offset(self.offsetAtIndex(number))
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
