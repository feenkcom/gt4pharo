Class {
	#name : #GtPharoTestCaseUtility,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-AddOns-Test Case'
}

{ #category : #'api - testing' }
GtPharoTestCaseUtility class >> hasConcreteSubclasses: aClass [

	aClass allSubclassesDo: [ :eachClass | 
		eachClass isAbstract ifFalse: [ ^ true ] ].

	^ false
]

{ #category : #'api - instance creation' }
GtPharoTestCaseUtility class >> newColoredIcon: aColor [

	^ BlElement new
		  background: aColor;
		  geometry: BlSquare new;
		  margin: (BlInsets all: 1);
		  size: 8 @ 8
]
