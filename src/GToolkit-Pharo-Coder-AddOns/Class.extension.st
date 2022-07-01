Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Class >> gtClassVariableCase: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 30;
		description: [ :each | (each , ' should start with an uppercase letter') asRopedText ];
		compute: [ self classVarNames select: [ :each | each first isLowercase ] ];
		action: [ :each | 
			(self classVarNames includes: each)
				ifTrue: [ GtRenameClassVariableAdviceAction
						rename: each
						to: each first asUppercase asString , each allButFirst
						in: self ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Class >> gtIsReferenced [
	| methodBlock |
	(self subclasses isEmpty
		and: [ (GtPharoCompletionStrategy globalVariableReferencesTo: self binding) isEmpty ])
		ifFalse: [ ^ true ].
	self
		withAllSuperclassesDo: [ :each | (#(BaselineOf SharedPool TestCase) includes: each name) ifTrue: [ ^ true ] ].
	methodBlock := [ :each | 
		each
			pragmasDo: [ :pragma | (#(gtExample example) includes: pragma selector) ifTrue: [ ^ true ] ] ].
	self methodsDo: methodBlock.
	self class methodsDo: methodBlock.
	^ false
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Class >> gtNotReferenced: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice item
		priority: 10;
		description: [ :class | (class name asString , ' is not referenced') asRopedText ];
		compute: [ self gtIsReferenced ifFalse: [ self ] ];
		action: [ :class | class isObsolete ifFalse: [ GtRemoveClassAdviceAction remove: class ] ]
]
