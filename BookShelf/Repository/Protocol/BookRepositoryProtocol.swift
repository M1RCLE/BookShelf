import Foundation

protocol BookRepositoryProtocol {
    mutating func addNewBook(book: Book) -> Bool // TODO: Need to think about return type
    mutating func deleteBook(bookId: UUID) -> Bool // TODO: Need to think about return type
    func findById(bookId: UUID) -> Book?
    func booksList() -> [Book]
    func findAll(condition: (_ book: Book) -> Bool) -> [Book]
}
