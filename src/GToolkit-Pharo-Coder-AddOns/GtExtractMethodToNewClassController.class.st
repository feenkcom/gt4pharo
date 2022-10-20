Class {
	#name : #GtExtractMethodToNewClassController,
	#superclass : #GtExtractMethodController,
	#instVars : [
		'classDefinition',
		'addClassAttribute'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtExtractMethodToNewClassController >> addCreateClassAttributeFor: aMessage [
	| stencilBlock attribute adornmentAttribute |
	addClassAttribute
		ifNotNil: [ self sourceCoderViewModel removeCoderTextAttributes: addClassAttribute ].
	stencilBlock := [ | element |
		element := GtPharoCreateBehaviorElement new.
		element behaviorBlock: [ :cls |  ].
		element forDefinition: self classDefinition.
		element
			childNamed: element class saveButtonName
			ifFound: [ :button | button visibility: BlVisibility gone ].
		element addAptitude: BrShadowAptitude.
		element background: Color white.
		element margin: (BlInsets all: 10).
		element
			constraintsDo: [ :c | 
				c textFlow pushLine.
				c horizontal matchParent ].
		element ].
	attribute := BrGlamorousTriangleExpanderTextAttribute new.
	attribute isExpanded: true.
	attribute beNotOverwritableByStyler.
	attribute
		attributesCreatingBlock: [ adornmentAttribute := BrTextAdornmentDynamicAttribute new
					beAppend;
					stencil: stencilBlock ].
	addClassAttribute := self sourceCoderViewModel
			addTextAttribute: attribute
			from: aMessage parent receiver receiver stopPosition
			to: aMessage parent receiver receiver stopPosition
]

{ #category : #accessing }
GtExtractMethodToNewClassController >> addRefactoringPreview [
	| message refactoring |
	message := self findExtractedSend.
	message ifNil: [ ^ self cancelRefactoring ].
	self addCreateClassAttributeFor: message.

	super addRefactoringPreview
]

{ #category : #accessing }
GtExtractMethodToNewClassController >> classDefinition [
	classDefinition
		ifNil: [ classDefinition := GtClassDefinition forNew.

			(self sourceCoderViewModel compiledMethod
				ifNil: [ self sourceCoderViewModel behavior instanceSide ])
				ifNotNil: [ :obj | 
					obj package
						ifNotNil: [ :package | 
							classDefinition category package name: package name.
							self sourceCoderViewModel behavior instanceSide package == package
								ifTrue: [ (package classTagForClass: self sourceCoderViewModel behavior instanceSide)
										ifNotNil: [ :tag | classDefinition category tag name: tag name ] ] ] ].
			classDefinition announcer
				when: GtBehaviorChangeEvent
				send: #value:
				to: [ :event | 
					(event isKindOf: GtBehaviorRenamed)
						ifTrue: [ self updateClassFrom: event oldName to: event newName ].
					self installRenamerAt: renameIndex ] ].
	^ classDefinition
]

{ #category : #accessing }
GtExtractMethodToNewClassController >> createModel [
	| model |
	model := super createModel.
	model defineClass: self classDefinition asDefinitionString.
	^ model
]

{ #category : #accessing }
GtExtractMethodToNewClassController >> findExtractedSend [
	^ self findExtractedSendFor: self classDefinition name
]

{ #category : #accessing }
GtExtractMethodToNewClassController >> findExtractedSendFor: aString [
	[ self sourceAst
		withAllNodesOfType: GtPharoMessageNode
		do: [ :each | 
			(each selector = self extractedSelector
				and: [ ((1 to: methodArguments size)
						allSatisfy: [ :i | 
							(each isBinary ifTrue: [ each value ] ifFalse: [ each values at: i ]) source
								= (methodArguments at: i) or: [ (each values at: i) source = 'self' ] ])
						and: [ (each parent receiver isKindOf: GtPharoMessageSendNode)
								and: [ each parent receiver selector = #new
										and: [ (each parent receiver receiver isKindOf: GtPharoVariableNode)
												and: [ each parent receiver receiver name value = aString ] ] ] ] ])
				ifTrue: [ ^ each ] ] ] on: SmaCCParserError do: [ :ex | ^ nil ].
	^ nil
]

{ #category : #accessing }
GtExtractMethodToNewClassController >> refactoring [
	| refactoring model |
	model := self createModel.
	refactoring := GtExtractMethodToComponentRefactoring
			model: model
			extract: self extractionInterval
			from: methodSelector
			in: (model classFor: sourceCoderViewModel behavior).
	refactoring
		setOption: #selfArgumentName
			toUse: [ :ref | 
				| name |
				name := sourceCoderViewModel behavior name asString
						copyReplaceAll: ' class'
						with: 'Class'.
				(name first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ]) , name ];
		setOption: #selectVariableToMoveTo
			toUse: [ :ref :cls :sel | self classDefinition name , ' new' ];
		setOption: #variableTypesForReceiver
			toUse: [ :ref | {ref model classNamed: self classDefinition name} ];
		setOption: #variableTypes
			toUse: [ :ref :types :selected | {ref model classNamed: self classDefinition name} ].
	^ refactoring
]

{ #category : #accessing }
GtExtractMethodToNewClassController >> setDefaultOptionsOn: aRefactoring [
	super setDefaultOptionsOn: aRefactoring.
	aRefactoring
		setOption: #useExistingMethod toUse: [ :ref :sel | false ];
		setOption: #extractAssignment toUse: [ :ref :varName | false ]
]

{ #category : #accessing }
GtExtractMethodToNewClassController >> setPreviewOptionsOn: aRefactoring [
	super setPreviewOptionsOn: aRefactoring.
	aRefactoring
		setOption: #useExistingMethod toUse: [ :ref :sel | false ];
		setOption: #extractAssignment toUse: [ :ref :varName | false ]
]

{ #category : #accessing }
GtExtractMethodToNewClassController >> updateClassFrom: oldName to: newName [
	| var source |
	var := (self findExtractedSendFor: oldName)
			ifNotNil: [ :message | message parent receiver receiver ].
	var ifNil: [ ^ self ].
	source := self sourceCoderViewModel sourceText asString.
	self
		setText: ((source first: var startPosition - 1) , newName
				, (source allButFirst: var stopPosition)) asRopedText
]
