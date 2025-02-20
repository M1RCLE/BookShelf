import Foundation

enum BookShelfError: Error {
    case bookNotFound
    case invalidID
    case invalidInput
    case invalidBookGenre
    case invalidTextBookGenre
    case comicNotFound
    case textBookNotFound
    case repositoryError(String)
    
    var localizedDescription: String {
        switch self {
        case .bookNotFound:
            return "Error: The requested book was not found."
        case .invalidID:
            return "Error: The provided ID is invalid."
        case .invalidInput:
            return "Error: Invalid input. Please try again."
        case .repositoryError(let message):
            return "Repository Error: \(message)"
        case .invalidBookGenre:
            return "Error: Invalid bood genre. Please try again."
        case .comicNotFound:
            return "Error: Comic was not found. Please try again"
        case .textBookNotFound:
            return "Error: Textbook was not found. Please try again"
        case .invalidTextBookGenre:
            return "Error: Textbook genre was not found. Please try again"
        }
    }
}

class BookShelfController {
    private var bookRepository: BookRepositoryProtocol
    private var comicRepository: ComicRepositoryProtocol
    private var textbookRepository: TextbookRepositoryProtocol
    
    init() {
        self.bookRepository = BookRepository()
        self.comicRepository = ComicRepository()
        self.textbookRepository = TextbookRepository()
    }
    
    init(bookRepository: BookRepositoryProtocol,
         comicRepository: ComicRepositoryProtocol,
         textbookRepository: TextbookRepositoryProtocol) {
        self.bookRepository = bookRepository
        self.comicRepository = comicRepository
        self.textbookRepository = textbookRepository
    }
    
    
}

// Starter extension
extension BookShelfController {
    func start() {
        while true {
            print("\nLibrary Management System")
            print("1. Add a Book")
            print("2. Delete a Book")
            print("3. View All Books")
            print("4. Search Books")
            print("5. Add a Comic")
            print("6. Delete a Comic")
            print("7. View All Comics")
            print("8. Search Comic")
            print("9. Add a Textbook")
            print("10. Delete a Textbook")
            print("11. View All Textbook")
            print("12. Search Textbook")
            print("13. Filter by Textbook course number")
            print("14. Exit")
            print("Choose an option: ", terminator: "")
            
            if let choice = readLine(), let option = Int(choice) {
                do {
                    switch option {
                    case 1:
                        try addBook()
                    case 2:
                        try deleteBook()
                    case 3:
                        try listBooks()
                    case 4:
                        try searchBooks()
                    case 5:
                        try addComic()
                    case 6:
                        try deleteComic()
                    case 7:
                        try listComics()
                    case 8:
                        try searchComics()
                    case 9:
                        try addTextBook()
                    case 10:
                        try deleteTextBook()
                    case 11:
                        try listTextBooks()
                    case 12:
                        try searchTextBooks()
                    case 13:
                        try filterByCourseYear()
                    case 14:
                        print("Exiting the Library System...")
                        return
                    default:
                        print("Invalid option. Please choose again.")
                    }
                } catch let error as BookShelfError {
                    print(error.localizedDescription)
                } catch {
                    print("An unexpected error occurred: \(error)")
                }
            }
        }
    }
}


// Book repository control flow extension
extension BookShelfController {
    private func addBook() throws {
        print("Enter Book Title: ", terminator: "")
        guard let title = readLine(), !title.isEmpty else {
            throw BookShelfError.invalidInput
        }
        
        print("Enter Author Name: ", terminator: "")
        guard let author = readLine(), !author.isEmpty else {
            throw BookShelfError.invalidInput
        }
        
        print("Enter Publication Year (or press Enter to skip): ", terminator: "")
        let publicationYear = Int32(readLine() ?? "") ?? -1  // -1 means no year provided
        
        print("Enter Genre (fiction, nonFiction, mystery, sciFi, biography): ", terminator: "")
        guard let genreInput = readLine(), let genre = try? BookGenre(rawValue: genreInput) else {
            throw BookShelfError.invalidInput
        }
        
        let newBook = Book(_title: title, _author: author, _publicationYear: publicationYear, _genre: genre)
        
        if bookRepository.addNewBook(book: newBook) {
            print("✅ Book added successfully!")
        } else {
            throw BookShelfError.repositoryError("Failed to add the book.")
        }
    }
    
    private func deleteBook() throws {
        print("Enter Book ID to delete: ", terminator: "")
        guard let idInput = readLine(), let bookID = UUID(uuidString: idInput) else {
            throw BookShelfError.invalidID
        }
        
        if bookRepository.deleteBook(bookId: bookID) {
            print("✅ Book deleted successfully!")
        } else {
            throw BookShelfError.repositoryError("Could not delete the book.")
        }
    }
    
    private func listBooks() throws {
        let books = bookRepository.booksList()
        if books.isEmpty {
            print("ℹ️ No books available.")
        } else {
            for book in books {
                print("📖 \(book.title) by \(book.author) year: \(book.publicationYear == -1 ? "Unknown" : String(book.publicationYear)) [\(book.id)]")
            }
        }
    }
    
    private func searchBooks() throws {
        print("Search by: 1. Title  2. Author  3. Genre")
        guard let choice = readLine(), let option = Int(choice) else {
            throw BookShelfError.invalidInput
        }
        
        switch option {
        case 1:
            print("Enter title keyword: ", terminator: "")
            let keyword = readLine() ?? ""
            let results = bookRepository.findAll { $0.title.lowercased().contains(keyword.lowercased()) }
            try printSearchResults(results)
            
        case 2:
            print("Enter author name: ", terminator: "")
            let author = readLine() ?? ""
            let results = bookRepository.findAll { $0.author.lowercased().contains(author.lowercased()) }
            try printSearchResults(results)
            
        case 3:
            print("Enter genre (fiction, nonFiction, mystery, sciFi, biography): ", terminator: "")
            if let genreInput = readLine() {
                let genre = try BookGenre(rawValue: genreInput)
                let results = bookRepository.findAll { $0.genre == genre }
                try printSearchResults(results)
            } else {
                throw BookShelfError.invalidInput
            }
            
        default:
            throw BookShelfError.invalidInput
        }
    }
    
    private func printSearchResults(_ books: [Book]) throws {
        if books.isEmpty {
            throw BookShelfError.bookNotFound
        } else {
            for book in books {
                print("📖 \(book.title) by \(book.author) [\(book.id)]")
            }
        }
    }
}

// Comic extension
extension BookShelfController {
    private func addComic() throws {
        print("Enter Comic Title: ", terminator: "")
        guard let title = readLine(), !title.isEmpty else {
            throw BookShelfError.invalidInput
        }
        
        print("Enter Author Name: ", terminator: "")
        guard let author = readLine(), !author.isEmpty else {
            throw BookShelfError.invalidInput
        }
        
        print("Enter Issue Number: ", terminator: "")
        guard let issueNumberInput = readLine(), let issueNumber = Int32(issueNumberInput) else {
            throw BookShelfError.invalidInput
        }
        
        print("Enter Publication Year (or press Enter to skip): ", terminator: "")
        let publicationYear = Int32(readLine() ?? "") ?? -1 // -1 means no year provided
        
        let newComic = Comic(_title: title, _author: author, _publicationYear: publicationYear, _issueNumber: issueNumber)
        
        if comicRepository.addNewComic(comic: newComic) {
            print("✅ Comic added successfully!")
        } else {
            throw BookShelfError.repositoryError("Failed to add the comic.")
        }
    }
    
    private func deleteComic() throws {
        print("Enter Comic ID to delete: ", terminator: "")
        guard let idInput = readLine(), let comicID = UUID(uuidString: idInput) else {
            throw BookShelfError.invalidID
        }
        
        if comicRepository.deleteComic(comicId: comicID) {
            print("✅ Comic deleted successfully!")
        } else {
            throw BookShelfError.repositoryError("Could not delete the comic.")
        }
    }
    
    private func listComics() throws {
        let comics = comicRepository.comicsList()
        if comics.isEmpty {
            print("ℹ️ No comics available.")
        } else {
            for comic in comics {
                print("📚 \(comic.title) by \(comic.author), Issue #\(comic.issueNumber) [\(comic.id)]")
            }
        }
    }
    
    private func searchComics() throws {
        print("Search by: 1. Title  2. Author  3. Issue Number")
        guard let choice = readLine(), let option = Int(choice) else {
            throw BookShelfError.invalidInput
        }
        
        switch option {
        case 1:
            print("Enter title keyword: ", terminator: "")
            let keyword = readLine() ?? ""
            let results = comicRepository.findAll { $0.title.lowercased().contains(keyword.lowercased()) }
            try printSearchResults(results)
        
        case 2:
            print("Enter author name: ", terminator: "")
            let author = readLine() ?? ""
            let results = comicRepository.findAll { $0.author.lowercased().contains(author.lowercased()) }
            try printSearchResults(results)
        
        case 3:
            print("Enter issue number: ", terminator: "")
            if let issueNumberInput = readLine(), let issueNumber = Int(issueNumberInput) {
                let results = comicRepository.findAll { $0.issueNumber == issueNumber }
                try printSearchResults(results)
            } else {
                throw BookShelfError.invalidInput
            }
        
        default:
            throw BookShelfError.invalidInput
        }
    }
    
    private func printSearchResults(_ comics: [Comic]) throws {
        if comics.isEmpty {
            throw BookShelfError.comicNotFound
        } else {
            for comic in comics {
                print("📚 \(comic.title) by \(comic.author), Issue #\(comic.issueNumber) [\(comic.id)]")
            }
        }
    }
}

// ectension for Testbook
extension BookShelfController {
    private func addTextBook() throws {
        print("Enter Textbook Title: ", terminator: "")
        guard let title = readLine(), !title.isEmpty else {
            throw BookShelfError.invalidInput
        }
        
        print("Enter Author Name: ", terminator: "")
        guard let author = readLine(), !author.isEmpty else {
            throw BookShelfError.invalidInput
        }
        
        print("Enter Course Number: ", terminator: "")
        guard let courseNumberInput = readLine(), let courseNumber = Int32(courseNumberInput) else {
            throw BookShelfError.invalidInput
        }
        
        print("Enter Publication Year (or press Enter to skip): ", terminator: "")
        let publicationYear = Int32(readLine() ?? "") ?? -1 // -1 means no year provided
        
        print("Enter Text Book Genre: ", terminator: "")
        guard let textBookGenreInput = readLine(), let textBookGenre = try? TextBookGenre(rawValue: textBookGenreInput) else {
            throw BookShelfError.invalidInput
        }
        
        let newTextBook = TextBook(_title: title, _author: author, _publicationYear: publicationYear, _textBookGenre: textBookGenre, _courseNumber: courseNumber)
        
        if textbookRepository.addNewTextbook(textBook: newTextBook) {
            print("✅ Textbook added successfully!")
        } else {
            throw BookShelfError.repositoryError("Failed to add the textbook.")
        }
    }
    
    private func deleteTextBook() throws {
        print("Enter Textbook ID to delete: ", terminator: "")
        guard let idInput = readLine(), let textBookID = UUID(uuidString: idInput) else {
            throw BookShelfError.invalidID
        }
        
        if textbookRepository.deleteTextbook(textBookId: textBookID) {
            print("✅ Textbook deleted successfully!")
        } else {
            throw BookShelfError.repositoryError("Could not delete the textbook.")
        }
    }
    
    private func listTextBooks() throws {
        let textBooks = textbookRepository.textbooksList()
        if textBooks.isEmpty {
            print("ℹ️ No textbooks available.")
        } else {
            for textBook in textBooks {
                print("📘 \(textBook.title) by \(textBook.author), Course #\(textBook.courseNumber) [\(textBook.id)]")
            }
        }
    }
    
    private func searchTextBooks() throws {
        print("Search by: 1. Title  2. Author  3. Course Number")
        guard let choice = readLine(), let option = Int32(choice) else {
            throw BookShelfError.invalidInput
        }
        
        switch option {
        case 1:
            print("Enter title keyword: ", terminator: "")
            let keyword = readLine() ?? ""
            let results = textbookRepository.findAll { $0.title.lowercased().contains(keyword.lowercased()) }
            try printSearchResults(results)
        
        case 2:
            print("Enter author name: ", terminator: "")
            let author = readLine() ?? ""
            let results = textbookRepository.findAll { $0.author.lowercased().contains(author.lowercased()) }
            try printSearchResults(results)
        
        case 3:
            print("Enter course number: ", terminator: "")
            if let courseNumberInput = readLine(), let courseNumber = Int(courseNumberInput) {
                let results = textbookRepository.findAll { $0.courseNumber == courseNumber }
                try printSearchResults(results)
            } else {
                throw BookShelfError.invalidInput
            }
        
        default:
            throw BookShelfError.invalidInput
        }
    }
    
    private func filterByCourseYear() throws {
        print("Enter course year for filtration: ", terminator: "")
        guard let value = readLine(), let courseNumber = Int32(value) else {
            throw BookShelfError.invalidInput
        }
        
        let result = textbookRepository.filterByCourseNumber(courseNumber: courseNumber)
        try printSearchResults(result)
    }
    
    private func printSearchResults(_ textBooks: [TextBook]) throws {
        if textBooks.isEmpty {
            throw BookShelfError.textBookNotFound
        } else {
            for textBook in textBooks {
                print("📘 \(textBook.title) by \(textBook.author), Course #\(textBook.courseNumber) [\(textBook.id)]")
            }
        }
    }
}

