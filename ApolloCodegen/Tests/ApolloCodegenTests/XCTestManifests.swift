import XCTest

#if !canImport(ObjectiveC)
    public func allTests() -> [XCTestCaseEntry] {
        [
            testCase(ApolloCodegenTests.allTests),
        ]
    }
#endif
