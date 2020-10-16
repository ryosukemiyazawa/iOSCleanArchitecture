//
//  Wireframe.swift
//  Presentation
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation
import AppCore

public protocol GitHubUserSearchWireframe : class {
	
	//リロード
	func onLoadResult()
	
	//ステータス変更
	func onChangeStatus()
	
	//ユーザーを選択
	func selectUser(_ user : UserData)
	
	//通信エラーを表示
	func showApiError()
	
	//検索結果がなかった時のエラーを表示
	func showEmptyAlert()
	
	//検索クエリーが無い場合
	func showQuerytAlert()
	
	
}
