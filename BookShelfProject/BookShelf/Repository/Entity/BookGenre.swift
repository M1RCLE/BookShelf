enum BookGenre {
    case fiction
    case nonFiction
    case mystery
    case sciFi
    case biography
    case classical
    
    init(rawValue: String) throws {
        switch rawValue {
        case "fiction": self = .fiction
        case "nonFiction": self = .nonFiction
        case "mystery": self = .mystery
        case "sciFi": self = .sciFi
        case "biography": self = .biography
        case "classical": self = .classical
        default: throw BookShelfError.invalidBookGenre
        }
    }
}
