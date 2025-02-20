import Foundation

struct TextBook {
    private var _id: UUID = UUID.init()
    var id: UUID { get { return _id } }
    
    private var _title: String
    var title: String { get { return _title } }
    
    private var _author: String
    var author: String { get { return _author } }
    
    private var _publicationYear: Int32
    var publicationYear: Int32 { get { return _publicationYear } }
    
    private var _textBookGenre: TextBookGenre
    var textBookGenre: TextBookGenre { get { return _textBookGenre } }
    
    private var _courseNumber: Int32
    var courseNumber: Int32 { get { return _courseNumber }}
    
    init(_title: String, _author: String, _publicationYear: Int32, _textBookGenre: TextBookGenre, _courseNumber: Int32) {
        self._title = _title
        self._author = _author
        self._publicationYear = _publicationYear
        self._textBookGenre = _textBookGenre
        self._courseNumber = _courseNumber
        
        let id = self._id.uuidString
        logger.info("Textbook with id \(id) was created")
    }
}
