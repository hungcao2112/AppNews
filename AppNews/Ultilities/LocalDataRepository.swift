//
//  LocalDataRepository.swift
//  AppNews
//
//  Created by Hung Cao on 01/04/2021.
//

import Foundation

class LocalDataRepository {
    
    static var shared = LocalDataRepository()
    
    private var realmManager = RealmManager()
    
    private init() {}
    
    func doConfiguration() {
        realmManager.configureRealm()
    }
    
    func addArticles(_ data: [Article]) {
        realmManager.add(data, update: false)
    }
    
    func getArticales() -> [Article] {
        let result = realmManager.objects(Article.self)?.toArray(ofType: Article.self)
        return result ?? []
    }
    
    func removeOldArticleData() {
        let objects = realmManager.objects(Article.self)?.toArray(ofType: Article.self) ?? []
        if !objects.isEmpty {
            realmManager.delete(objects)
        }
    }
}

