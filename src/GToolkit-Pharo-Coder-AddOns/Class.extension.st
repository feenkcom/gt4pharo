Extension { #name : #Class }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
Class >> gtClassVariableCase: aGtAdvice [
	<gtAdvice>
	^ aGtAdvice list
		priority: 30;
		name: 'Class variable name should start with uppercase letters';
		description: [ :variables | 
			(self name asString , ' has class variable'
				, (variables size > 1 ifTrue: [ 's' ] ifFalse: [ '' ]) , ' that start'
				, (variables size = 1 ifTrue: [ 's' ] ifFalse: [ '' ])
				, ' with lowercase letters '
				, (String
						streamContents: [ :stream | 
							stream nextPutAll: '('.
							variables
								do: [ :each | stream nextPutAll: each ]
								separatedBy: [ stream nextPutAll: ', ' ].
							stream nextPutAll: ').' ])) asRopedText ];
		compute: [ self classVarNames select: [ :each | each first isLowercase ] ];
		actions: [ :variables | 
			variables
				select: [ :each | self classVarNames includes: each ]
				thenCollect: [ :each | 
					GtRenameClassVariableAdviceAction
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
		name: 'Class not referenced';
		description: [ :class | 
			(class name asString
				, ' is not referenced and has no subclasses. If it isn''t referenced using reflection (e.g., allSubclasses) then it can be removed.')
				asRopedText ];
		compute: [ self gtIsReferenced ifFalse: [ self ] ]
]
