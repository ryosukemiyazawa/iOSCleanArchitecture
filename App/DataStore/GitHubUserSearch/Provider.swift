//
//  Provider.swift
//  DataStore
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation

public struct GitHubUserSearchRepositoryProvider {
	
	public static func provide() -> GitHubUserSeachRepository {
		return GitHubUserSeachRepositoryImpl()
	}
	
}

//リポジトリー（APIの実態とつなぐ役割）
class GitHubUserSeachRepositoryImpl : GitHubUserSeachRepository {
	
	func search(_ query: String, _ callback: @escaping (Result<[[String : Any]], Error>) -> Void) {
		
		GitHubUserSearchAPI(query: query).search(callback)
		
	}
	
	
}
