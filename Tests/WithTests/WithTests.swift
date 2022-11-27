import XCTest
@testable import With



extension String : WithDo {}
extension NSMutableString : WithDo {}


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
		
		do {
			let result3 = stringValue.withDo{
				$0.append("3")
			}
			XCTAssertEqual(stringValue, "")
			XCTAssertEqual(result3, "3")
		}
		
		do {
			let result4 = stringValue.withMap{
				$0.append("4")
				return [ $0 ]
			}
			XCTAssertEqual(stringValue, "")
			XCTAssertEqual(result4, [ "4" ])
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
		
		do {
			let result7 = stringObject.withDo{
				$0.append("7")
			}
			XCTAssertEqual(stringObject, "567")
			XCTAssertEqual(result7, "567")
		}
		
		do {
			let result8 = stringObject.withMap{
				$0.append("8")
				return [ $0 ]
			}
			XCTAssertEqual(stringObject, "5678")
			XCTAssertEqual(result8, [ "5678" ])
		}
	}

	static var allTests = [
		("testExample", testExample),
	]
}
