//
//  DetailScreenWorker.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/11/22.
//

import Foundation

final class DetailScreenWorker {
    func getImage(from imageString: String?) -> Data? {
        NetworkManager.shared.fetchImageData(from: imageString)
    }
}
