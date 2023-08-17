Class {
	#name : #GtRBAddMethodToClassNamedChange,
	#superclass : #RBAddMethodChange,
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #compiling }
GtRBAddMethodToClassNamedChange class >> compile: aString inBehaviorNamed: aBehaviorName protocol: aProtocol isMeta: isMeta [
	^ self new
		compile: aString
		inBehaviorNamed: aBehaviorName
		protocol: aProtocol
		isMeta: isMeta
]

{ #category : #compiling }
GtRBAddMethodToClassNamedChange class >> compile: aString protocol: aProtocol [
	^ self new
		compile: aString
		protocol: aProtocol
		isMeta: false
]

{ #category : #compiling }
GtRBAddMethodToClassNamedChange class >> compile: aString protocol: aProtocol isMeta: isMeta [
	^ self new
		compile: aString
		protocol: aProtocol
		isMeta: isMeta
]

{ #category : #compiling }
GtRBAddMethodToClassNamedChange >> behaviorName: aBehaviorName [
	className := aBehaviorName
]

{ #category : #compiling }
GtRBAddMethodToClassNamedChange >> compile: aString inBehaviorNamed: aBehaviorName protocol: aProtocol isMeta: isMetaClass [
	isMeta := isMetaClass.
	className := aBehaviorName.
	self protocols: aProtocol.
	source := aString.
	controller := nil
]

{ #category : #compiling }
GtRBAddMethodToClassNamedChange >> compile: aString protocol: aProtocol isMeta: isMetaClass [
	isMeta := isMetaClass.
	self protocols: aProtocol.
	source := aString.
	controller := nil
]

{ #category : #compiling }
GtRBAddMethodToClassNamedChange >> isMeta: isMetaClass [
	isMeta := isMetaClass
]
