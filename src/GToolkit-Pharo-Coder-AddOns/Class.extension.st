Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Class >> gtClassVariableCase: aGtAdvice [
	<gtAdvice: 30>
	^ (self classVarNames select: [ :each | each first isLowercase ])
		ifEmpty: [ aGtAdvice none ]
		ifNotEmpty: [ :vars | 
			(GtClassVariableCaseAdvice on: aGtAdvice)
				behavior: self;
				variables: vars asSortedCollection;
				yourself ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Class >> gtNotReferenced: aGtAdvice [
	<gtAdvice: 10>
	| methodBlock |
	(self subclasses isEmpty
		and: [ (GtPharoCompletionStrategy globalVariableReferencesTo: self binding) isEmpty ])
		ifFalse: [ ^ aGtAdvice none ].
	self
		withAllSuperclassesDo: [ :each | 
			(#(BaselineOf SharedPool TestCase) includes: each name)
				ifTrue: [ ^ aGtAdvice none ] ].
	methodBlock := [ :each | 
		each
			pragmasDo: [ :pragma | (#(gtExample example) includes: pragma selector) ifTrue: [ ^ aGtAdvice none ] ] ].
	self methodsDo: methodBlock.
	self class methodsDo: methodBlock.
	^ (GtClassNotReferencedAdvice on: aGtAdvice)
		unreferencedClass: self;
		yourself
]
