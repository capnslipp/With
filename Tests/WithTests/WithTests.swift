import XCTest
@testable import With



final class WithTests : XCTestCase
{
	func testExample()
	{
		let stringValue: String = ""
		
		do {
			let result1 = with(stringValue){
				$0.append("1")
			}
			XCTAssertEqual(stringValue, "")
			XCTAssertEqual(result1, "1")
		}
		
		do {
			let result2 = withMap(stringValue){
				$0.append("2")
				return [ $0 ]
			}
			XCTAssertEqual(stringValue, "")
			XCTAssertEqual(result2, [ "2" ])
		}
		
		
		let stringObject: NSMutableString = ""
		
		do {
			let result5 = with(stringObject){
				$0.append("5")
			}
			XCTAssertEqual(stringObject, "5")
			XCTAssertEqual(result5, "5")
		}
		
		do {
			let result6 = withMap(stringObject){
				$0.append("6")
				return [ $0 ]
			}
			XCTAssertEqual(stringObject, "56")
			XCTAssertEqual(result6, [ "56" ])
		}
	}

	static var allTests = [
		("testExample", testExample),
	]
}
