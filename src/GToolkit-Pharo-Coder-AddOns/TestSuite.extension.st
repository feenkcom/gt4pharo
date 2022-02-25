Extension { #name : #TestSuite }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
TestSuite >> gtAllCompiledMethods [

	| aCollection |
	aCollection := OrderedCollection new.

	self testCasesDo: [ :aTestCase | 
		aTestCase gtCompiledMethod ifNotNil: [ :aMethod | 
			(aCollection identityIncludes: aMethod) ifFalse: [ 
				aCollection add: aMethod ] ] ].

	aCollection sort: GtMethodsSortFunction new.

	^ aCollection
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
TestSuite >> testCasesDo: aBlock [

	tests ifNil: [ ^ self ].
	self tests do: [ :eachTest | eachTest testCasesDo: aBlock ]
]
