import Foundation

protocol ComicRepositoryProtocol {
    mutating func addNewComic(comic: Comic) -> Bool // TODO: Need to think about return type
    mutating func deleteComic(comicId: UUID) -> Bool // TODO: Need to think about return type
    func comicsList() -> [Comic]
    func findAll(condition: (_ comic: Comic) -> Bool) -> [Comic]
}
