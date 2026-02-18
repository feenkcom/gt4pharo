Extension { #name : #GtPharoMethodTestCaseFailureState }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoMethodTestCaseFailureState class >> color [
	^ BrGlamorousColors failureBackgroundColor
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoMethodTestCaseFailureState class >> geometry [
	^ BlTriangleGeometry new beTop
]
