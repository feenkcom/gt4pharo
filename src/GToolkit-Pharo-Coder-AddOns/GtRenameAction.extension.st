Extension { #name : 'GtRenameAction' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtRenameAction class >> pharoRenameLocalsOn: aTextEditorElement [
	^ [
		| editor text ast items action |
	
		editor := aTextEditorElement editor.
		editor cursors cursorsCount = 1
			ifFalse: [ ^ nil ].
		text := editor text.
		ast := GtPharoParser parseWithErrors: text asString.
		items := OrderedCollection new.
		(ast findVariableNodeAt: editor cursors first position)
			ifNotNil: [ :node | 
				node whoDefines
					ifNotNil: [ :definer | 
						definer
							withAllNodesDo: [ :each | 
								each = node
									ifTrue: [ items add: (each startPosition to: each stopPosition) ] ]
							andTokensDo: nil
							includesErrors: true ] ].
		action := self locations: items element: aTextEditorElement.
		action forVariableOrUnaryMessage.
		action install ]
			on: Error
			do: [ :ex |
				NonInteractiveTranscript stdout
					nextPutAll: ('[{1}] {2}' format: { self name . ex asString });
					cr.
				ex return: nil ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtRenameAction class >> pharoRenameSnippetLocalsOn: aTextEditorElement [
	^ [ | editor text ast items action |
	editor := aTextEditorElement editor.
	editor cursors cursorsCount = 1
		ifFalse: [ ^ nil ].
	text := editor text.
	ast := GtPharoParser
		parseWithErrors: text asString
		startingAt: GtPharoParser startingStateForMethodSequence.
	items := OrderedCollection new.
	(ast findVariableNodeAt: editor cursors first position)
		ifNotNil: [ :node | 
			| definer |
			definer := node whoDefines ifNil: [ ast ].
			definer
				withAllNodesDo: [ :each | 
					each = node
						ifTrue: [ items add: (each startPosition to: each stopPosition) ] ]
				andTokensDo: nil
				includesErrors: true ].
	action := self locations: items element: aTextEditorElement.
	action forVariableOrUnaryMessage.
	action install ]
		on: Error
		do: [ :ex | ex return: nil ]
]
