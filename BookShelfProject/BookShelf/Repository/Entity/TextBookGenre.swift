enum TextBookGenre {
    case geomentry
    case literature
    case russian
    case english
    case algebra
    case phisics
    
    init(rawValue: String) throws {
        switch rawValue {
        case "geomentry": self = .geomentry
        case "literature": self = .literature
        case "russian": self = .russian
        case "english": self = .english
        case "algebra": self = .algebra
        case "phisics": self = .phisics
        default: throw BookShelfError.invalidTextBookGenre
        }
    }
}
