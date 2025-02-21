import Foundation

protocol TextbookRepositoryProtocol {
    mutating func addNewTextbook(textBook: TextBook) -> Bool // TODO: Need to think about return type
    mutating func deleteTextbook(textBookId: UUID) -> Bool // TODO: Need to think about return type
    func textbooksList() -> [TextBook]
    func findAll(condition: (_ book: TextBook) -> Bool) -> [TextBook]
    func filterByCourseNumber(courseNumber: Int32) -> [TextBook]
}
