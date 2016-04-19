//: Playground - noun: a place where people can play

import UIKit
import Foundation
import XCPlayground


let controllerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
XCPlaygroundPage.currentPage.liveView = controllerView

let navBarHeight:CGFloat = 50
let statusBarHeight:CGFloat = 20

// Create a fake navBar
let navBarView = UIView(frame: CGRect(x: 0.0, y: statusBarHeight, width: 375.0, height: navBarHeight))
let statusBarView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: statusBarHeight))
navBarView.backgroundColor = UIColor(red:0.42, green:0.13, blue:0.65, alpha:1.00)
statusBarView.backgroundColor = UIColor.blackColor()
navBarView.layer.zPosition = CGFloat(MAXFLOAT)
statusBarView.layer.zPosition = CGFloat(MAXFLOAT)

controllerView.addSubview(containerView)
controllerView.addSubview(navBarView)
containerView.addSubview(statusBarView)

// Setup the image
let image = UIImage(named: "Unique.jpg")
let imageView = UIImageView(image: image)
imageView.frame = containerView.frame
imageView.contentMode = UIViewContentMode.ScaleAspectFill
containerView.addSubview(imageView)

// Draw View Finder
let p = ViewFinderPainter(frame: containerView.frame)
let gray = p.createGrayMask()
let frame = p.createFrame()

containerView.addSubview(frame)
containerView.addSubview(gray)
