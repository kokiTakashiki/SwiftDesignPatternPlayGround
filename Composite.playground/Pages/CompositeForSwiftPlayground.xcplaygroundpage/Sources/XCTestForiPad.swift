
protocol XCTestCase {
    init()
    func setUp()
    func tearDown()
    static var allTests: [(String, (Self) -> () throws -> Void)] { get }
}

extension XCTestCase {
    static func run() throws {
        let instance = self.init()
        
        for (name, closure) in allTests {
            instance.setUp()
            
            let test = closure(instance)
            try test()
            
            instance.tearDown()
        }
    }
    
    func setUp() {}
    func tearDown() {}
}
func XCTFail(
    _ reason: String? = nil, 
    testName: StaticString = #function,
    lineNumber: UInt = #line
) {
    let reason = reason.map { ", \($0)," } ?? ""
    assertionFailure("\(testName) failed\(reason) on line \(lineNumber)")
}

func XCTAssertEqual<T: Equatable>(
    _ lhs: T?,
    _ rhs: T?,
    testName: StaticString = #function,
    lineNumber: UInt = #line
) {
    guard lhs != rhs else {
        return
    }
    
    func describe(_ value: T?) -> String {
        return value.map { "\($0)" } ?? "nil"
    }
    
    // Here we pass on the test name and line number that were
    // collected at this function's call site, rather than
    // recording them from this call.
    XCTFail("\(describe(lhs)) is not equal to \(describe(rhs))",
            testName: testName,
            lineNumber: lineNumber
    )
}

final class PlaylistTests: XCTestCase {
    static var allTests: [(String, (PlaylistTests) -> () throws -> Void)] {
        return [
            ("testAddingSongs", testAddingSongs)
            //("testSerialization", testSerialization)
        ]
    }
    
    //private var playlist: Playlist!
    private var testArray = [String]()
    
    func setUp() {
        //playlist = Playlist(name: "John's coding mix")
        print("test")
    }
    
    func testAddingSongs() {
        //XCTAssertEqual(playlist.songs, [])
        XCTAssertEqual(testArray, ["abc"])
        
        //let songs = (a: Song(name: "A"), b: Song(name: "B"))
        //playlist.add(songs.a)
        //playlist.add(songs.b)
        testArray.append("a")
        testArray.append("b")
        
        //XCTAssertEqual(playlist.songs, [songs.a, songs.b])
        XCTAssertEqual(testArray, ["a",""])
    }
    
    //func testSerialization() throws {
    //playlist.add(Song(name: "A"))
    //playlist.add(Song(name: "B"))
    
    //let data = try JSONEncoder().encode(playlist)
    //let decoded = try JSONDecoder().decode(Playlist.self, from: data)
    //XCTAssertEqual(playlist, decoded)
    //}
}

//try PlaylistTests.run()
try PlaylistTests.allTests
