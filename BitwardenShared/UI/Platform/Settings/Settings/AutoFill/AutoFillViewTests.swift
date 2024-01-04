import SnapshotTesting
import XCTest

@testable import BitwardenShared

class AutoFillViewTests: BitwardenTestCase {
    var processor: MockProcessor<AutoFillState, AutoFillAction, Void>!
    var subject: AutoFillView!

    // MARK: Setup & Teardown

    override func setUp() {
        super.setUp()

        processor = MockProcessor(state: AutoFillState())
        let store = Store(processor: processor)

        subject = AutoFillView(store: store)
    }

    override func tearDown() {
        super.tearDown()

        processor = nil
        subject = nil
    }

    // MARK: Tests

    /// Tapping the app extension button dispatches the `.appExtensionTapped` action.
    func test_appExtensionButton_tap() throws {
        let button = try subject.inspect().find(button: Localizations.appExtension)
        try button.tap()
        XCTAssertEqual(processor.dispatchedActions.last, .appExtensionTapped)
    }

    // MARK: Snapshots

    /// The view renders correctly.
    func test_view_render() {
        assertSnapshot(of: subject, as: .defaultPortrait)
    }
}
