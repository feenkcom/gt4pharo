Extension { #name : #GtExampleState }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtExampleState >> asElement [
	^ BlElement new
		size: 16 @ 16;
		geometry: self geometry;
		background: self color
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtExampleState >> asFilterModelItem [
	^ GtFilterModelExampleResultStateItem new resultState: self
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtExampleState >> color [
	"Return a color that represents given state"
	<return: #Color>
	^ Color transparent
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtExampleState >> geometry [
	^ BlRectangleGeometry new
]
