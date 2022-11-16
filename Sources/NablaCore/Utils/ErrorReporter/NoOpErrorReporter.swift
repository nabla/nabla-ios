final class NoOpErrorReporter: ErrorReporter {
    func enable(dsn _: String, env _: String) { /* no-op */ }

    func disable() { /* no-op */ }

    func reportError(_: Error) { /* no-op */ }

    func reportEvent(message _: String) { /* no-op */ }

    func log(message _: String, metadata _: [String: Any]?, domain _: String?) { /* no-op */ }
}
