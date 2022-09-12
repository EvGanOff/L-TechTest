//
//  NetworkManager.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/8/22.
//

import UIKit
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let url = "http://dev-exam.l-tech.ru"

    private let configuration = URLConfiration()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }

    func getData(completion: @escaping (Result<[MainModel], LError>) -> Void) {
        AF.request(configuration.getMainURL(), method: .get).response { response in
            guard let data = response.data else { return }

            do {
                let result = try self.decoder.decode([MainModel].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invaliedData))
            }
        }
    }

    func getMaskNumber(completion: @escaping (Result<MaskNumberModel, LError>) -> Void) {
        AF.request(configuration.getMaskNumberURL(), method: .get).response { response in
            guard let data = response.data else { return }

            do {
                let result = try self.decoder.decode(MaskNumberModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invaliedData))
            }
        }
    }

    func authorize(userModel: UserModel, completion: @escaping (Result <Bool, LError>) -> Void) {
        do {
            guard let url = URL(string: configuration.postAuthURL()) else {
                completion(.failure(LError.invaliedRespons))
                return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = try encoder.encode(userModel)

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    if let httpResponse = response as? HTTPURLResponse, (401...403).contains(httpResponse.statusCode) {
                        completion(.success(false))
                        return
                    } else {
                        completion(.failure(.invaliedRespons))
                        return
                    }
                }
                completion(.success(true))
            }.resume()
        } catch {
            completion(.failure(.decoderError))
        }
    }

    func fetchImageData(from string: String?) -> Data? {
        guard let string = string, let url = URL(string: string),
              let imageData = try? Data(contentsOf: url)  else { return nil }
        return imageData
    }
}
