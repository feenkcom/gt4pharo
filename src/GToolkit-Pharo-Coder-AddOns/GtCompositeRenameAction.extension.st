Extension { #name : #GtCompositeRenameAction }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtCompositeRenameAction class >> coderRenameLocalsOnPattern: aTextEditorElement source: sourceEditor [
	| action |
	action := self pharoRenameLocalsOn: aTextEditorElement.
	action isNil
		ifTrue: [ ^ nil ].
	[ | tree intervals variable |
	variable := action newName.
	intervals := OrderedCollection new.
	tree := GtPharoParser
		parseWithErrors: sourceEditor text asString
		startingAt: GtPharoParser startingStateForMethodSequence.
	tree
		withAllNodesDo: [ :node | 
			((node isKindOf: GtPharoVariableNode)
				and: [ node name source = variable and: [ node isLocallyDefined not ] ])
				ifTrue: [ intervals add: node sourceInterval ] ].
	action addLocations: intervals to: sourceEditor ]
		on: Error
		do: [ :ex | 
			action uninstall.
			^ nil ].
	^ action
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtCompositeRenameAction class >> coderRenameLocalsOnSource: aTextEditorElement pattern: patternEditor [
	^ [ | editor text ast items action patternAST parameter |
	editor := aTextEditorElement editor.
	editor cursor cursorsCount = 1
		ifFalse: [ ^ nil ].
	text := editor text.
	ast := GtPharoParser
		parseWithErrors: text asString
		startingAt: GtPharoParser startingStateForMethodSequence.
	items := OrderedCollection new.
	(ast findVariableNodeAt: editor cursor first position)
		ifNotNil: [ :node | 
			| definer |
			definer := node whoDefines.
			definer isNil
				ifTrue: [ patternAST := GtPharoParser
						parseWithErrors: patternEditor text asString
						startingAt: GtPharoParser startingStateForMethodPattern.
					parameter := patternAST variables
						detect: [ :each | each = node ]
						ifNone: [ ^ nil ].
					definer := ast ].
			definer
				withAllNodesDo: [ :each | 
					each = node
						ifTrue: [ items add: (each startPosition to: each stopPosition) ] ]
				andTokensDo: nil
				includesErrors: true ].
	action := self locations: items element: aTextEditorElement.
	parameter notNil
		ifTrue: [ action addLocations: {parameter sourceInterval} to: patternEditor ].
	action install ]
		on: Error
		do: [ :ex | ex return: nil ]
]
