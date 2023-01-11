import NablaCore
import NablaCoreTestsUtils
import SnapshotTesting
import XCTest

final class AvatarViewTests: XCTestCase {
    private let size = CGSize(width: 36, height: 36)
    private var sut: NablaViews.AvatarView!

    override func setUp() {
        super.setUp()
        sut = .init()
    }
    
    func testAvatarViewDefault() {
        // GIVEN
        // WHEN
        sut.avatar = .init(url: nil, text: nil)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
    
    func testAvatarViewInitials() {
        // GIVEN
        // WHEN
        sut.avatar = .init(url: nil, text: "JD")
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
    
    func testAvatarViewImage() {
        // GIVEN
        // WHEN
        sut.avatar = .init(url: URL.stubImage.absoluteString, text: nil)
        // THEN
        assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size))
    }
}
