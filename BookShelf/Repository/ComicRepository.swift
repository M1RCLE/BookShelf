import Foundation
import os

struct ComicRepository {
    private var comicStorage: [UUID:Comic] = [:]
}

extension ComicRepository {
    private func contains(lookForId comicId: UUID) -> Bool {
        if let _ = comicStorage[comicId] {
            logger.info("Comic with id = \(comicId) was successfully found")
            return true
        }
        logger.info("Comic with id = \(comicId) was NOT successfully found")
        return false
    }
}

extension ComicRepository : ComicRepositoryProtocol {
    mutating func addNewComic(comic: Comic) -> Bool {
        if (contains(lookForId: comic.id)) {
            logger.info("Book: \(comic.title) with id = \(comic.id) was already added")
            return false
        }
        comicStorage[comic.id] = comic
        return true
    }
    
    mutating func deleteComic(comicId: UUID) -> Bool {
        // мб так было бы лучше
        // return comic.removeValue(forKey: book.id) != nil
        
        if (!contains(lookForId: comicId)) {
            logger.info("Book with id = \(comicId) is missing")
            return false
        }
        comicStorage.removeValue(forKey: comicId)
        logger.info("Book with id = \(comicId) deleted")
        return true
    }
    
    func comicsList() -> [Comic] {
        return Array(self.comicStorage.values)
    }
    
    func findAll(condition: (Comic) -> Bool) -> [Comic] {
        return comicStorage.values.filter(condition)
    }
    
    
}
