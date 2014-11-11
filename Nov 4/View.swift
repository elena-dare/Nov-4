//
//  View.swift
//  Nov 4
//
//  Created by Elena Da Re on 11/9/14.
//  Copyright (c) 2014 Elena Da Re. All rights reserved.
//

import UIKit
import GLKit

class View: UIView {
	
	var y: CGFloat = 0;

	required init (coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		//Unnecessary because white is the default.  Must come here, not in drawRect.
		backgroundColor = UIColor.whiteColor();
	}
 
    override func drawRect(rect: CGRect) {
		
		let minimum = min (bounds.size.width, bounds.size.height);
		
		let shortSide = 0.1 * minimum;
		let longSide = 1.3 * shortSide;
		let triSide = 1.5 * shortSide;
		
		let c: CGContextRef = UIGraphicsGetCurrentContext();
		CGContextBeginPath(c);
		
		CGContextTranslateCTM(c, bounds.size.width / 2, bounds.size.height); //translate to the bottom center
		
		CGContextTranslateCTM(c, 0, -y); //move the missil up
		
		if y < bounds.size.height-(longSide + triSide) {
			++y;
		} else {
			let s: String = "BOOM!";
			let font: UIFont = UIFont.systemFontOfSize(26);
			let attributes: [NSObject: AnyObject] = [NSFontAttributeName: font]; //a dictionary
			let point: CGPoint = CGPointZero;
			s.drawAtPoint(point, withAttributes: attributes);
		}
		
		let rect: CGRect = CGRectMake(-shortSide/2, -longSide , shortSide, longSide);
		CGContextAddRect(c, rect);	//add the rectangular missil base
		
		CGContextTranslateCTM(c, -triSide/2, -longSide); //translate to the top of the rectangular base
		
		CGContextMoveToPoint(c, 0, 0);          //lower left vertex
		CGContextAddLineToPoint(c, triSide, 0);  //lower right vertex
		CGContextAddLineToPoint(c, triSide/2, -triSide/2); //upper vertex
		CGContextClosePath(c);
		
		CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
		CGContextFillPath(c);
		
		//Call drawRect(_:) 200 times per second.
		let t: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)/200);
		dispatch_after(t, dispatch_get_main_queue(), {self.setNeedsDisplay();});
		
    }

}
