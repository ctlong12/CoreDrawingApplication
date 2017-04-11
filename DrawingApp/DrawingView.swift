//
//  DrawingView.swift
//  DrawingApp
//
//  Created by Chandler on 4/10/17.
//  Copyright © 2017 C-LongDev. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    
    var drawImage: UIImage?
    var samplePoints = [CGPoint]()
    let path = UIBezierPath()
    var cleared = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.lineWidth = 5
    }

    //Touches Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        samplePoints.append(touch.location(in: self))
    }
    
    
    //Touches Moved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        for coalescedTouches in event!.coalescedTouches(for: touch)! {
            samplePoints.append(coalescedTouches.location(in: self))
        }
        setNeedsDisplay()
    }
    
    //Touches Ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        drawImage = UIGraphicsGetImageFromCurrentImageContext()
        samplePoints.removeAll()
        
    }
    
    //Touches Cancelled
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    //Draw Functions
    
    func getMidPoint(a: CGPoint, andB b: CGPoint) -> CGPoint{
        return CGPoint(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2)
    }
    
    override func draw(_ rect: CGRect) {
        let drawContext = UIGraphicsGetCurrentContext()
        
        drawContext?.setAllowsAntialiasing(true)
        drawContext?.setShouldAntialias(true)
        
        var color = getStrokeColor()
        color.setStroke()
        
        path.removeAllPoints()
        drawImage?.draw(in: rect)
        
        if !samplePoints.isEmpty {
            path.move(to: samplePoints.first!)
            path.addLine(to: getMidPoint(a: samplePoints.first!, andB: samplePoints[1]))
            
            for index in 1..<samplePoints.count - 1 {
                let midPoint = getMidPoint(a: samplePoints[index], andB: samplePoints[index + 1])
                
                path.addQuadCurve(to: midPoint, controlPoint: samplePoints[index])
            }
            
            path.addLine(to: samplePoints.last!)
            
            path.stroke()
            
        }
    }
    
    func getStrokeColor() -> UIColor {
        var colors = [Color.blue, Color.green,
                      Color.orange, Color.purple,
                      Color.red,Color.yellow]
        
        return colors[1]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
