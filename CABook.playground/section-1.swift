// Playground - noun: a place where people can play

import UIKit
import QuartzCore

/**
* CHAPTER 2
*/

/**
CALayer.contents can be AnyObject, but is drawn only for a CGImage object (not UIImage)
*/

//Chapter2.layerContents()

struct Chapter2 {
	static func layerContents() { // Listing 2.1
		let tajImage = UIImage(named: "taj_mahal.jpg")
		var view = Helpers.basicView(CGSize(width: 1280, height: 736))
		// Apparently, with Swift's bridging, we don't have to explcitly cast with (__bridge id)
		view.layer.contents = tajImage.CGImage
		view
	}
}

/**
* CHAPTER 1
*/

/**
UIView's rendering, layout, and animation is managed by CALayer.
UIView handles user interaction on its own. CALayer is not part of the responder chain.
This separation of concerns (drawing/animation/geometry vs. user interaction) is served by CALAyer/UIView and CALayer/NSView as user interaction is OS specific.

View keeps a backing layer (.layer) and is responsible for managing their hierarchy.
*/

/*
* A view can have one *backing* layer, but can *host* several layers.
*/

//Chapter1.hostedLayer()

struct Chapter1 {
	static func hostedLayer() {
		var view = Helpers.basicView(CGSize(width: 300, height: 400))
		var hostedLayer = CALayer()
		hostedLayer.frame = CGRect(x: 20, y: 20, width: 260, height: 360)
		hostedLayer.backgroundColor = UIColor(hue: 0.3, saturation: 1.0, brightness: 0.8, alpha: 1.0).CGColor
		view.layer.addSublayer(hostedLayer)
		view
	}
}


struct Helpers {
	static func basicView(size: CGSize) -> UIView {
		var view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
		view.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
		return view
	}
}
