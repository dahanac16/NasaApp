//
//  NetworkingProvider.swift
//  NasaApp
//
//  Created by Michel Arboleda on 28/01/25.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    func getData(success: @escaping (_ data: NasaModel) -> (), failure: @escaping (_ error: String) -> ()) {
        
        let url = Constants.URL
        
        AF.request(url, method: .get).validate(statusCode: Constants.STATUSSUCCESS).responseDecodable(of: NasaModel.self) {
            response in
            
            if let data = response.value {
                success(data)
            } else {
                failure(response.error?.errorDescription ?? "algo salió mal")
            }
        }
    }
    
}
