import Foundation
import os

struct BookRepository {
    private var bookStorage: [UUID:Book] = [:]
}

extension BookRepository {
    private func contains(lookForId bookId: UUID) -> Bool {
        if let _ = bookStorage[bookId] {
            logger.info("Book with id = \(bookId) was successfully found")
            return true
        }
        logger.info("Book with id = \(bookId) was NOT successfully found")
        return false
    }
}

extension BookRepository: BookRepositoryProtocol {
    func findById(bookId: UUID) -> Book? {
        return self.bookStorage[bookId]
    }
    
    mutating func addNewBook(book: Book) -> Bool {
        if (contains(lookForId: book.id)) {
            logger.info("Book: \(book.title) with id = \(book.id) was already added")
            return false
        }
        bookStorage[book.id] = book
        return true
    }
    
    mutating func deleteBook(bookId: UUID) -> Bool {
        // мб так было бы лучше
        // return books.removeValue(forKey: book.id) != nil
        
        if (!contains(lookForId: bookId)) {
            logger.info("Book with id = \(bookId) is missing")
            return false
        }
        bookStorage.removeValue(forKey: bookId)
        logger.info("Book with id = \(bookId) deleted")
        return true
    }
    
    func booksList() -> [Book] {
        return Array(bookStorage.values)
    }
    
    func findAll(condition: (Book) -> Bool) -> [Book] {
        return bookStorage.values.filter(condition)
    }
}
