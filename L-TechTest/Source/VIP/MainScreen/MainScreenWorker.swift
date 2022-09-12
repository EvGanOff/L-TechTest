//
//  MainScreenWorker.swift
//  L-TechTest
//
//  Created by Евгений Ганусенко on 9/10/22.
//

import Foundation

final class MainScreenWorker {
    func fetchModels(response: @escaping ([MainModel]?) -> Void) {
        var responseModel: [MainModel]? = []
        NetworkManager.shared.getData { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let models):
                    for model in models {
                        let myModel = MainModel(mainModel: model)
                        responseModel?.append(myModel)
                    }
                    response(responseModel)
                case .failure(let error):
                    print("MainScreen worker:" + "\(error)")
                }
            }
        }        
    }
}
