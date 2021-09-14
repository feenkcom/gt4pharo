Extension { #name : 'GtPharoSourceCoder' }

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> colorAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoColorStyler new.
	coderAddOns addStyler: GtPharoGlamorousColorStyler new.
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> glamorousIconsAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoGlamorousIconStyler new.
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> haltAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 20>
	coderAddOns addStyler: GtPharoHaltStyler new
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> isLocalVariable: aNode [
	^ aNode isLocallyDefined
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameAt: aTextPosition in: anEditorElement [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | self renameNode: aNode in: anEditorElement ]
		ifNone: [  ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameClassIn: editorElement node: aVariableNode [
	(GtRenameClassController new
		coder: self;
		sourceElement: editorElement;
		originalNode: aVariableNode) execute
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameClassVariableIn: editorElement node: aVariableNode [
	(GtRenameClassVariableController new
		coder: self;
		sourceElement: editorElement;
		originalNode: aVariableNode) execute
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameInstanceVariableIn: editorElement node: aVariableNode [
	(GtRenameInstanceVariableController new
		coder: self;
		sourceElement: editorElement;
		originalNode: aVariableNode) execute
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameMethod: editorElement node: aMessageOrMethodOrMethodPatternNode [
	(GtRenameMethodController new
		coder: self;
		sourceElement: editorElement;
		originalNode: aMessageOrMethodOrMethodPatternNode) execute
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameNode: aNode in: anEditorElement [
	(aNode isMessage or: [ aNode isMethod or: [ aNode isMethodPattern ] ])
		ifTrue: [ ^ self renameMethod: anEditorElement node: aNode ].
	aNode isVariable
		ifTrue:
			[ (self isLocalVariable: aNode) ifTrue: [ ^ self renameTemporaryIn: anEditorElement node: aNode ].
			(self behavior allInstVarNames includes: aNode name value)
				ifTrue: [ ^ self renameInstanceVariableIn: anEditorElement node: aNode ].
			(self behavior classVariables anySatisfy: [ :assoc | assoc key asString = aNode name value ])
				ifTrue: [ ^ self renameClassVariableIn: anEditorElement node: aNode ].
			Smalltalk globals
				at: aNode name value asSymbol
				ifPresent: [ :cls | (cls isKindOf: Class) ifTrue: [ ^ self renameClassIn: anEditorElement node: aNode ] ] ]
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameTemporaryIn: anEditorElement node: aVariableNode [
	| action locations announcement definer |
	locations := OrderedCollection new.
	definer := aVariableNode whoDefines.
	announcement := GtCoderRenameTemporaryRequestedAnnouncement new.
	definer isNil
		ifTrue:
			[ announcement variableName: aVariableNode name source.
			self announce: announcement ].
	(definer ifNil: [ aVariableNode topParent ])
		withAllNodesDo: [ :each | each = aVariableNode ifTrue: [ locations add: each sourceInterval ] ].
	action := GtRenameAction locations: locations element: anEditorElement.
	action forVariableOrUnaryMessage.
	action
		when: GtRenameActionAnnouncement
		do:
			[ :ann | 
			ann eventType = #accept
				ifTrue:
					[ announcement interestedCoders
						do: [ :each | each ~~ self ifTrue: [ each renameImplicitTemporary: aVariableNode variableName to: action newName ] ] ] ].
	action install.
	^ action
]

{ #category : '*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> zincAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoZincStyler new.
	coderAddOns addStyler: GtPharoZincApplicationFormUrlEncodedEntityStyler new.
]
