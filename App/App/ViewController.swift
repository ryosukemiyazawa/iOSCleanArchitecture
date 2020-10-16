//
//  ViewController.swift
//  FastlaneWithCodegen
//
//  Created by Miyazawa on 2020/10/14.
//

import UIKit
import AppCore
import Presentation

class ViewController: UIViewController {
	
	lazy var viewModel : GitHubUserSearchViewModel = GitHubUserSearchViewModel()
	
	lazy var userSearchPresenter : GitHubUserSearchPresenter = {
		let presenter = GitHubUserSearchPresenterProvider.provide(
			wireframe : self,
			viewModel : self.viewModel
		)
		return presenter
	}()
	
	lazy var tableView : UITableView = {
		let tv = UITableView(frame: self.view.bounds, style: .plain)
		
		tv.delegate = self
		tv.dataSource = self
		
		//カスタムセルの登録
		tv.register(UserDataCell.self, forCellReuseIdentifier: "UserDataCell")
		
		return tv
	}()
	
	private var searchController: UISearchController!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		self.title = "ユーザー検索"
		self.view.backgroundColor = .red
		
		//テーブルViewの設定
		self.view.addSubview(self.tableView)
		
		//検索UIのセットアップ
		self.setupSearch()
		
	}
	
	//検索バーのセットアップ
	private func setupSearch() {
		searchController = UISearchController(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.searchBar.delegate = self
		searchController.obscuresBackgroundDuringPresentation = false
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = true
	}


}

//ワイヤーフレーム
extension ViewController : GitHubUserSearchWireframe {

	//リロード
	func onLoadResult(){
		self.tableView.reloadData()
	}
	
	//ステータス変更
	func onChangeStatus(){
		
	}
	
	//ユーザーを選択
	func selectUser(_ user : UserData){
		let next = UserDetailViewController()
		next.user = user
		self.navigationController?.pushViewController(next, animated: true)
	}
	
	//通信エラーを表示
	func showApiError(){
		let alert = UIAlertController(title: "エラー", message: "通信に失敗しました。", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	//検索結果がなかった時のエラーを表示
	func showEmptyAlert(){
		let alert = UIAlertController(title: "エラー", message: "検索結果が見つかりません", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	
	//検索クエリーが無い場合
	func showQuerytAlert(){
		let alert = UIAlertController(title: "エラー", message: "２文字以上入力してください", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
	

}

// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
	
	func updateSearchResults(for searchController: UISearchController) {
		
	}
}

// MARK: - UISearchBarDelegate
extension ViewController : UISearchBarDelegate {
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		let searchText = searchBar.text
		self.viewModel.query = searchText
		self.userSearchPresenter.search()
		
	}
	
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.users.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataCell") as? UserDataCell else {
			return UITableViewCell()
		}
		
		let user = self.viewModel.users[indexPath.row]
		cell.user = user
		
		return cell
		
	}
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let user = self.viewModel.users[indexPath.row]
		self.userSearchPresenter.selectUser(user)
	}
}


