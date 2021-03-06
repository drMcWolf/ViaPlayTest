public enum Main {
    public enum Output {
        case onSectionDetails(VPSection)
    }

    enum Obtain {
        struct Request {}
        struct Response {}
        enum Error: Swift.Error {
            case defaultError
        }
    }
}
