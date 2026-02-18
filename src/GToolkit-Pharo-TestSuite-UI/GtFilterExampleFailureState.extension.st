Extension { #name : #GtFilterExampleFailureState }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtFilterExampleFailureState >> color [
	^ BrGlamorousColors failureBackgroundColor
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtFilterExampleFailureState >> geometry [
	^ BlTriangleGeometry new beTop
]
