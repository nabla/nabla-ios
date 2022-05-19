// sourcery: AutoMockable
public protocol Logger {
    func info(message: @autoclosure () -> String)
    func warning(message: @autoclosure () -> String)
    func error(message: @autoclosure () -> String)
}
