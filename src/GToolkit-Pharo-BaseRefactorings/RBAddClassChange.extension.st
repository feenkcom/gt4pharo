Extension { #name : #RBAddClassChange }

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBAddClassChange class >> definitionBlockFrom: aString [
	^ [ :builder | 
	| ast |
	ast := RBParser parseExpression: aString.
	ast
		nodesDo: [ :node | 
			node isMessage
				ifTrue: [ node keywords
						with: node arguments
						do: [ :key :arg | 
							(#(subclass: variableByteSubclass: variableSubclass: variableWordSubclass: weakSubclass: #'<<')
								includes: key)
								ifTrue: [ builder superclass: (Smalltalk at: node receiver name asSymbol).
									builder name: arg value.
									key = 'variableByteSubclass:'
										ifTrue: [ builder layoutClass: ByteLayout ].
									key = 'variableSubclass:'
										ifTrue: [ builder layoutClass: VariableLayout ].
									key = 'variableWordSubclass:'
										ifTrue: [ builder layoutClass: WordLayout ].
									key = 'weakSubclass:' ifTrue: [ builder layoutClass: WeakLayout ] ].
							key = 'instanceVariableNames:'
								ifTrue: [ builder slotsFromString: arg value ].
							key = 'classVariables:'
								ifTrue: [ builder sharedVariables: (self evaluateNode: arg) ].
							key = 'classVariableNames:'
								ifTrue: [ builder sharedVariablesFromString: arg value ].
							key = 'sharedPools:'
								ifTrue: [ builder sharedPoolsFromString: (self evaluateNode: arg) ].
							key = 'sharedVariables:'
								ifTrue: [ builder sharedVariables: (self evaluateNode: arg) ].
							key = 'poolDictionaries:'
								ifTrue: [ builder sharedPoolsFromString: arg value ].
							key = 'package:' ifTrue: [ builder package: arg value ].
							key = 'category:' ifTrue: [ builder category: arg value ].
							key = 'slots:' ifTrue: [ builder slots: (self evaluateNode: arg) ].
							key = 'uses:'
								ifTrue: [ builder traitComposition: (self evaluateNode: arg) ] ] ] ] ]
]

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBAddClassChange class >> definitionString: aString [
	^ self
		forPharo12: [ self make: (self definitionBlockFrom: aString) ]
		forPharo11AndPharo10: [ self definition: aString ]
]

{ #category : #'*GToolkit-Pharo-BaseRefactorings' }
RBAddClassChange class >> evaluateNode: aNode [
	^ self evaluate: aNode sourceCode
]
