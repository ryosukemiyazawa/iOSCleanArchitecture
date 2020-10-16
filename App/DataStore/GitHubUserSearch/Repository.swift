//
//  Repository.swift
//  DataStore
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation

public protocol GitHubUserSeachRepository {
	
	func search(_ query : String, _ callback: @escaping (Result<[[String:Any]], Error>) -> Void)
	
}
