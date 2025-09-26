Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Index' }
Class >> compileAllFrom: oldClass announcing: announcing [
	"Recompile all the methods in the receiver's method dictionary (not the
	subclasses). Also recompile the methods in the metaclass."

	super compileAllFrom: oldClass announcing: announcing.
	self classSide compileAllFrom: oldClass classSide announcing: announcing.
]
