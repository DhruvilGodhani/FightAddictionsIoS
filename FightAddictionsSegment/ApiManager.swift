//
//  ApiManager.swift
//  FightAddictionsSegment
//
//  Created by ADMIN on 05/12/24.
//

import Foundation
import Alamofire

func callApi(completionHandler: @escaping(Result<[QuoteModel], Error>) -> Void){
    AF.request("https://fight-addictions-api.deno.dev/motivational/quotes").responseDecodable(of: [QuoteModel].self){
        response in
        switch response.result{
        case .success(let data):
            completionHandler(.success(data))
        case .failure(let error):
            completionHandler(.failure(error))
        }
    }
}
