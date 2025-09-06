Class {
	#name : #GtPharoMethodContextCoderViewModel,
	#superclass : #GtPharoMethodCoderViewModel,
	#instVars : [
		'programCounterAttributes'
	],
	#classVars : [
		'ProgramCounterTextAttribute'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! View Models'
}

{ #category : #'as yet unclassified' }
GtPharoMethodContextCoderViewModel >> addBreakpointAtCursorLocation [
	super addBreakpointAtCursorLocation.
	
	self coderModel gtUpdateContextWithCurrentMethod.
]

{ #category : #accessing }
GtPharoMethodContextCoderViewModel >> compositeVariableBindingsForStyling [
	"The context variable bindings is added for styling purposes,
	allowing expansion of methods that are defined on variable receivers, 
	e.g., `aReceiver copyWith: aValue`.
	
	We cannot add the context variable bindings to the default composite variable
	bindings, because it breaks tools. For example, then it is not possible to save 
	(compile) methods, notifying that variables are shadowed."

	| theBindings |
	theBindings := super compositeVariableBindingsForStyling.
	self context
		ifNotNil: [ :aContext | theBindings addBindings: (GtContextVariablesBindings new context: aContext) ].

	^ theBindings
]

{ #category : #accessing }
GtPharoMethodContextCoderViewModel >> context [
	^ self coderModel context
]

{ #category : #'private - evaluation' }
GtPharoMethodContextCoderViewModel >> evaluationContext [
	^ super evaluationContext
		runtimeContext: self context
]

{ #category : #testing }
GtPharoMethodContextCoderViewModel >> hasDeclaredVariableNamed: aVariableName [
	(super hasDeclaredVariableNamed: aVariableName) ifTrue: [ ^ true ].
	
	^ self compiledMethod isDoIt and: [
		self compiledMethod allLiterals anySatisfy: [ :aVariable |
			((aVariable class = WorkspaceVariable) or: [
				aVariable class = DoItVariable] ) and: [ 
					aVariable name = aVariableName ] ] ] 
]

{ #category : #initialization }
GtPharoMethodContextCoderViewModel >> initialize [
	super initialize.
	
	expanded := false
]

{ #category : #'api - coder model' }
GtPharoMethodContextCoderViewModel >> onCoderModelChanged [
	super onCoderModelChanged.
	
	self updateProgramCounterRange: self coderModel sourceCode
]

{ #category : #'private - event handling' }
GtPharoMethodContextCoderViewModel >> onSourceCodeChanged: anSourceCodeChangedAnnouncement [
	| aSourceCode |
	super onSourceCodeChanged: anSourceCodeChangedAnnouncement.

	aSourceCode := self coderModel sourceCode.
	aSourceCode isModified
		ifFalse: [ self updateProgramCounterRange: aSourceCode ]
]

{ #category : #'private - event handling' }
GtPharoMethodContextCoderViewModel >> onSourceCodeReplaced: aSourceCodeReplacedAnnouncement [
	super onSourceCodeReplaced: aSourceCodeReplacedAnnouncement.
	self updateProgramCounterRange: aSourceCodeReplacedAnnouncement sourceCode
]

{ #category : #accessing }
GtPharoMethodContextCoderViewModel >> programCounterRange [
	^ self coderModel programCounterRange
]

{ #category : #'private - updating' }
GtPharoMethodContextCoderViewModel >> programCounterTextAttribute [
	^ ProgramCounterTextAttribute
		ifNil: [ ProgramCounterTextAttribute := (BlTextHighlightAttribute paint: BrGlamorousColors debuggerTextHighlightColor) beNotOverwritableByStyler ]
]

{ #category : #accessing }
GtPharoMethodContextCoderViewModel >> receiverClass [
	^ self coderModel receiverClass
]

{ #category : #'private - updating' }
GtPharoMethodContextCoderViewModel >> updateProgramCounterRange [
	self updateProgramCounterRange: self coderModel sourceCode.
	self announce: GtTextualCoderViewModelReadyToRestyle new
]

{ #category : #'private - updating' }
GtPharoMethodContextCoderViewModel >> updateProgramCounterRange: aSourceCode [
	| aSourceText |
	aSourceText := aSourceCode currentSourceText.
	self programCounterRange
		ifNotNil: [ :anInterval | 
			programCounterAttributes ifNotNil: [ :theAttributes | 
				self removeCoderTextAttributes: theAttributes ].
			programCounterAttributes := self
					addTextAttribute: self programCounterTextAttribute
					onText: aSourceText text
					from: (anInterval first min: aSourceText text size)
					to: (anInterval last min: aSourceText text size) ]
]
