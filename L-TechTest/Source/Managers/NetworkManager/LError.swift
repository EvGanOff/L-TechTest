//
//  LError.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/8/22.
//

import Foundation

enum LError: Error {
    case unableToComplete 
    case invaliedRespons
    case invaliedData
    case invalidateAuth
    case decoderError
}

extension LError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unableToComplete:
            return NSLocalizedString("Не удается обработать ваш запрос. Пожалуйста, проверьте ваше интернет-соединение", comment: "")
        case .invaliedRespons:
            return NSLocalizedString("Неверный ответ от сервера😕. Пожалуйста, попробуйте еще раз", comment: "")
        case .invaliedData:
            return NSLocalizedString("Данные, полученные с сервера, недействительны. Пожалуйста, попробуйте еще раз", comment: "")
        case .invalidateAuth:
            return NSLocalizedString("Неправильно введен номер или пароль😕 пользователя. Пожалуйста, попробуйте еще раз", comment: "")
        case .decoderError:
            return NSLocalizedString("Не смог декодировать data", comment: "")
        }
    }
}

