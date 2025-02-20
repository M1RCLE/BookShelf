import Foundation

struct Comic {
    private var _id: UUID = UUID.init()
    var id: UUID { get { return _id } }
    
    private var _title: String
    var title: String { get { return _title } }
    
    private var _author: String
    var author: String { get { return _author } }
    
    private var _publicationYear: Int32
    var publicationYear: Int32 { get { return _publicationYear } }
    
    private var _issueNumber: Int32
    var issueNumber: Int32 { get { return _issueNumber } }
    
    init(_title: String, _author: String, _publicationYear: Int32, _issueNumber: Int32) {
        self._title = _title
        self._author = _author
        self._publicationYear = _publicationYear
        self._issueNumber = _issueNumber
        
        let id = self._id.uuidString
        logger.info("Cimic with id \(id) was created")
    }
}
