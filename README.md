# With

With is a Swift micro-library that provides a `with` statement— _which is modeled after the `with` functionality found in Python, JavaScript, Visual Basic, Object Pascal, Delphi; `using` found in C#; and `also`/`let` found in Kotlin._

With provides a set of overloaded generic free functions that are useful for:

* Object or value initialization and setup in a declarative style _(think Swift UI's hierarchical style, but for anything, anywhere)_.
* Performing multiple operations on an object/value fetched via a method/property, while staying D.R.Y and without needing to create a local var _(while still avoiding invoking the method/getter repeatedly)_.
* Performing calculations with an object/value that only needs to live long enough to be configured and do some calc _(and you're only interested in a result object/value)_.

With provides a free function `func with(_ subject: SubjectT, operations: (inout SubjectT) -> Void) -> SubjectT` that can be used on any object or value type to do stuff like this:

```swift
// initializes a value-type `hitTestOptions` dictionary  for use with
//   `SCNView`'s `hitTest(…)` with the desired options some of which have
//   changed in newer OS versions (which the standard dictionary literal syntax
//   can't cleanly do)
let hitTestOptions = with([SCNHitTestOption : Any]()) { o in
	o[.boundingBoxOnly] = true
	o[.rootNode] = _myRootNode
	if #available(iOS 11.0, tvOS 11.0, macOS 10.13, *) {
		o[.searchMode] = SCNHitTestSearchMode.all.rawValue
	} else {
		o[.sortResults] = true
		o[.firstFoundOnly] = false
	}
}
```

Or like this:

```swift
// initializes the object-type `newButton` with title, sizing, styling, etc.
//   and adds the view to a superview
let newButton = with(UIButton(type: .system)) { b in
	b.titleLabel!.font = .systemFont(ofSize: 13)
	b.setTitle("My Button", for: .normal)
	b.autoresizingMask = [ .flexibleLeftMargin, .flexibleBottomMargin ]
	b.contentEdgeInsets = UIEdgeInsets(top: 6.5, left: 7, bottom: 6.5, right: 7)
	with(b.layer) { l in
		l.borderWidth = 1.0
		l.borderColor = UIColor.white.cgColor
		l.cornerRadius = 5
	}
	b.sizeToFit()
	
	rootViewController.view.addSubview(b)
}
```

With also has an alternate `func withMap(_ subject: SubjectT, operations: (inout SubjectT) -> ReturnT) -> SubjectT` form that can return an arbitrary value from the closure (instead of the value passed in):

```swift
// initializes a `DateFormatter`, configures it, and uses it to calculate a
//   `String` which is the only thing we want to hang onto
let dateString = withMap(DateFormatter()) { f in
	f.dateStyle = .medium
	f.timeStyle = .none
	f.locale = Locale(identifier: "en_US")
	
	let currentDate = Date()
	return f.string(from: currentDate)
}
```
