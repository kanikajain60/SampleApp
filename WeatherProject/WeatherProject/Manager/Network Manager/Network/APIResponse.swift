//
//  APIResponse.swift
//  WeatherProject
//
//  Created by Kanika Jain on 11/10/23.
//

import Foundation

enum APIResult<String>{
    case success
    case failure(String)
}

enum APIResponseError:String, Error {
    case authenticationError = "Authentication required."
    case badRequest = "Bad request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case nilResponse = "Url response nil."
}

protocol ResponseRepresentable {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> APIResult<Error>
}

extension ResponseRepresentable {
    func handleNetworkResponse(_ response: HTTPURLResponse) -> APIResult<Error>{
        switch response.statusCode {
            case 200...299: return .success
            case 401...500: return .failure(APIResponseError.authenticationError)
            case 501...599: return .failure(APIResponseError.badRequest)
            case 600: return .failure(APIResponseError.outdated)
            default: return .failure(APIResponseError.failed)
        }
    }
}
