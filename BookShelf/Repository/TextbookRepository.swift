import Foundation

struct TextbookRepository {
    private var textBookStorage: [UUID:TextBook] = [:]
}

extension TextbookRepository {
    private func contains(lookForId textBookId: UUID) -> Bool {
        if let _ = textBookStorage[textBookId] {
            logger.info("Textbook with id = \(textBookId) was successfully found")
            return true
        }
        logger.info("Textbook with id = \(textBookId) was NOT successfully found")
        return false
    }
}

extension TextbookRepository : TextbookRepositoryProtocol {
    mutating func addNewTextbook(textBook: TextBook) -> Bool {
        if (contains(lookForId: textBook.id)) {
            logger.info("Book: \(textBook.title) with id = \(textBook.id) was already added")
            return false
        }
        textBookStorage[textBook.id] = textBook
        return true
    }
    
    mutating func deleteTextbook(textBookId: UUID) -> Bool {
        // мб так было бы лучше
        // return comic.removeValue(forKey: book.id) != nil
        
        if (!contains(lookForId: textBookId)) {
            logger.info("Book with id = \(textBookId) is missing")
            return false
        }
        textBookStorage.removeValue(forKey: textBookId)
        logger.info("Book with id = \(textBookId) deleted")
        return true
    }
    
    func textbooksList() -> [TextBook] {
        return Array(self.textBookStorage.values)
    }
    
    func findAll(condition: (TextBook) -> Bool) -> [TextBook] {
        return textBookStorage.values.filter(condition)
    }
    
    func filterByCourseNumber(courseNumber: Int32) -> [TextBook] {
        return Array(textBookStorage.filter { $0.value.courseNumber == courseNumber }.values)
    }
    
    
}
