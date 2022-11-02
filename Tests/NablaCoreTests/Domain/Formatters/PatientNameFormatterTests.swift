import Foundation
import NablaCore
import XCTest

final class PatientNameFormatterTests: XCTestCase {
    func testInitialsForSingleWordDisplayName() {
        // GIVEN
        let sut = PatientNameComponentsFormatter(style: .initials)
        // WHEN
        let result = sut.string(from: .init(displayName: "John"))
        // THEN
        XCTAssertEqual(result, "J")
    }
    
    func testInitialsForTwoWordsDisplayName() {
        // GIVEN
        let sut = PatientNameComponentsFormatter(style: .initials)
        // WHEN
        let result = sut.string(from: .init(displayName: "John Smith"))
        // THEN
        XCTAssertEqual(result, "J")
    }
    
    func testInitialsForThreeWordsDisplayName() {
        // GIVEN
        let sut = PatientNameComponentsFormatter(style: .initials)
        // WHEN
        let result = sut.string(from: .init(displayName: "John Smith Second"))
        // THEN
        XCTAssertEqual(result, "J")
    }
    
    func testInitialsForLowerCasedDisplayName() {
        // GIVEN
        let sut = PatientNameComponentsFormatter(style: .initials)
        // WHEN
        let result = sut.string(from: .init(displayName: "john smith second"))
        // THEN
        XCTAssertEqual(result, "J")
    }
    
    func testFullnameForSingleWordDisplayName() {
        // GIVEN
        let sut = PatientNameComponentsFormatter(style: .fullName)
        // WHEN
        let result = sut.string(from: .init(displayName: "John"))
        // THEN
        XCTAssertEqual(result, "John")
    }
    
    func testFullnameForTwoWordsDisplayName() {
        // GIVEN
        let sut = PatientNameComponentsFormatter(style: .fullName)
        // WHEN
        let result = sut.string(from: .init(displayName: "John Smith"))
        // THEN
        XCTAssertEqual(result, "John Smith")
    }
    
    func testFullnameForThreeWordsDisplayName() {
        // GIVEN
        let sut = PatientNameComponentsFormatter(style: .fullName)
        // WHEN
        let result = sut.string(from: .init(displayName: "John Smith Second"))
        // THEN
        XCTAssertEqual(result, "John Smith Second")
    }
    
    func testFullnameForLowerCasedDisplayName() {
        // GIVEN
        let sut = PatientNameComponentsFormatter(style: .fullName)
        // WHEN
        let result = sut.string(from: .init(displayName: "john smith second"))
        // THEN
        XCTAssertEqual(result, "john smith second")
    }
}
