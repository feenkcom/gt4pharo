Class {
	#name : #GtMethodProtocolChange,
	#superclass : #RBMethodProtocolChange,
	#category : 'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #initialization }
GtMethodProtocolChange >> selector: aSelector in: aClass classified: aProtocol [
	super
		selector: aSelector
		in: aClass
		classified: aProtocol.
	source
		ifNil: [ source := (aClass isKindOf: RBAbstractClass)
					ifTrue: [ aClass sourceCodeFor: aSelector ]
					ifFalse: [ aClass sourceCodeAt: aSelector ifAbsent: [  ] ] ]
]
