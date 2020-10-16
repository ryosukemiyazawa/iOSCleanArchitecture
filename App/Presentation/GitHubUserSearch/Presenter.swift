//
//  Presenter.swift
//  Presentation
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation
import AppCore

public protocol GitHubUserSearchPresenter {
	
	func search()
	func selectUser(_ user : UserData)
	
}
