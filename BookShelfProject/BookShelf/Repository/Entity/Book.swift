import Foundation

struct Book {
    private var _id: UUID = UUID.init()
    var id: UUID { get { return _id } }
    
    private var _title: String
    var title: String { get { return _title } }
    
    private var _author: String
    var author: String { get { return _author } }
    
    private var _publicationYear: Int32
    var publicationYear: Int32 { get { return _publicationYear } }
    
    private var _genre: BookGenre
    var genre: BookGenre { get { return _genre } }
    
    init(_title: String, _author: String, _publicationYear: Int32, _genre: BookGenre) {
        self._title = _title
        self._author = _author
        self._publicationYear = _publicationYear
        self._genre = _genre
        
        let id = self._id.uuidString
        logger.info("Book with id \(id) was created")
    }
}
