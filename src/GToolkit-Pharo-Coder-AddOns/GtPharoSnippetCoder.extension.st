Extension { #name : 'GtPharoSnippetCoder' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.

	addOns addStyler: GtPharoStyler new.
	addOns addStyler: GtPharoDynamicHighlightStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoMethodExpanderStyler new.
	addOns addStyler: (GtFixItStyler new isForWorkspace: true).

	addOns
		addMainAction: 'Evaluate' translated
		icon: BrGlamorousVectorIcons play
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doIt
				coderUIModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItActionId.
	addOns
		addMainAction: 'Inspect' translated
		icon: BrGlamorousVectorIcons playinspect
		action: [ :aCoderUIModel :anElement | 
			GtCoderCodeExecutor doItAndGo
				coderUIModel: aCoderUIModel;
				element: anElement;
				execute ]
		id: GtSourceCoderDoItAndGoActionId.
	addOns
		addMainAction: 'Debug' translated
		icon: BrGlamorousVectorIcons debug
		action: [ :aCoderUIModel :anElement | aCoderUIModel debug ]
		id: GtSourceCoderDebugActionId.
	addOns
		addMainAction: 'Profile' translated
		icon: BrGlamorousVectorIcons performance
		action: [ :aCoderUIModel :anElement | aCoderUIModel profileWithMessageTally ]
		id: GtSourceCoderProfileActionId
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> isLocalVariable: aNode [
	^ aNode isLocallyDefined
		or:
			[ (self behavior allInstVarNames includes: aNode name source)
				or:
					[ (self behavior classVariables anySatisfy: [ :assoc | assoc key asString = aNode name source ])
						or: [ (Smalltalk globals includesKey: aNode name source asSymbol) not ] ] ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> renameIn: editorElement [
	GtRenameAction pharoRenameSnippetLocalsOn: editorElement
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSnippetCoder >> renameTemporaryIn: anEditorElement node: aVariableNode [
	^ GtRenameAction pharoRenameSnippetLocalsOn: anEditorElement
]
