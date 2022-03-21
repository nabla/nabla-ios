import NablaUtils

public struct NablaCore {
    // MARK: - Public

    public var text: String {
        "Hello, World!" + "\n" + utils.text
    }

    public init() {}

    // MARK: - Internal

    @Inject var utils: NablaUtils
}
