// With
// @author: Slipp Douglas Thompson
// @license: Public Domain per The Unlicense.  See accompanying LICENSE file or <http://unlicense.org/>.



/// Define a protocol conformance to `WithDo` in your own types to gain the `.withDo{…}` method.
public protocol WithDo
{
	/// “With” on an object- or value-type subject, returning the same subject (including any mutations performed in the closure).
	@inlinable @discardableResult
	func withDo<SubjectT>(_ operations:(inout SubjectT) throws -> Void)
		rethrows -> SubjectT
		where SubjectT == Self
	
	
	/// “With” on an object- or value-type subject, returning an aribitrary return object/value from the closure (the subject is still mutated).
	@inlinable
	func withMap<SubjectT, ReturnT>(_ transform:(inout SubjectT) throws -> ReturnT)
		rethrows -> ReturnT
		where SubjectT == Self
}



public extension WithDo
{
	// MARK: Returning Subject
	
	@inlinable @discardableResult
	func withDo<SubjectT>(_ operations:(inout SubjectT) throws -> Void)
		rethrows -> SubjectT
		where SubjectT == Self
	{
		return try With.with(self, operations)
	}
	
	
	// MARK: Returning Arbitrary Value

	/// “With” on an object- or value-type subject, returning an aribitrary return object/value from the closure (the subject is still mutated).
	@inlinable
	func withMap<SubjectT, ReturnT>(_ transform:(inout SubjectT) throws -> ReturnT)
		rethrows -> ReturnT
		where SubjectT == Self
	{
		return try With.withMap(self, transform)
	}
}
