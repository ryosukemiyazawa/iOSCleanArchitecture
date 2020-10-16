//
//  ViewModel.swift
//  Presentation
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation
import AppCore

public class GitHubUserSearchViewModel {
	
	public enum Status {
		case yet
		case loading
		case finish
		case error
	}
	
	//通信状態
	public var status : Status = .yet
	
	//結果格納用
	public var users : [UserData] = []
	
	//検索文言
	public var query : String?
	
	public init(){
		
	}
	
}
