Class {
	#name : #GtPharoClassesCoder,
	#superclass : #GtCodersModel,
	#category : #'GToolkit-Pharo-Coder-Coders'
}

{ #category : #accessing }
GtPharoClassesCoder >> coderForClass: aClass [
	^ self coders
		detect: [ :each | each theClass = aClass ]
		ifNone: [ | coder |
			items add: aClass.
			coder := self newCoderFor: aClass.
			coders add: coder.
			coder ]
]

{ #category : #updating }
GtPharoClassesCoder >> forPackage: aPackage [
	items := aPackage definedClasses
		asSortedCollection: [ :a :b | a name < b name ].
	self updateCoders
]

{ #category : #updating }
GtPharoClassesCoder >> forPackageTag: aPackageTag [
	items := aPackageTag classes
		asSortedCollection: [ :a :b | a name < b name ].
	self updateCoders
]

{ #category : #private }
GtPharoClassesCoder >> newCoderFor: aClass [
	| coder |
	coder := GtPharoBehaviorCoder forClass: aClass.
	^ coder
]
