//
//  GitHubUserSearchProvider.swift
//  Domain
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation
import DataStore

public struct GitHubUserSearchProvider {
	
	public static func provide() -> GitHubUserSearchUseCase {
		return GitHubUserSearchUseCaseImpl(
			repository: GitHubUserSearchRepositoryProvider.provide()
		)
	}
	
}

private class GitHubUserSearchUseCaseImpl : GitHubUserSearchUseCase {
	
	var repository: GitHubUserSeachRepository
	var translator : GitHubUserSearchTranslator
	
	init(repository: GitHubUserSeachRepository){
		self.repository = repository
		self.translator = GitHubUserSearchTranslator()
	}
		 
	func search(
			_ query : GitHubUserSearchQuery,
		_ completion: @escaping ((Result<GitHubUserSearchResult, Error>) -> Void)
	) {
		
		self.repository.search(query.query) { ret in
			switch ret {
			case .success(let data):
				
				let userDataList = data.compactMap({ self.translator.convert($0)})
				return completion(.success(GitHubUserSearchResult(users: userDataList)))
				
			case .failure(let error):
				
				return completion(.failure(error))
			}
		}
		
	}
	
}
