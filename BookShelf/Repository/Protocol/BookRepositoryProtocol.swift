import Foundation

protocol BookRepositoryProtocol {
    mutating func addNewBook(book: Book) -> Bool
    mutating func deleteBook(bookId: UUID) -> Bool
    func findById(bookId: UUID) -> Book?
    func booksList() -> [Book]
    func findAll(condition: (_ book: Book) -> Bool) -> [Book]
}
