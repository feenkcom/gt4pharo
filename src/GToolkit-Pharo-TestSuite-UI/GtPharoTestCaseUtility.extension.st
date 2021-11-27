Extension { #name : #GtPharoTestCaseUtility }

{ #category : #'*GToolkit-Pharo-TestSuite-UI' }
GtPharoTestCaseUtility class >> newColoredIcon: aColor [

	^ BlElement new
		  background: aColor;
		  geometry: BlSquare new;
		  margin: (BlInsets all: 1);
		  size: 8 @ 8
]
