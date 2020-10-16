//
//  UserData.swift
//  Domain
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation

public struct UserData {
	
	public var name : String
	public var url : URL?
	public var icon : URL?
	public var type : String
	
	public init(name: String, url: String, icon: String, type: String) {
		self.name = name
		self.url = URL(string: url)
		self.icon = URL(string: icon)
		self.type = type
	}
	
}
