//
//  GitHubUserSearchTranslator.swift
//  Domain
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation
import AppCore

class GitHubUserSearchTranslator {
	
	func convert(_ data : [String:Any]) -> UserData? {
		
		guard let name = data["login"] as? String,
			  let url = data["html_url"] as? String,
			  let icon = data["avatar_url"] as? String,
			  let type = data["type"] as? String else {
			return nil
		}
		
		return UserData(
			name: name,
			url: url,
			icon: icon,
			type: type
		)
		
	}
	
}
