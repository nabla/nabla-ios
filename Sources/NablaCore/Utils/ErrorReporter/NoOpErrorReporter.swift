final class NoOpErrorReporter: ErrorReporter {
    func enable(dsn _: String, env _: String, sdkVersion _: String) { /* no-op */ }

    func disable() { /* no-op */ }

    func reportWarning(message _: String, error _: Error?, extra _: [String: Any]) { /* no-op */ }
    
    func reportError(message _: String, error _: Error?, extra _: [String: Any]) { /* no-op */ }

    func reportEvent(message _: String, extra _: [String: Any]) { /* no-op */ }

    func log(message _: String, extra _: [String: Any]?, domain _: String?) { /* no-op */ }
    
    func setTag(name _: String, value _: String) { /* no-op */ }
    
    func setExtra(name _: String, value _: String) { /* no-op */ }
}
