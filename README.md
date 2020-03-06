# With

With is a Swift micro-library that provides a `with` statement— _which is modeled after the `with` functionality found in Python, JavaScript, Visual Basic, Object Pascal, Delphi; `using` found in C#; and `also`/`let` found in Kotlin._

With provides a set of overloaded generic free functions that are useful for:

* Object or value initialization and setup in a declarative style _(think Swift UI's hierarchical style, but for anything, anywhere)_.
* Performing multiple operations on an object/value fetched via a method/property, while staying D.R.Y and without needing to create a local var _(while still avoiding invoking the method/getter repeatedly)_.
* Performing calculations with an object that only needs to live long enough to be configured and do some calc _(and you're only interested in a result value)_.

With provides a set of overloaded generic free functions `func with(_ subject: SubjectT, operations: (inout SubjectT) -> Void) -> SubjectT` that can be used on any object or value type to do stuff like this:

```swift
// initializes a value-type `hitTestOptions` dictionary  for use with
//   `SCNView`'s `hitTest(…)` with the desired options some of which have
//   changed in newer OS versions (which the standard dictionary literal syntax
//   can't cleanly do)
let hitTestOptions = with([SCNHitTestOption : Any]()) {
	$0[.boundingBoxOnly] = true
	$0[.rootNode] = _myRootNode
	if #available(iOS 11.0, tvOS 11.0, macOS 10.13, *) {
		$0[.searchMode] = SCNHitTestSearchMode.all.rawValue
	} else {
		$0[.sortResults] = true
		$0[.firstFoundOnly] = false
	}
}
```

Or like this:

```swift
// initializes the object-type `newButton` with title, sizing, styling, etc.
//   and adds the view to a superview
let newButton = with(UIButton(type: .system)) {
	$0.titleLabel!.font = .systemFont(ofSize: 13)
	$0.setTitle("My Button", for: .normal)
	$0.autoresizingMask = [ .flexibleLeftMargin, .flexibleBottomMargin ]
	$0.contentEdgeInsets = UIEdgeInsets(top: 6.5, left: 7, bottom: 6.5, right: 7)
	with($0.layer) {
		$0.borderWidth = 1.0
		$0.borderColor = UIColor.white.cgColor
		$0.cornerRadius = 5
	}
	$0.sizeToFit()
	
	rootViewController.view.addSubview($0)
}
```

With also has an alternate `func with(_ subject: SubjectT, operations: (inout SubjectT) -> ReturnT) -> SubjectT` form that can return an arbitrary value from the closure (instead of the value passed in):

```swift
// initializes a `DateFormatter`, configures it, and uses it to calculate a
//   `String` which is the only thing we want to hang onto
let dateString = with(DateFormatter()) {
	$0.dateStyle = .medium
	$0.timeStyle = .none
	$0.locale = Locale(identifier: "en_US")
	
	let currentDate = Date()
	return $0.string(from: currentDate)
}
```