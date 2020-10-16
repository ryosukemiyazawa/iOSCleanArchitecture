//
//  SearchUseCase.swift
//  Domain
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation
import AppCore

public struct GitHubUserSearchQuery {
	var query : String
	
	public init(query: String) {
		self.query = query
	}
}

public struct GitHubUserSearchResult {
	public var users : [UserData]
}

public protocol GitHubUserSearchUseCase {
	
	//検索
	func search(
			_ query : GitHubUserSearchQuery,
		_ completion: @escaping ((Result<GitHubUserSearchResult, Error>) -> Void)
	)
	
	
}

