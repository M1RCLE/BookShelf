import Foundation

protocol TextbookRepositoryProtocol {
    mutating func addNewTextbook(textBook: TextBook) -> Bool
    mutating func deleteTextbook(textBookId: UUID) -> Bool
    func textbooksList() -> [TextBook]
    func findAll(condition: (_ book: TextBook) -> Bool) -> [TextBook]
    func filterByCourseNumber(courseNumber: Int32) -> [TextBook]
}
