import Foundation
import UIKit

public class ViewFinderPainter{
    
    let frame: CGRect
    
    // Gloden ratio multiplier
    let ratio:CGFloat = 1.618
    // Color alpha
    let alpha:CGFloat = 0.6
    
    // Parent View Width
    var pWidth: CGFloat{
        get{
            return frame.width
        }
    }
    
    // Parent View Height
    var pHeight: CGFloat{
        get{
            return frame.height
        }
    }
    
    var x: CGFloat{
        get{
            return (pWidth - pWidth/ratio)/2
        }
    }
    
    var y: CGFloat{
        get{
            return (pHeight - pWidth/ratio)/2
        }
    }
    
    var finderSideLenght: CGFloat{
        get{
            return pWidth/ratio
        }
    }
    
    /**
     Create the ViewFinder view in certain frame
     */
    public init(frame: CGRect){
        self.frame = frame
    }

    public func createGrayMask() -> UIView{
        // Create a gray view
        let gray = UIView(frame: CGRect(x: 0.0, y: 0.0, width: pWidth, height: pHeight))
        gray.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(alpha)
        
        // Mask the view

        let maskLayer = createMaskLayer()
        gray.layer.mask = maskLayer

        let frameView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: pWidth, height: pHeight))
        frameView.layer.addSublayer(createFrameLayer())
        gray.addSubview(frameView)
        
        gray.clipsToBounds = true
        return gray
    }
    
    public func createFrame() -> UIView{
        
        let frameView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: pWidth, height: pHeight))
        frameView.layer.addSublayer(createFrameLayer())
        frameView.clipsToBounds = true
        return frameView
    }
    
    func createMaskLayer() -> CAShapeLayer{
        // Create mask sublayer
        let maskLayer = CAShapeLayer()
        // Init the path
        let path = CGPathCreateMutable()
        
        // More tutorial can be find on here: http://stackoverflow.com/questions/28448698/how-do-i-create-a-uiview-with-a-transparent-circle-inside-in-swift
        
        // Create two Rect and combine together to create the mask shape
        CGPathAddRect(path, nil, CGRectMake(0, 0, pWidth, pHeight))
        CGPathAddRect(path, nil, CGRectMake(x, y, finderSideLenght, finderSideLenght))
        maskLayer.path = path;
        maskLayer.fillRule = kCAFillRuleEvenOdd
        return maskLayer
    }
    
    func createFrameLayer() -> CAShapeLayer{
        let path = UIBezierPath()
        let bottom = y+finderSideLenght
        let right = x+finderSideLenght
        
        let cornerLength = finderSideLenght * 0.2
        
        // Draw the left half finder frame
        path.moveToPoint(CGPointMake(x+cornerLength, y))
        path.addLineToPoint(CGPointMake(x, y))
        path.addLineToPoint(CGPointMake(x, bottom))
        path.addLineToPoint(CGPointMake(x+cornerLength, bottom))
        
        // Draw the right half finder frame
        path.moveToPoint(CGPointMake(right-cornerLength, y))
        path.addLineToPoint(CGPointMake(right, y))
        path.addLineToPoint(CGPointMake(right, bottom))
        path.addLineToPoint(CGPointMake(right-cornerLength, bottom))
        
        let frameLayer = CAShapeLayer()
        frameLayer.path = path.CGPath
        
        frameLayer.strokeColor = UIColor.whiteColor().CGColor
        frameLayer.lineWidth = 8.0
        frameLayer.fillColor = UIColor.clearColor().CGColor
        return frameLayer
    }
}