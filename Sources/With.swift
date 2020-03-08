// With
// @author: Slipp Douglas Thompson
// @license: Public Domain per The Unlicense.  See accompanying LICENSE file or <http://unlicense.org/>.



// MARK: Returning Subject

/// “With” on an reference-type (object) subject, returning the same subject (including any mutations performed in the closure).
@inlinable @discardableResult
public func with<SubjectT>(_ subject:SubjectT, _ operations:(inout SubjectT) throws -> Void)
	rethrows -> SubjectT
{
	var subject = subject
	try operations(&subject)
	return subject
}


// MARK: Returning Arbitrary Value

/// “With” on an reference-type (object) subject, returning an aribitrary return value from the closure (the subject is still mutated).
@inlinable
public func withMap<SubjectT, ReturnT>(_ subject:SubjectT, _ transform:(inout SubjectT) throws -> ReturnT)
	rethrows -> ReturnT
{
	var subject = subject
	return try transform(&subject)
}
