//
//  Provider.swift
//  Presentation
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation
import AppCore
import Domain

public class GitHubUserSearchPresenterProvider {
	
	public static func provide(
		wireframe : GitHubUserSearchWireframe,
		viewModel : GitHubUserSearchViewModel
	) -> GitHubUserSearchPresenter {
		
		let presenter = GitHubUserSearchPresenterImpl(
			usecase: GitHubUserSearchProvider.provide(),
			viewModel: viewModel
		)
		
		presenter.wireframe = wireframe
			
		return presenter
	}
	
}

class GitHubUserSearchPresenterImpl : GitHubUserSearchPresenter {
	
	weak var wireframe : GitHubUserSearchWireframe? = nil
	
	var usecase : GitHubUserSearchUseCase
	var viewModel : GitHubUserSearchViewModel
	
	init(
		usecase: GitHubUserSearchUseCase,
		viewModel : GitHubUserSearchViewModel
	){
		self.usecase = usecase
		self.viewModel = viewModel
	}
	
	func search(){
		
		
		self.changeStatus(.yet)
		
		guard let queryString = self.viewModel.query else {
			self.wireframe?.showQuerytAlert()
			return
		}
		
		//検索クエリーが短すぎる
		if queryString.count < 2 {
			self.wireframe?.showQuerytAlert()
			return
		}
		
		//通信開始
		self.changeStatus(.loading)
		
		//検索実行
		let query = GitHubUserSearchQuery(query: queryString)
		self.usecase.search(query) { ret in
			
			switch ret {
			case .success(let result):
				self.viewModel.users = result.users
				
				self.changeStatus(.finish)
				
				//0件の時
				if self.viewModel.users.count < 1 {
					self.wireframe?.showEmptyAlert()
					break
				}
			
				//それ以外は画面を更新する
				self.wireframe?.onLoadResult()
			
				break
			
			case .failure(_):
				self.changeStatus(.error)
				self.wireframe?.showApiError()
				break
			}
		}
	}
	
	func selectUser(_ user : UserData){
		self.wireframe?.selectUser(user)
	}
	
	private func changeStatus(_ status : GitHubUserSearchViewModel.Status){
		self.viewModel.status = status
		self.wireframe?.onChangeStatus()
	}
	
}
