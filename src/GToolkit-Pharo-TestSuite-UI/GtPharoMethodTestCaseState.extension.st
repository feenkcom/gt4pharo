Extension { #name : #GtPharoMethodTestCaseState }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoMethodTestCaseState class >> asElement [
	^ BlElement new
		background: self color;
		border: self border;
		geometry: self geometry;
		size: 16 @ 16
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoMethodTestCaseState class >> border [
	^ self color
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoMethodTestCaseState class >> color [
	"Return a color that represents a given state"
	<return: #Color>
	^ Color transparent
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoMethodTestCaseState class >> geometry [
	^ BlRectangleGeometry new
]
