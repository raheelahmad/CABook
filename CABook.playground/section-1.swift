// Playground - noun: a place where people can play

import UIKit
import QuartzCore

/*
 * Chapter 3
 */

// Frame is a computed property from bounds, position & transform
// Setting a transform will change the frame making them different from the bounds

maskingAndShadows()

func maskingAndShadows() {
    var baseView = Helpers.basicView()
    var layerBelow = CALayer()
    var layerAbove = CALayer()
    var p = 50
    layerBelow.zPosition = 1.0
    for layer in [layerBelow, layerAbove] {
        let side = 100
        var container = CALayer()
        container.frame = CGRect(x: p, y: p, width: side, height: side)
        container.shadowOffset = CGSize(width: 0.0, height: 2.0)
        container.shadowOpacity = 0.4
        container.shadowRadius = 20.0
        
        layer.frame = container.bounds
        layer.backgroundColor = Helpers.randomColor()
        layer.cornerRadius = 14.0
        layer.borderWidth = 2.0
        layer.masksToBounds = true
        let s = CAShapeLayer()
        s.path = UIBezierPath(ovalInRect: CGRect(x: -40, y: -40, width: 120, height: 120)).CGPath
        s.fillColor = Helpers.randomColor()
        layer.addSublayer(s)
        container.addSublayer(layer)
        
        baseView.layer.addSublayer(container)
        p *= 2
    }
    
    baseView
}

class HandView: UIView {
    init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func drawRect(rect: CGRect) {
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        let ctx = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
        CGContextFillRect(ctx, self.bounds)
        
        CGContextSetStrokeColorWithColor(ctx, UIColor.blueColor().CGColor)
        CGContextSetLineWidth(ctx, 1.0)
        CGContextMoveToPoint(ctx, 0, h)
        CGContextAddLineToPoint(ctx, w/2.0, 0.0)
        CGContextAddLineToPoint(ctx, w, h)
        
        CGContextStrokePath(ctx)
    }
}

func drawClock() {
    let w = 400, h = 400
    var baseView = Helpers.basicView(size: CGSize(width: w, height: h))
    let handFrame = CGRect(x: w/2, y: h/2, width: 15, height: h/2)
    let handView = HandView(frame: handFrame)
    handView.layer.anchorPoint = CGPoint(x:0.0, y:1.0)
    handView.frame = handFrame
    handView.transform = CGAffineTransformMakeTranslation(100, 20)
    baseView.addSubview(handView)
    baseView
}


/**
* CHAPTER 2
*/

/**
CALayer.contents can be AnyObject, but is drawn only for a CGImage object (not UIImage)
*/

//Chapter2.drawRect()

struct Chapter2 {
    
    static func drawRect() { // not working: possibly because of CALayerDelegate + Swift ?
        // drawRect is not needed if layer has contents or using a background color
        //  otherwise, it creates a backing image of view.size * contentsScale
        //  drawRect draws into the backing image via CG, which is then cached until need to be redrawn
        
        // CALayer asks its delegate (the view if it's a view's backing layer) to displayLayer:
        // or to drawLayer:inContext:
        // the second sets up an empty image first and then calls with a context setup to draw in that image
        class LayerDelegate {
            func drawLayer(layer: CALayer?, inContext context: CGContextRef?) {
                println("Draw")
                CGContextSetLineWidth(context, 2.0)
                CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
                CGContextStrokeEllipseInRect(context, CGRectInset(layer!.bounds, 20, 20))
            }
        }
        let layerDelegate = LayerDelegate()
        
        var someLayer = CALayer()
        someLayer.frame = CGRect(x: 20, y: 20, width: 200, height: 200)
        someLayer.backgroundColor = UIColor.whiteColor().CGColor
        someLayer.delegate = layerDelegate
        someLayer.display()
        
        var baseView = Helpers.basicView(size: CGSize(width: 400, height: 400))
        baseView.backgroundColor = UIColor.blueColor()
        baseView.layer.addSublayer(someLayer)
        baseView
    }
    
    static func contentsCenter() {
        let baseView = Helpers.basicView(size: CGSize(width: 500, height: 500))
        let iosImage = UIImage(named: "ios.png")
        let iosLayer = CALayer()
        iosLayer.contents = iosImage.CGImage
        iosLayer.frame = baseView.bounds
        // setting an inset rect (in unit coordinates) will stretch the layer's backing image with respect to the border
        //  Similar to the UIImage.resizableImageWithCapInsets: but can be applied to any image
        //  This setting is available in Xcode IB for a view's inspector as Stretching parameters
        iosLayer.contentsCenter = CGRect(x: 0.25, y: 0.25, width: 0.5, height: 0.5)
        baseView.layer.addSublayer(iosLayer)
        
        baseView // timeline this
    }
	
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
    
    static func randomColor() -> CGColorRef {
        let r = CGFloat(arc4random() % 255) / 255.0
        let g = CGFloat(arc4random() % 255) / 255.0
        let b = CGFloat(arc4random() % 255) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0).CGColor
    }
}
