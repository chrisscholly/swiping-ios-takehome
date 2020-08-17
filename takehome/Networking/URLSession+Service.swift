//
//  URLSession+Service.swift
//  takehome
//
//  Created by Timothy Lenardo on 6/9/20.
//  Copyright © 2020 Takeoff Labs, Inc. All rights reserved.
//

import Foundation

extension URLSession {

    @discardableResult func resumeDataTask<T: Decodable>(with url: URL, withTypedResponse response: @escaping (Result<T, APIServiceError>)->Void) -> URLSessionDataTask {
        let task = dataTask(with: url, withTypedResponse: response)
        task.resume()
        return task
    }

    @discardableResult func dataTask<T: Decodable>(with url: URL, withTypedResponse response: @escaping (Result<T, APIServiceError>)->Void) -> URLSessionDataTask {
        return dataTask(with: url, usingResult: { result in
            switch result {
            case .success(let (_, data)):
                let decoder = JSONDecoder()
                do {
                    let decodedTypeResponse = try decoder.decode(T.self, from: data)
                    response(.success(decodedTypeResponse))
                } catch (let error) {
                    response(.failure(.decodeError(error)))
                }
                break
            case .failure(let error):
                response(.failure(.apiError(error)))
                break
            }
        })
    }

    @discardableResult func dataTask(with url: URL, usingResult result: @escaping (Result<(URLResponse, Data), APIServiceError>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                result(.failure(.apiError(error)))
                return
            }

            guard let response = response, let data = data else {
                result(.failure(.invalidResponse))
                return
            }

            result(.success((response, data)))
        }
    }
}

public enum APIServiceError: Error {
    case apiError(Error)
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError(Error)
    case invalidUrl
}
