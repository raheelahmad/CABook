// Playground - noun: a place where people can play

import UIKit
import QuartzCore

/**
* CHAPTER 2
*/

/**
CALayer.contents can be AnyObject, but is drawn only for a CGImage object (not UIImage)
*/

//Chapter2.contentsRectSprites()

struct Chapter2 {
	
	static func contentsRectSprites() {
		let spriteImage = UIImage(named: "monuments_sprite.png")
		let jantar = CGRect(x: 0, y: 0, width: 377/800.0, height: 245/800.0)
		let nalanda = CGRect(x: 413/800.0, y: 0, width: 384/800.0, height: 245/800.0)
		let fort = CGRect(x: 0.0, y: 260/800.0, width: 423/800.0, height: 280/800.0)
		let spriteRects = [ jantar, nalanda, fort ]
		
		for rect in spriteRects {
			
			var baseView = Helpers.basicView(size: CGSize(width: rect.size.width * 800.0, height: rect.size.height * 800.0))
			baseView.layer.contents = spriteImage.CGImage
			baseView.layer.contentsGravity = kCAGravityResizeAspect
			baseView.layer.contentsRect = rect
			baseView // timeline this
		}
	}
	
	static func contentsRect() {
		let image = Helpers.tajImage()
		var baseView = Helpers.basicView(size: image.size)
		baseView.layer.contents = image.CGImage
		// can specify contentsRect in *relative coordinates*
		baseView.layer.contentsRect = CGRect(x: 0, y: 0, width: 0.4, height: 0.4)
		// unit can be > 0 or < 0
		baseView.layer.contentsRect = CGRect(x: 0.2, y: 0.2, width: 1.4, height: 1.4)
		baseView.layer.contentsRect = CGRect(x: -0.2, y: -0.2, width: 1.4, height: 1.4)
		
		baseView // timeline this
	}
	
	static func masksToBounds() {
		var baseView = Helpers.basicView(size: CGSize(width: 800, height: 800))
		
		let containerLayer = CALayer()
		containerLayer.frame = CGRect(x: 150, y: 150, width: 500, height: 500)
		containerLayer.backgroundColor = UIColor.darkGrayColor().CGColor
		
		let tajLayer = CALayer()
		let image = Helpers.tajImage()
		tajLayer.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
		tajLayer.contents = image.CGImage
		
		// Adding the image layer to the container layer
		containerLayer.addSublayer(tajLayer)
		baseView.layer.addSublayer(containerLayer)
		
		// since containerLayer's `masksToBounds` is false by default, tajLayer will overflow its superLayer's bounds
		// set the property to true to clip the image
//		containerLayer.masksToBounds = true
		
		baseView // timeline this
	}
	
	static func layerContentsGravity() {
		let tajImage = Helpers.tajImage()
		var view = Helpers.basicView()
		view.layer.contentsGravity = kCAGravityLeft // or any other of the string constants
		view.layer.contents = tajImage.CGImage
		let m = view.layer.contentsScale
		view
	}
	
	static func layerContents() { // Listing 2.1
		let tajImage = Helpers.tajImage()
		var view = Helpers.basicView()
		// Apparently, with Swift's bridging, we don't have to explcitly cast with (__bridge id)
		view.layer.contents = tajImage.CGImage
		view // timeline this
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
		var view = Helpers.basicView(size: CGSize(width: 300, height: 400))
		var hostedLayer = CALayer()
		hostedLayer.frame = CGRect(x: 20, y: 20, width: 260, height: 360)
		hostedLayer.backgroundColor = UIColor(hue: 0.3, saturation: 1.0, brightness: 0.8, alpha: 1.0).CGColor
		view.layer.addSublayer(hostedLayer)
		view // timeline this
	}
}


struct Helpers {
	static func tajImage() -> UIImage {
		return UIImage(named: "taj_mahal.jpg")
	}
	
	static func basicView(size: CGSize = CGSize(width: 400, height: 400)) -> UIView {
		var view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
		view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
		return view
	}
}
