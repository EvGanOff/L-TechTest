//
//  URLConfiguration.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/8/22.
//

import Foundation

final class URLConfiration {
    func getMainURL() -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "dev-exam.l-tech.ru"
        urlComponents.path = "/api/v1/posts"

        return urlComponents.url?.absoluteString ?? "something was wrong"
    }

    func getMaskNumberURL() -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "dev-exam.l-tech.ru"
        urlComponents.path = "/api/v1/phone_masks"

        return urlComponents.url?.absoluteString ?? "something was wrong"
    }

    func postAuthURL() -> String {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "dev-exam.l-tech.ru"
        urlComponents.path = "/api/v1/auth"

        return urlComponents.url?.absoluteString ?? "something was wrong"
    }
}
