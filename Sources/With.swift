// MARK: Ref-Type, Returning Subject

/// “With” on an reference-type (object) subject, returning the same subject (including any mutations performed in the closure).
/// 
/// Unfortunately, we need to use `inout` for the `operations` closure here, so that the arguments exactly match the value-type (`SubjectT:Any`) version further down— we get a _“Ambiguous use of 'with'”_ error if the `inout` isn't in there.
/// 	(I believe Swift only lets us overload a function with a distinct ref-type version and a value-type version when the arguments match exactly)
@inlinable @discardableResult
public func with<SubjectT:AnyObject>(_ subject:SubjectT, operations:(inout SubjectT) throws -> Void)
	rethrows -> SubjectT
{
	var subject = subject
	try operations(&subject)
	return subject
}


// MARK: Ref-Type, Returning Arbitrary Value

/// “With” on an reference-type (object) subject, returning an aribitrary return value from the closure (the subject is still mutated).
@inlinable
public func with<SubjectT:AnyObject, ReturnT>(_ subject:SubjectT, operations:(SubjectT) throws -> ReturnT)
	rethrows -> ReturnT
{
	return try operations(subject)
}


// MARK: Value-Type, Returning Subject

/// “With” on an value-type (struct, enum) subject, returning the same subject (technically a copy, including any mutations performed in the closure).
@inlinable
public func with<SubjectT:Any>(_ subject:SubjectT, operations:(inout SubjectT) throws -> Void)
	rethrows -> SubjectT
{
	var subject = subject
	try operations(&subject)
	return subject
}
