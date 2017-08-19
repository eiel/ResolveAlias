import XCTest

class ResolveAliasTest: XCTestCase {

    static let targetFilename = "sample.txt"
    static let aliasFilename = "sample.txt.alias"
    static let basedirURL = URL(fileURLWithPath: #file).deletingLastPathComponent()
    static let resourceDirectoryURL = basedirURL.appendingPathComponent("resources", isDirectory: true)
    static let targetURL = resourceDirectoryURL.appendingPathComponent(targetFilename)
    static let aliasURL = resourceDirectoryURL.appendingPathComponent(aliasFilename)

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation oうf each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testResolveAliasPath() {
        // create alias
        // let alias = try! ResolveAliasTest.targetURL.bookmarkData()
        // let options = NSURL.BookmarkFileCreationOptions(NSURL.BookmarkCreationOptions.suitableForBookmarkFile.rawValue)
        // try! NSURL.writeBookmarkData(alias, to: ResolveAliasTest.targetFilename, options: options)
        let path = try! resolveAliasFile(ResolveAliasTest.aliasURL)
        XCTAssert(path == ResolveAliasTest.targetURL)
    }
}
