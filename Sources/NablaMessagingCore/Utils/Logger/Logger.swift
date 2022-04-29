public protocol Logger {
    func warning(message: @autoclosure () -> String)
}
