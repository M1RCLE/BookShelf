import Foundation

protocol ComicRepositoryProtocol {
    mutating func addNewComic(comic: Comic) -> Bool
    mutating func deleteComic(comicId: UUID) -> Bool
    func comicsList() -> [Comic]
    func findAll(condition: (_ comic: Comic) -> Bool) -> [Comic]
}
