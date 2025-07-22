Class {
	#name : #GtCoderExpandableBaselineStyler,
	#superclass : #GtGenericPharoStyler,
	#category : #'GToolkit-Pharo-Coder-AddOns-Expandable baseline'
}

{ #category : #private }
GtCoderExpandableBaselineStyler >> isNonEmptyLiteralStringNode: nameNode [
	^ nameNode isLiteral
		and: [ nameNode literalValue isString
			and: [ nameNode literalValue notEmpty ] ]
]

{ #category : #private }
GtCoderExpandableBaselineStyler >> styleBaselineMessage: aMessageNode [
	| aBaselineNameNode anExpanderAttribute |

	aBaselineNameNode := aMessageNode arguments first.

	(self isNonEmptyLiteralStringNode: aBaselineNameNode)
		ifFalse: [ ^ self ].

	self
		attribute: (GtCompletionStrategyAttribute new strategy: GtBaselineOfClassCompletionStrategy new)
		from: aBaselineNameNode value startPosition
		to: aBaselineNameNode value stopPosition.

	(Smalltalk globals
		includesKey: ('BaselineOf' , aBaselineNameNode literalValue asString) asSymbol)
		ifFalse: [ ^ self ].

	anExpanderAttribute := (BrGlamorousTriangleExpanderTextAttribute new
		id: GtSourceCoderEmbeddedExpanderToggleId;
		attributesCreatingBlock: [
			BrTextAdornmentDynamicAttribute new
				beAppend;
				stencil: [ | aBaselineMethod aBaselineMethodCoder |
					aBaselineMethod := (self class environment
						at: ('BaselineOf' , aBaselineNameNode literalValue asString) asSymbol) >> #baseline:.
					aBaselineMethodCoder := GtPharoMethodCoder forMethod: aBaselineMethod.
					aBaselineMethodCoder subscribeToSystem.
					(aBaselineMethodCoder asCoderViewModel expanded: true) asElement. ] ]).

	self
		attribute: anExpanderAttribute
		from: aBaselineNameNode value stopPosition
		to: aBaselineNameNode value stopPosition.
]

{ #category : #private }
GtCoderExpandableBaselineStyler >> stylePackageMessage: aMessageNode [
	| aPackageNameNode aPackageName aPackage anExpanderAttribute |
	aPackageNameNode := aMessageNode arguments first.

	(self isNonEmptyLiteralStringNode: aPackageNameNode) ifFalse: [ ^ self ].

	self
		attribute: (GtCompletionStrategyAttribute new
				strategy: GtBaselinePackageCompletionStrategy new)
		from: aPackageNameNode value startPosition
		to: aPackageNameNode value stopPosition.	"Let's add expander for existing (and loaded) packages"
	aPackageName := aPackageNameNode literalValue asString asSymbol.
	aPackage := self packageOrganizer
			packageNamed: aPackageName
			ifAbsent: [ ^ self ].

	anExpanderAttribute := BrGlamorousTriangleExpanderTextAttribute new
			id: GtSourceCoderEmbeddedExpanderToggleId;
			attributesCreatingBlock: [ BrTextAdornmentDynamicAttribute new
					beAppend;
					stencil: [ | aModel aViewModel anElement |
						aModel := GtPharoPackageCoder forPackage: aPackage.
						aViewModel := aModel asCoderViewModel.
						anElement := GtPharoPackageCoderElement new coderViewModel: aViewModel.
						anElement
							height: 400;
							background: Color white;
							margin: (BlInsets
									top: 3
									right: 10
									bottom: 10
									left: 10);
							addAptitude: BrShadowAptitude new + BrGlamorousWithVerticalResizerAptitude new beBottom.
						anElement ] ].
	self
		attribute: anExpanderAttribute
		from: aPackageNameNode value stopPosition
		to: aPackageNameNode value stopPosition
]

{ #category : #private }
GtCoderExpandableBaselineStyler >> styleSameStrings: aStringLiteralNodel [
	| aStringMarker aStringHighlightAttribute theStringOccurences |
	
	aStringMarker := BrTextInvisibleMarkerAttribute new.
	aStringHighlightAttribute := (GtPharoDynamicHighlightAttribute paint: BrGlamorousColors neutralBackgroundColor).

	theStringOccurences := OrderedCollection new.
	
	aStringLiteralNodel topParent 
		allNodesOfType: aStringLiteralNodel class
		do: [ :aNode |
			aNode string = aStringLiteralNodel string 
				ifTrue: [ theStringOccurences add: aNode ] ].
		
	theStringOccurences size <= 1
		ifTrue: [ ^ self ].

	theStringOccurences do: [ :eachNode | 
		(text
			from: eachNode startPosition
			to: eachNode stopPosition)
				attribute: aStringMarker;
				onCursorEnter: [ :aTextEditor :anEvent | 
					aTextEditor text
						findAttribute: aStringMarker
						indicesDo: [ :aVariableStart :aVariableEnd |
							aTextEditor text
								attribute: aStringHighlightAttribute
								from: aVariableStart
								to: aVariableEnd ] ]
				leave: [ :aTextEditor :anEvent |
					aTextEditor text removeAttribute: aStringHighlightAttribute ] ] 
]

{ #category : #visiting }
GtCoderExpandableBaselineStyler >> visitMessage: aMessageNode [
	super visitMessage: aMessageNode.
	
	(#(baseline: #baseline:with:) includes: aMessageNode selector)
		ifTrue: [ self styleBaselineMessage: aMessageNode ].

	(#(package: #package:with:) includes: aMessageNode selector)
		ifTrue: [ self stylePackageMessage: aMessageNode ]
]

{ #category : #visiting }
GtCoderExpandableBaselineStyler >> visitStringLiteral: aStringLiteralNodel [
	super visitStringLiteral: aStringLiteralNodel.
	
	(self isNonEmptyLiteralStringNode: aStringLiteralNodel)
		ifFalse: [ ^ self ].
		
	self styleSameStrings: aStringLiteralNodel.
]
