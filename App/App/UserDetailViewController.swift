//
//  UserDetailViewController.swift
//  SampleApp
//
//  Created by Miyazawa on 2020/09/22.
//

import UIKit
import AppCore

class UserDetailViewController : UIViewController {
	
	var user : UserData?
	
	var label : UILabel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = self.user?.name
		self.view.backgroundColor = .white
		
		
		
	}
	
	
}
