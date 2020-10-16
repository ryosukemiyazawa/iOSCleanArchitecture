//
//  UserDataCell.swift
//  App
//
//  Created by Miyazawa on 2020/10/16.
//

import UIKit
import AppCore
import Alamofire

class UserDataCell : UITableViewCell {
	
	var user : UserData? {
		didSet {
			self.configure()
		}
	}
	
	init() {
		super.init(style: .subtitle, reuseIdentifier: "UserDataCell")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure(){
		
		self.textLabel?.text = self.user?.name
		self.detailTextLabel?.text = self.user?.type
		self.imageView?.image = UIImage.imageWithColor(color: .gray)
		self.imageView?.clipsToBounds = true
		self.imageView?.contentMode = .scaleAspectFit
		
		self.imageView?.frame.size = CGSize(width: 64, height: 64)
		
		//画像の読み込み
		if let icon = self.user?.icon {
			AF.request(icon).response {
				[weak self] response in
				if let data = response.data {
					self?.imageView?.image = UIImage(data: data, scale:1)

					self?.setNeedsLayout()
				}
			}
		}
		
		
	}
	
}


extension UIImage {
  class func imageWithColor(color: UIColor) -> UIImage? {
	let rect: CGRect = CGRect(x: 0, y: 0, width: 64, height: 64)
	UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
	color.setFill()
	UIRectFill(rect)
	
	let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
	UIGraphicsEndImageContext()
	return image
  }
}
