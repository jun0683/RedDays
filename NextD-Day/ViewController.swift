//
//  ViewController.swift
//  NextD-Day
//
//  Created by 국진 전 on 2014. 9. 11..
//  Copyright (c) 2014년 honggu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
	@IBOutlet weak var DDayLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		var ContentSize : CGSize = self.preferredContentSize
		NSLog("%f", ContentSize.height)
		self.preferredContentSize = ContentSize
		
		
		let t = NextDDay()
		println("\(t.NextD())")
		DDayLabel.text = "D-\(t.NextD())"
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

