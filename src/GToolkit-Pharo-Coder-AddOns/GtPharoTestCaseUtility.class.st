Class {
	#name : #GtPharoTestCaseUtility,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'instance creation' }
GtPharoTestCaseUtility class >> newColoredIcon: aColor [

	^ BlElement new
		  background: aColor;
		  geometry: BlSquare new;
		  margin: (BlInsets all: 1);
		  size: 8 @ 8
]
