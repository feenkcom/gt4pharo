Extension { #name : #GtPharoTestCaseUtility }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoTestCaseUtility class >> newColoredIcon: aColor [

	^ BlElement new
		  background: aColor;
		  geometry: BlSquare new;
		  margin: (BlInsets all: 3);
		  size: 12 @ 12
]
