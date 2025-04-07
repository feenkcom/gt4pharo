Class {
	#name : #GtPharoStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Stylers'
}

{ #category : #private }
GtPharoStyler >> collapserForParenthesesLeft: aLeftIndex right: aRightIndex [
	| theParenthesesMarker folder |
	theParenthesesMarker := BrTextInvisibleMarkerAttribute new.
	text
		attribute: theParenthesesMarker
		from: aLeftIndex + 1
		to: aRightIndex - 1.

	folder := (text attributesAt: aLeftIndex)
			detect: [ :each | each class == GtTextFolderAttribute ]
			ifNone: [ | att |
				att := GtTextFolderAttribute new beNotOverwritableByStyler.
				text
					attribute: att
					from: aLeftIndex
					to: aLeftIndex.
				att ].
	folder attribute: theParenthesesMarker
]

{ #category : #private }
GtPharoStyler >> colorAndHighlightParenthesesLeft: aLeftIndex right: aRightIndex atNestingLevel: aNestingLevel [ 
	self
		highlightParenthesesLeft: aLeftIndex
		right: aRightIndex.
	self 
		colorParenthesesLeft: aLeftIndex
		right: aRightIndex
		atNestingLevel: aNestingLevel.
	"self collapserForParenthesesLeft: aLeftIndex right: aRightIndex"
]

{ #category : #private }
GtPharoStyler >> colorParenthesesLeft: aLeftIndex right: aRightIndex atNestingLevel: aNestingLevel [ 
	| color |
	color := self parenthesesColorAt: aNestingLevel.
	(text
		from: aLeftIndex
		to: aLeftIndex)
		foreground: color.
	(text
		from: aRightIndex
		to: aRightIndex)
		foreground: color
]

{ #category : #'visiting - variables' }
GtPharoStyler >> definitionTooltipAttributeFor: aNamedVariable [
	| definer |
	definer := self coderViewModel behavior
			whichClassDefinesInstVar: aNamedVariable name value.
	definer ifNil: [ ^ BlFontWeightAttribute semiBold ].
	^ BrTextAdornmentDynamicAttribute new
		beOverlay;
		stencil: [ :aTextPiece :anEditorElement | 
			| aContainer aValueElement tooltipContent |
			aContainer := BlElement new
					clipChildren: false;
					layout: BlFrameLayout new;
					constraintsDo: [ :c | 
						c horizontal exact: aTextPiece textLength * 10.
						c vertical exact: 15 ].
			aValueElement := BlElement new
					clipChildren: true;
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical matchParent ].
			tooltipContent := [ BrLabel new
					aptitude: BrLabelAptitude;
					padding: (BlInsets all: 5);
					text: (aNamedVariable name value , ' defined in ') asRopedText
							, definer name asRopedText glamorousCodeFont;
					alignCenter ] asStencil.
			aValueElement
				addAptitude: (BrGlamorousWithExplicitTooltipAptitude content: tooltipContent).
			aContainer addChild: aValueElement ]
]

{ #category : #private }
GtPharoStyler >> highlightParenthesesLeft: aLeftIndex right: aRightIndex [
	| theParanthesesMarker cursorEnterAction cursorLeaveAction |
	
	theParanthesesMarker := BrTextInvisibleMarkerAttribute new.
	text
		attribute: theParanthesesMarker
		from: aLeftIndex + 1
		to: aRightIndex - 1.

	cursorEnterAction := [ :aTextEditor |
		aTextEditor text
			findAttribute: theParanthesesMarker
			indicesDo: [ :aParanthesesStart :aParanthesesEnd |
				aTextEditor text
					attribute: (GtPharoParenthesesHighlightAttribute paint: BrGlamorousColors neutralBackgroundColor)
					from: aParanthesesStart
					to: aParanthesesEnd ] ].

	cursorLeaveAction := [ :aTextEditor | 
		aTextEditor text
			findAttribute: theParanthesesMarker
			indicesDo: [ :aParanthesesStart :aParanthesesEnd |
				(aTextEditor text
					from: aParanthesesStart
					to: aParanthesesEnd)
						clearAttributesOfClass: GtPharoParenthesesHighlightAttribute ] ].

	(text
		from: aLeftIndex
		to: aLeftIndex)
		onCursorEnter: cursorEnterAction
		leave: cursorLeaveAction.

	(text
		from: aRightIndex - 1
		to: aRightIndex - 1)
		onCursorEnter: cursorEnterAction
		leave: cursorLeaveAction
]

{ #category : #private }
GtPharoStyler >> parenthesesColorAt: anIndex [
	| colors |
	colors := self parenthesesColors.
	^ colors at: (anIndex - 1) \\ colors size + 1
]

{ #category : #private }
GtPharoStyler >> parenthesesColors [
	| colors |
	colors := BrGlamorousColors distinctTenStrongColors allButFirst
		collect: [ :each | each twiceDarker ].
	^ colors
]

{ #category : #accessing }
GtPharoStyler >> visitArray: anArray [
	super visitArray: anArray.
	self 
		colorAndHighlightParenthesesLeft: anArray leftBrace startPosition 
		right: anArray rightBrace startPosition
		atNestingLevel: anArray nestingLevel
]

{ #category : #accessing }
GtPharoStyler >> visitArrayLiteral: anArrayLiteral [
	| color aLeftIndex aRightIndex |
	color := self parenthesesColorAt: anArrayLiteral nestingLevel.
	aLeftIndex := anArrayLiteral arrayStart startPosition.
	aRightIndex := anArrayLiteral arrayStop startPosition.
	(text from: aLeftIndex to: aLeftIndex + 1) foreground: color.
	(text from: aRightIndex to: aRightIndex) foreground: color.
	self highlightParenthesesLeft: aLeftIndex + 1 right: aRightIndex.
	super visitArrayLiteral: anArrayLiteral
]

{ #category : #visiting }
GtPharoStyler >> visitBlock: aBlock [
	super visitBlock: aBlock.

	aBlock leftBracket ifNotNil: [ :aLeftBracket | 
		aBlock rightBracket ifNotNil: [ :aRightBracket | 
			self
				colorAndHighlightParenthesesLeft: aLeftBracket startPosition
				right: aRightBracket startPosition
				atNestingLevel: aBlock nestingLevel ] ]
]

{ #category : #visiting }
GtPharoStyler >> visitBooleanLiteral: aBooleanLiteral [
	super visitBooleanLiteral: aBooleanLiteral.
	self
		attributes: { BlTextForegroundAttribute color: Color red muchDarker }
		from: aBooleanLiteral value startPosition
		to: aBooleanLiteral value stopPosition
]

{ #category : #visiting }
GtPharoStyler >> visitCharacterLiteral: aCharacterLiteral [
	super visitCharacterLiteral: aCharacterLiteral.
	self
		attributes: { BlTextForegroundAttribute color: Color red muchDarker }
		from: aCharacterLiteral value startPosition
		to: aCharacterLiteral value stopPosition
]

{ #category : #visiting }
GtPharoStyler >> visitCommentFrom: aCommentStart to: aCommentEnd [
	self
		attributes: { BlTextForegroundAttribute color: Color gray darker }
		from: aCommentStart
		to: aCommentEnd
]

{ #category : #'visiting - variables' }
GtPharoStyler >> visitDeclaredGlobalVariable: aNamedVariable [
	self visitDeclaredVariable: aNamedVariable
]

{ #category : #'visiting - variables' }
GtPharoStyler >> visitDeclaredVariable: aNamedVariable [
	| isLocallyDefined |
	isLocallyDefined := aNamedVariable allParents
			anySatisfy: [ :each | each isErrorNode not and: [ each defines: aNamedVariable name value ] ].
	isLocallyDefined
		ifTrue: [ self
				attributes: {BlTextForegroundAttribute color: Color blue muchDarker}
				from: aNamedVariable name startPosition
				to: aNamedVariable name stopPosition ]
		ifFalse: [ self
				attributes: {BlTextForegroundAttribute color: Color blue muchDarker.
						BlFontWeightAttribute semiBold.
						self definitionTooltipAttributeFor: aNamedVariable}
				from: aNamedVariable name startPosition
				to: aNamedVariable name stopPosition ]
]

{ #category : #visiting }
GtPharoStyler >> visitError: anError [
	anError smaccError acceptVisitor: self
]

{ #category : #visiting }
GtPharoStyler >> visitErrorToken: anErrorToken [
	self
		attributes: { BlTextForegroundAttribute color: Color red }
		from: anErrorToken startPosition
		to: anErrorToken stopPosition
]

{ #category : #visiting }
GtPharoStyler >> visitMethodPattern: aMethodPattern [
	super visitMethodPattern: aMethodPattern.
	aMethodPattern selectorParts do: [ :eachSelectorPart |
		self visitMethodSelectorPart: eachSelectorPart ].

	super visitMethodPattern: aMethodPattern
]

{ #category : #visiting }
GtPharoStyler >> visitMethodSelectorPart: aSmaCCToken [
	self
		attributes: { BlFontWeightAttribute bold }
		from: aSmaCCToken startPosition
		to: aSmaCCToken stopPosition
]

{ #category : #'visiting - variables' }
GtPharoStyler >> visitNamedVariable: aNamedVariable [
	| isDeclaredVariable |
	super visitNamedVariable: aNamedVariable.
	isDeclaredVariable := aNamedVariable isUndeclared not.
	isDeclaredVariable
		ifTrue: [ ^ self visitDeclaredVariable: aNamedVariable ].
	
	isDeclaredVariable := self coderViewModel hasDeclaredVariableNamed: aNamedVariable variableName.
	isDeclaredVariable
		ifTrue: [ ^ self visitDeclaredVariable: aNamedVariable ].
	
	isDeclaredVariable := self coderViewModel hasDeclaredGlobalNamed: aNamedVariable variableName.
	isDeclaredVariable
		ifTrue: [ ^ self visitDeclaredGlobalVariable: aNamedVariable ].

	self visitUndeclaredVariable: aNamedVariable
]

{ #category : #visiting }
GtPharoStyler >> visitNilLiteral: aNilLiteral [
	super visitNilLiteral: aNilLiteral.
	self
		attributes: { BlTextForegroundAttribute color: Color red muchDarker }
		from: aNilLiteral value startPosition
		to: aNilLiteral value stopPosition
]

{ #category : #visiting }
GtPharoStyler >> visitNumberLiteral: aNumberLiteral [
	super visitNumberLiteral: aNumberLiteral.
	self
		attributes: { BlTextForegroundAttribute color: Color red muchDarker }
		from: aNumberLiteral value startPosition
		to: aNumberLiteral value stopPosition
]

{ #category : #visiting }
GtPharoStyler >> visitPragma: aPragma [
	super visitPragma: aPragma.

	aPragma lessThan
		ifNotNil: [ :aSmaCCToken | self visitPragmaSelectorPart: aSmaCCToken ].	

	aPragma selectorParts do: [ :eachSelectorPart |
		self visitPragmaSelectorPart: eachSelectorPart ].		

	aPragma greaterThan
		ifNotNil: [ :aSmaCCToken | self visitPragmaSelectorPart: aSmaCCToken ].
	
	aPragma values do: [ :eachPragmaValue |
		self acceptNode: eachPragmaValue ]
]

{ #category : #visiting }
GtPharoStyler >> visitPragmaSelectorPart: aSmaCCToken [
	self
		attributes: { BlTextForegroundAttribute color: Color green muchDarker }
		from: aSmaCCToken startPosition
		to: aSmaCCToken stopPosition
]

{ #category : #visiting }
GtPharoStyler >> visitReturn: aReturn [
	super visitReturn: aReturn.

	self visitReturnUpArrow: aReturn upArrow
]

{ #category : #visiting }
GtPharoStyler >> visitReturnUpArrow: aSmaCCToken [
	self
		attributes: { BlTextForegroundAttribute color: Color cyan muchDarker }
		from: aSmaCCToken startPosition
		to: aSmaCCToken stopPosition
]

{ #category : #'visiting - variables' }
GtPharoStyler >> visitSelfVariable: aSelfVariable [
	super visitSelfVariable: aSelfVariable.
	self
		attributes: { BlTextForegroundAttribute color: Color cyan muchDarker }
		from: aSelfVariable name startPosition
		to: aSelfVariable name stopPosition
]

{ #category : #visiting }
GtPharoStyler >> visitSmaCCError: anErrorNode [
	anErrorNode
		nodesDo: [ :eachNode | self acceptNode: eachNode ]
		andTokensDo: [ :eachToken | ]
		includeErrors: true.
	anErrorNode dismissedTokens do: [ :eachToken | self visitErrorToken: eachToken ].
	anErrorNode errorToken ifNotNil: [ :eachToken | self visitErrorToken: eachToken ]
]

{ #category : #visiting }
GtPharoStyler >> visitSmaCCParseNode: aSmaCCParseNode [
	super visitSmaCCParseNode: aSmaCCParseNode.

	aSmaCCParseNode comments ifNotNil: [ :theComments |
		theComments do: [ :eachComment |
			self visitCommentFrom: eachComment first to: eachComment second ] ]
]

{ #category : #visiting }
GtPharoStyler >> visitStringLiteral: aStringLiteral [
	super visitStringLiteral: aStringLiteral.
	self
		attributes: { BlTextForegroundAttribute color: Color magenta muchDarker }
		from: aStringLiteral value startPosition
		to: aStringLiteral value stopPosition
]

{ #category : #'visiting - variables' }
GtPharoStyler >> visitSuperVariable: aSuperVariable [
	super visitSuperVariable: aSuperVariable.
	self
		attributes: { BlTextForegroundAttribute color: Color cyan muchDarker }
		from: aSuperVariable name startPosition
		to: aSuperVariable name stopPosition
]

{ #category : #visiting }
GtPharoStyler >> visitSymbolLiteral: aSymbolLiteral [
	super visitSymbolLiteral: aSymbolLiteral.
	self
		attributes: { BlTextForegroundAttribute color: Color magenta muchDarker }
		from: aSymbolLiteral value startPosition
		to: aSymbolLiteral value stopPosition
]

{ #category : #'visiting - variables' }
GtPharoStyler >> visitThisContextVariable: aThisContextVariable [
	super visitThisContextVariable: aThisContextVariable.
	self
		attributes: { BlTextForegroundAttribute color: Color cyan muchDarker }
		from: aThisContextVariable name startPosition
		to: aThisContextVariable name stopPosition
]

{ #category : #'visiting - variables' }
GtPharoStyler >> visitUndeclaredVariable: aVariableNode [
	"We do not color undeclared variables in red because we already have critics"
	self
		attributes: { BlTextForegroundAttribute color: Color blue muchDarker }
		from: aVariableNode name startPosition
		to: aVariableNode name stopPosition
]

{ #category : #accessing }
GtPharoStyler >> visitValue: aValue [
	super visitValue: aValue.
	aValue leftParens doWithIndex: [ :each :i |
		self 
			colorAndHighlightParenthesesLeft: each startPosition
			right: (aValue rightParens at: (aValue rightParens size - i + 1)) startPosition
			atNestingLevel: aValue parent nestingLevel + i.
	].
]
