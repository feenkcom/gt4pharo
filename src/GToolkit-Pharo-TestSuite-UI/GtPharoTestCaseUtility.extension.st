Extension { #name : #GtPharoTestCaseUtility }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoTestCaseUtility class >> newColoredIcon: aColor [

	^ BlElement new
		  background: aColor;
		  geometry: BlSquare new;
		  margin: (BlInsets all: 1);
		  size: 8 @ 8
]

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoTestCaseUtility class >> newColoredIconWithMargin: aColor [

	^ BlElement new
		  background: aColor;
		  geometry: BlSquare new;
		  margin: ((BlInsets all: 1) withTop: 2);
		  size: 8 @ 8
]
