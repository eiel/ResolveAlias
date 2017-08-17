import XCTest

class ResolveAliasTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testResolveAliasPath() {
        let file_name = "sample.txt"
        let alias_name = "sample.txt alias"
        let url = URL.init(fileURLWithPath: #file)
        let basedir = url.deletingLastPathComponent()
        let resource_dir = basedir.appendingPathComponent("resources", isDirectory: true)
        let alias_url = resource_dir.appendingPathComponent(alias_name)
        let file_url = resource_dir.appendingPathComponent(file_name)
        do {
            let path = try resolveFinderAlias(alias_url)
            XCTAssert(path == file_url.path)
        } catch {
            XCTFail()
        }
    }
}
