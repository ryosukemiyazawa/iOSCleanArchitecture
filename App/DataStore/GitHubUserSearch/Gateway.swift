//
//  Gateway.swift
//  DataStore
//
//  Created by Miyazawa on 2020/10/16.
//

import Foundation
import Alamofire

struct GitHubUserSearchAPI {
	
	var query : String
	
	func search(_ callback: @escaping (Result<[[String:Any]], Error>) -> Void) {
		
		let url = "https://api.github.com/search/users?q=\(query)"
		
		AF.request(url, method: .get)
			.validate(statusCode: 200..<300)
			.validate(contentType: ["application/json"])
			.responseJSON { response in
				
				switch response.result {
				case .success:
					print("👌 Validation Successful")
					if let data = response.value {
						self.onSuccess(data, callback)
					}
					break
					
				case let .failure(error):
					print("🆘 エラー発生")
					print(error)
					self.onReceiveError(error, callback)
				}
			}
		
		
	}
	
	private func onSuccess(_ data : Any, _ callback: @escaping (Result<[[String:Any]], Error>) -> Void){
		
		guard let item = data as? [String:Any],
			  let users = item["items"] as? [[String:Any]] else{
			
			let jsonError = JSONParseError(data: data)
			callback(.failure(jsonError))
			return
		}
		
		callback(.success(users))
		
	}
	
	private func onReceiveError(_ error : Error, _ callback: @escaping (Result<[[String:Any]], Error>) -> Void){
		
		callback(.failure(error))
	}
	
	public class JSONParseError : Error {
		public var data : Any
		
		init(data: Any) {
			self.data = data
		}
	}
	
}
