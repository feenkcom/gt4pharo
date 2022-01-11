Extension { #name : #GtPharoSourceCoder }

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseBehaviorAt: aTextPosition [
	"Try to find a behavior reference at a given source text position and request to browse it"

	self
		detectBehaviorAt: aTextPosition
		ifFound: [ :aBehavior |
			self
				notifyToolSpawn: (GtClassCoderTool observedClass: aBehavior)
				withDestination: self spawnDestination  ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseBehaviorIn: aSourceString [
	"Try to find a behavior reference within a given source code and request to browse it"

	self
		detectBehaviorIn: aSourceString
		ifFound: [ :aBehavior |
			self
				notifyToolSpawn: (GtClassCoderTool observedClass: aBehavior)
				withDestination: self spawnDestination  ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseImplementorsAt: aTextPosition [
	"Try to find a message selector at a given source text position and request to browse it"

	self
		detectSelectorAt: aTextPosition
		ifFound: [ :aSelector | self notifyObjectSpawn: (GtSearchImplementorsFilter selector: aSelector)  ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseImplementorsIn: aSourceString [
	"Try to find a message selector within a given source string and request to browse it"

	self
		detectSelectorIn: aSourceString
		ifFound: [ :aSelector | self notifyObjectSpawn: (GtSearchImplementorsFilter selector: aSelector) ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseReferencesAt: aTextPosition [
	"Try to create a references filter for an entity at the given text position and request to browse it"

	self notifyObjectSpawn: (self
		detectReferencesFilterAt: aTextPosition
		ifFound: [ :aReferencesFilter | aReferencesFilter ]
		ifNone: [ GtSearchNullFilter new ])
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> browseReferencesIn: aSourceString [
	"Try to create a references filter for an entity within a given source string and request to browse it"

	self notifyObjectSpawn: (self
		detectReferencesFilterIn: aSourceString
		ifFound: [ :aReferencesFilter | aReferencesFilter ]
		ifNone: [ GtSearchNullFilter new ])
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> colorAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoColorStyler new.
	coderAddOns addStyler: GtPharoGlamorousColorStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> createLabel: aString description: description [
	^ aString asRopedText
		,
			((' ' , description) asRopedText
				attributes:
					{(BlFontSizeAttribute size: 12).
					(BlTextForegroundAttribute paint: Color gray)})
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> extractableNodesFrom: aCoderViewModel [
	| allSelections allCursors |

	allSelections := aCoderViewModel selection allSelections.
	allCursors := aCoderViewModel cursors allCursors.

	^ allSelections size = 1
		ifTrue: [ self extractableNodesWithin: allSelections first interval ]
		ifFalse: [ allCursors size = 1
			ifTrue: [ self extractableNodesAt: allCursors first position ]
			ifFalse: [ #() ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> glamorousIconsAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoGlamorousIconStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> haltAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 20>
	coderAddOns addStyler: GtPharoHaltStyler new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> highlightNodeBlock: aNode [
	^ [ :textualCoderViewModel | 
	  textualCoderViewModel
		  addTextAttribute: self class nodeHighlight
		  from: aNode startPosition
		  to: aNode stopPosition ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.

	addOns addStyler: GtPharoStyler new.
	addOns addStyler: GtPharoDynamicHighlightStyler new.
	addOns addStyler: GtPharoDeprecationStyler new.
	addOns addStyler: GtPharoMethodExpanderStyler new.
	addOns addStyler: GtPharoClassExpanderStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> initializeShortcuts: addOns [
	super initializeShortcuts: addOns.

	addOns
		addShortcut: GtSourceCoderBrowseImplementorsShortcut new;
		addShortcut: GtSourceCoderBrowseReferencesShortcut new;
		addShortcut: GtSourceCoderBrowseBehaviorShortcut new;
		addShortcut: GtSourceCoderDiscardChangesShortcut new
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> isLocalVariable: aNode [
	^ aNode isLocallyDefined
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder class >> nodeHighlight [
	^ NodeHighlight
		ifNil: [ NodeHighlight := BlTextHighlightAttribute new
				paint: BrGlamorousColors textHighlightColor ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> nonBreakableSpaceAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoNonBreakableSpaceStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> passwordAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoMethodPasswordStyler new.
	coderAddOns addStyler: GtPharoZincApplicationFormUrlEncodedEntityStyler new.
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> removeHighlightBlock [
	^ [ :textualCoderViewModel | 
	  textualCoderViewModel removeAttribute: self class nodeHighlight ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> removeRefactoringAttribute [
	self sourceText
		clearAttributes: [ :each | each class = GtRefactoringChangesAttribute ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameAt: aTextPosition in: aSourceCoderViewModel [
	self
		nodeAt: aTextPosition
		ifFound: [ :aNode | self renameNode: aNode in: aSourceCoderViewModel ]
		ifNone: [  ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameClassIn: aSourceCoderViewModel node: aVariableNode [
	(GtRenameClassController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameClassVariableIn: aSourceCoderViewModel node: aVariableNode [
	(GtRenameClassVariableController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameInstanceVariableIn: aSourceCoderViewModel node: aVariableNode [
	(GtRenameInstanceVariableController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aVariableNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameMethod: aSourceCoderViewModel node: aMessageOrMethodOrMethodPatternNode [
	(GtRenameMethodController new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aMessageOrMethodOrMethodPatternNode) execute
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameNode: aNode in: aSourceCoderViewModel [
	(aNode isMessage or: [ aNode isMethod or: [ aNode isMethodPattern ] ])
		ifTrue: [ ^ self renameMethod: aSourceCoderViewModel node: aNode ].
	aNode isVariable
		ifTrue:
			[ (self isLocalVariable: aNode) ifTrue: [ ^ self renameTemporaryIn: aSourceCoderViewModel node: aNode ].
			(self behavior allInstVarNames includes: aNode name value)
				ifTrue: [ ^ self renameInstanceVariableIn: aSourceCoderViewModel node: aNode ].
			(self behavior classVariables anySatisfy: [ :assoc | assoc key asString = aNode name value ])
				ifTrue: [ ^ self renameClassVariableIn: aSourceCoderViewModel node: aNode ].
			Smalltalk globals
				at: aNode name value asSymbol
				ifPresent: [ :cls | (cls isKindOf: Class) ifTrue: [ ^ self renameClassIn: aSourceCoderViewModel node: aNode ] ] ]
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> renameTemporaryIn: aSourceCoderViewModel node: aVariableNode [
	| action locations announcement definer otherCoders renameAttributes originalSource |
	originalSource := (aSourceCoderViewModel styledText ifNil: [ aSourceCoderViewModel sourceText ])
		from: aVariableNode startPosition
		to: aVariableNode stopPosition.
	locations := OrderedCollection new.
	definer := aVariableNode whoDefines.
	announcement := GtCoderRenameTemporaryRequestedAnnouncement new.
	definer isNil
		ifTrue:
			[ announcement variableName: aVariableNode name source.
			self announce: announcement ].
	otherCoders := announcement interestedCoders reject: [ :each | each == self ].
	(definer ifNil: [ aVariableNode topParent ])
		withAllNodesDo: [ :each | each = aVariableNode ifTrue: [ locations add: each sourceInterval ] ].
	action := GtRenameAction2 locations: locations textualCoderViewModel: aSourceCoderViewModel.
	action selectAll: true.
	action forVariableOrUnaryMessage.
	renameAttributes := OrderedCollection new.
	otherCoders
		do:
			[ :each | 
			each
				implicitVariableReferencesTo: aVariableNode variableName
				do:
					[ :node | 
					| attribute |
					attribute := GtRenamePreviewAttribute new text: originalSource.
					(each currentSourceText from: node startPosition to: node stopPosition) attributes: {attribute}.
					renameAttributes add: attribute ].
			each sourceChangedTo: each currentSourceText ].
	action
		when: GtRenameActionAnnouncement
		do:
			[ :ann | 
			ann eventType = #textUpdated
				ifTrue: [ renameAttributes do: [ :each | each updateText: ann renameAction newName asRopedText ] ].
			ann eventType = #uninstall
				ifTrue:
					[ otherCoders
						do:
							[ :each | 
							each currentSourceText clearAttributes: [ :attr | attr isKindOf: GtRenamePreviewAttribute ].
							each sourceChangedTo: each currentSourceText ] ].
			ann eventType = #accept
				ifTrue: [ otherCoders do: [ :each | each renameImplicitTemporary: aVariableNode variableName to: action newName ] ] ].
	action install.
	^ action
]

{ #category : #'*GToolkit-Pharo-Coder-AddOns' }
GtPharoSourceCoder >> whenSendToAddOnFor: anAST into: coderAddOns [
	<gtAstCoderAddOns: 100>
	coderAddOns addStyler: GtPharoWhenSendToExpanderStyler new.
]
