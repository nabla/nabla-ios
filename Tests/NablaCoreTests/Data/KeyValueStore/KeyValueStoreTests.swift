@testable import NablaCore
import XCTest

final class KeyValueStoreTests: XCTestCase {
    var sut: KeyValueStoreImpl!
    
    override func setUp() {
        sut = KeyValueStoreImpl(namespace: "KeyValueStoreTests")
    }
    
    func testSetAndGetCustomStruct() throws {
        // GIVEN
        let object = SomeCodableStruct(string: "Hello world!", int: 42)
        
        // WHEN
        try sut.set(object, forKey: "key")
        let result: SomeCodableStruct? = try sut.get(forKey: "key")
        
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.string, "Hello world!")
        XCTAssertEqual(result?.int, 42)
    }
    
    func testSetAndGetString() throws {
        // GIVEN
        // WHEN
        try sut.set("Hello world!", forKey: "key")
        let result: String? = try sut.get(forKey: "key")
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result, "Hello world!")
    }
    
    func testSetAndGetInt() throws {
        // GIVEN
        // WHEN
        try sut.set(42, forKey: "key")
        let result: Int? = try sut.get(forKey: "key")
        // THEN
        XCTAssertNotNil(result)
        XCTAssertEqual(result, 42)
    }
    
    func testClearRemovesAllValues() throws {
        // GIVEN
        try sut.set("Hello world!", forKey: "string")
        try sut.set(42, forKey: "int")
        // WHEN
        sut.clear()
        let string: String? = try sut.get(forKey: "string")
        let int: Int? = try sut.get(forKey: "int")
        // THEN
        XCTAssertNil(string)
        XCTAssertNil(int)
    }
    
    func testClearDoesNotAffectOtherUserDefaults() {
        // GIVEN
        let other = UserDefaults.standard
        other.set(42, forKey: "int")
        // WHEN
        sut.clear()
        let int = other.integer(forKey: "int")
        // THEN
        XCTAssertNotNil(int)
        XCTAssertEqual(int, 42)
    }
}

struct SomeCodableStruct: Codable {
    let string: String
    let int: Int
}
