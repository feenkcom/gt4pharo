Class {
	#name : #GtPharoSourceCoderRefactoringController,
	#superclass : #GtSourceCoderRefactoringController,
	#instVars : [
		'modelUpdater'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Base'
}

{ #category : #'private - attributes' }
GtPharoSourceCoderRefactoringController >> addRefactoringChangesPreview: aRefactoring at: aTextPosition whenComplete: aBlock [
	self removeRefactoringAttribute.
	refactoringPreviewAttributes := self sourceCoderViewModel
			addTextAttribute: (self
					createRefactoringChangesAttributeFor: aRefactoring
					onCompletion: aBlock)
			from: aTextPosition
			to: aTextPosition
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> addRefactoringPreview [
	| refactoring |
	self isValidForPreview ifFalse: [ ^ self cancelRefactoring ].
	refactoring := self refactoring.
	refactoring ifNil: [ ^ self cancelRefactoring ].
	self setPreviewOptionsOn: refactoring.
	self
		addRefactoringChangesPreview: refactoring
		at: self previewPosition
		whenComplete: [ :event | self finishRefactoring: event refactorings anyOne ]
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> ast [
	^ sourceCoderViewModel astSync
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> behavior [
	^ sourceCoderViewModel behavior
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> compileSnippetMethodIn: model [
	| cls |
	cls := model classFor: self snippetClass.
	cls
		compile: self snippetSelector , ' ' , self sourceText asString
		classified: #accessing
]

{ #category : #executing }
GtPharoSourceCoderRefactoringController >> createModel [
	| model modelClass |
	model := GtRBNamespace onEnvironment: RBBrowserEnvironment new.
	model name: self refactoringName.
	sourceCoderViewModel coderModel isForMethod
		ifTrue: [ modelClass := model classFor: sourceCoderViewModel behavior.
			(modelClass sourceCodeFor: sourceCoderViewModel selector)
				~= originalSource asString
				ifTrue: [ modelClass
						compile: originalSource asString
						classified: sourceCoderViewModel protocol ] ].
	^ model
]

{ #category : #'private - attributes' }
GtPharoSourceCoderRefactoringController >> createRefactoringChangesAttributeFor: aRefactoring onCompletion: aBlock [
	^ GtRefactoringChangesAttribute new
		refactoring: aRefactoring;
		completionAction: aBlock;
		cancelAction: [ self cancelRefactoring ];
		showWhenCreated: self previewDisplaysImmediately
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> createRefactoringModel [
	| aModel aBehavior aProtocol aSourceString aCurrentSelector |
	
	aBehavior := sourceCoderViewModel behavior.
	aProtocol := sourceCoderViewModel protocol.
	aSourceString := sourceCoderViewModel sourceText asString.
	aCurrentSelector := sourceCoderViewModel coderModel currentSelector.
	
	aModel := Smalltalk createRbNamespace onEnvironment: RBBrowserEnvironment new.
	(((aModel classFor: aBehavior) directlyDefinesMethod: aCurrentSelector) not
		or: [ ((aModel classFor: aBehavior) sourceCodeFor: aCurrentSelector) ~= aSourceString ])
		ifTrue: [ (aModel classFor: aBehavior) compile: aSourceString classified: aProtocol ].

	aModel name: self refactoringName.

	^ aModel
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> createSnippetRefactoringModel [
	| model |
	model := Smalltalk createRbNamespace
			onEnvironment: RBBrowserEnvironment new.
	self compileSnippetMethodIn: model.
	self modelUpdater cull: model.
	^ model
]

{ #category : #executing }
GtPharoSourceCoderRefactoringController >> findNodeAssigning: aString [
	self ast allNodesDo: [ :each | (each isAssignment and: [ each variable source = aString ]) ifTrue: [ ^ each variable ] ].
	^ nil
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> finishRefactoring: refactoring [
	^ self cleanUp
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> isValidForPreview [
	^ true
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> modelUpdater [
	^ modelUpdater ifNil: [ [ :model |  ] ]
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> modelUpdater: aBlock [
	modelUpdater := aBlock
]

{ #category : #executing }
GtPharoSourceCoderRefactoringController >> openRefactoringPreview [
	element ifNil: [ ^ false ].
	element
		allChildrenBreadthFirstDo: [ :each | 
			(each isKindOf: GtRefactoringsInDropdownPreviewElement)
				ifTrue: [ each openPreview.
					^ true ] ].
	^ false
]

{ #category : #testing }
GtPharoSourceCoderRefactoringController >> previewDisplaysImmediately [
	^ false
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> previewPosition [
	self subclassResponsibility
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> refactoredSnippetCodeFrom: refactoring [
	| ast |
	ast := ((refactoring model classFor: self snippetClass)
			methodFor: self snippetSelector) ast body.
	ast temporaryNames do: [ :each | ast removeTemporaryNamed: each ].
	^ ast formattedCode
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> safeMethodName: methodName in: modelClass [
	| selector name argCount |
	argCount := methodName arguments size.
	argCount = 0
		ifTrue: [ name := '_' ]
		ifFalse: [ | ast |
			ast := self ast.
			name := String
					streamContents: [ :stream | 
						methodName arguments
							do: [ :each | 
								| part |
								part := '_:'.
								ast variables
									doWithIndex: [ :var :index | 
										var variableName asString = each
											ifTrue: [ part := (ast selectorParts at: index) source ] ].
								stream nextPutAll: part ] ] ].
	[ selector := name asSymbol.
	modelClass hierarchyDefinesMethod: selector ]
		whileTrue: [ name last = $:
				ifTrue: [ name := name allButLast , '_:' ]
				ifFalse: [ name := name , '_' ] ].
	^ selector
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> selector [
	^ sourceCoderViewModel selector
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> selfArgumentName [
	| name |
	name := sourceCoderViewModel behavior name asString
			copyReplaceAll: ' class'
			with: 'Class'.
	^ (name first isVowel ifTrue: [ 'an' ] ifFalse: [ 'a' ]) , name
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> setPreviewOptionsOn: refactoring [ 
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> snippetClass [
	^ nil class
]

{ #category : #accessing }
GtPharoSourceCoderRefactoringController >> snippetIntervalFor: anInterval [
	^ anInterval first + self snippetSelector size + 1
		to: anInterval last + self snippetSelector size + 1
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> snippetSelector [
	^ #_
]

{ #category : #private }
GtPharoSourceCoderRefactoringController >> sourceAst [
	^ GtPharoParser
		parse: self sourceText characters asString
		startingAt: self parserStartingState
]
