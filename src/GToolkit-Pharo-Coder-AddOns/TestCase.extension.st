Extension { #name : #TestCase }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
TestCase >> gtCompiledMethod [

	| aClass |
	aClass := self class whichClassIncludesTestSelector: self selector.
	aClass ifNil: [ ^ nil ].
	^ aClass >> self selector
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
TestCase class >> gtTestCaseMethods [

	^ GtSearchClassTestSuiteFilter new testCaseClass: self
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
TestCase >> testCasesDo: aBlock [

	aBlock cull: self
]
