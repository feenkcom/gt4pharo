Extension { #name : #RBMethodRefactoring }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
RBMethodRefactoring >> snippetMethodSourceFrom: source [
	| ast newSource temps written methodPattern tempsSource |
	temps := Set new.
	newSource := SmaCCString on: source.
	ast := GtPharoParser
			parse: source
			startingAt: GtPharoParser startingStateForMethodSequence.
	ast
		allNodesOfType: GtPharoVariableNode
		do: [ :each | 
			(each whoDefines isNil
				and: [ (#(self super) includes: each variableName) not
						and: [ (Smalltalk globals includesKey: each variableName) not
								and: [ (class definesInstanceVariable: each variableName) not ] ] ])
				ifTrue: [ temps add: each ] ].
	written := Set new.
	ast
		allNodesOfType: GtPharoAssignmentNode
		do: [ :each | 
			(temps includes: each variable)
				ifTrue: [ written add: each variable.
					temps remove: each variable ] ].
	methodPattern := temps isEmpty
			ifTrue: [ '__ ' ]
			ifFalse: [ String
					streamContents: [ :stream | 
						temps
							do: [ :each | 
								stream
									nextPutAll: '__: ';
									nextPutAll: each variableName;
									space ] ] ].
	newSource insert: methodPattern at: 1.
	written notEmpty
		ifTrue: [ tempsSource := String
					streamContents: [ :stream | 
						ast leftBar ifNil: [ stream nextPut: $| ].
						written
							do: [ :each | 
								stream
									space;
									nextPutAll: each variableName ].
						ast leftBar ifNil: [ stream nextPut: $| ] ].
			newSource
				insert: tempsSource
				at: (ast rightBar ifNil: [ 1 ] ifNotNil: [ :token | token startPosition ]) ].
	(ast statements notEmpty and: [ ast lastIsReturn not ])
		ifTrue: [ newSource insert: '^' at: ast statements last startPosition.
			newSource insert: ' ' at: newSource startIndex ].
	^ newSource asString
]
