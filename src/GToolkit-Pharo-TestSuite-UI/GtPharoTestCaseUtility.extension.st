Extension { #name : #GtPharoTestCaseUtility }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoTestCaseUtility class >> newColoredIcon: aColor [

	^ BlElement new
		  background: aColor;
		  geometry: BlSquareGeometry new;
		  margin: (BlInsets all: 1);
		  size: 8 @ 8
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoTestCaseUtility class >> newColoredIconFor: aState [

	^ BlElement new
		  background: aState color;
		  border: aState border;
		  geometry: BlSquareGeometry new;
		  margin: (BlInsets all: 1);
		  size: 8 @ 8
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoTestCaseUtility class >> newColoredIconWithMargin: aColor [

	^ BlElement new
		  background: aColor;
		  geometry: BlSquareGeometry new;
		  margin: ((BlInsets all: 1) withTop: 2);
		  size: 8 @ 8
]
