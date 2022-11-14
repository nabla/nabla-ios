import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class GridViewTests: XCTestCase {
    private let size = CGSize(width: 320, height: 320)
    private var sut: GridView<MockView, UIColor>!
    
    override func setUp() {
        super.setUp()
        MockView.reset()
        sut = GridView<MockView, UIColor>(columns: 3) { view, _, color in
            view.backgroundColor = color
        }
    }
    
    private let colors: [UIColor] = [
        .blue,
        .red,
        .yellow,
        .cyan,
        .green,
        .purple,
        .systemPink,
        .brown,
        .magenta,
        .gray,
        .orange,
    ]

    func testGridViewIncreasingViewCount() {
        for count in 0 ... 20 {
            // GIVEN
            // WHEN
            sut.items = (0 ... count).map { colors[$0 % colors.count] }
            // THEN
            assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size), testName: "\(#function).\(count)")
        }
        
        // Always allocates complete rows. Must be equal ot multiple of column.
        XCTAssertEqual(MockView.initCount, 21)
    }
    
    func testGridViewDecreasingViewCount() {
        for count in (0 ... 20).reversed() {
            // GIVEN
            // WHEN
            sut.items = (0 ... count).map { colors[$0 % colors.count] }
            // THEN
            assertSnapshots(matching: sut, as: .lightAndDarkImages(size: size), testName: "\(#function).\(count)")
        }
        
        // Always allocates complete rows. Must be equal ot multiple of column.
        XCTAssertEqual(MockView.initCount, 21)
    }
}

extension UIColor: Identifiable {
    public var id: String { description }
}

private final class MockView: UIView {
    private(set) static var initCount = 0
    
    static func reset() {
        initCount = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Self.initCount += 1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Self.initCount += 1
    }
}
