Class {
	#name : #GtPharoSourceCoderEvaluationContext,
	#superclass : #GtSourceCoderEvaluationContext,
	#instVars : [
		'bindingStrategy',
		'receiverObject',
		'runtimeContext'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Context'
}

{ #category : #accessing }
GtPharoSourceCoderEvaluationContext >> addBindings: aTGtVariableBindings [
	bindingStrategy addBindings: aTGtVariableBindings
]

{ #category : #binding }
GtPharoSourceCoderEvaluationContext >> bindingOf: aSymbol [
	"aSymbol is a variable name.
	Return a literal variable if the variable has a value assigned.
	Return nil, if the variable has no value assigned."
	<return: #LiteralVariable or: nil>
	
	^ self bindingStrategy bindingOf: aSymbol
]

{ #category : #accessing }
GtPharoSourceCoderEvaluationContext >> bindingStrategy [
	<return: #TGtVariablesBindings>

	^ bindingStrategy
]

{ #category : #accessing }
GtPharoSourceCoderEvaluationContext >> bindingStrategy: aGtBindingStrategy [
	self
		assert: [ aGtBindingStrategy class usesTrait: TGtVariablesBindings ]
		description: [ 'Must implement variable bindings trait' ].

	bindingStrategy := aGtBindingStrategy
]

{ #category : #accessing }
GtPharoSourceCoderEvaluationContext >> bindings [
	<return: #TGtVariablesBindings>

	^ bindingStrategy
]

{ #category : #testing }
GtPharoSourceCoderEvaluationContext >> canAddBindingOf: aSymbol [
	^ true
]

{ #category : #hack }
GtPharoSourceCoderEvaluationContext >> correctFrom: fromIndex to: toIndex with: aString [
	NonInteractiveTranscript stdout
		nextPut: $[;
		nextPutAll: self coder class name;
		nextPut: $];
		space;
		nextPutAll: 'Correct from';
		space;
		print: fromIndex;
		space;
		nextPutAll: ' to ';
		print: toIndex;
		nextPutAll: ' with ';
		print: aString;
		cr.

	self coder
		correctFrom: sourceInterval first + fromIndex - 1
		to: sourceInterval first + toIndex - 1
		with: aString.

	sourceInterval := sourceInterval first to: sourceInterval last + aString size - (toIndex - fromIndex + 1)
]

{ #category : #hack }
GtPharoSourceCoderEvaluationContext >> editor [
	"Hack to handle inserting local variables"

	^ self
]

{ #category : #binding }
GtPharoSourceCoderEvaluationContext >> hasBindingOf: aSymbol [
	<return: #Boolean>

	^ self bindingStrategy hasBindingOf: aSymbol
]

{ #category : #initialization }
GtPharoSourceCoderEvaluationContext >> initialize [
	super initialize.

	bindingStrategy := GtCompositeVariablesBindings new
		addBindings: GtReservedVariablesBindings new;
		addBindings: GtGlobalVariablesBindings new.
]

{ #category : #testing }
GtPharoSourceCoderEvaluationContext >> isForScripting [
	^true
]

{ #category : #testing }
GtPharoSourceCoderEvaluationContext >> needRequestorScope [
	^true
]

{ #category : #hack }
GtPharoSourceCoderEvaluationContext >> notify: message at: anIndex in: aString [
	"Hack to work with pharo compiler"

	| aCompleteTextIndex |
	aCompleteTextIndex := evaluatedInterval first + anIndex - 1.

	NonInteractiveTranscript stdout
		nextPut: $[;
		nextPutAll: self coder class name;
		nextPut: $];
		space;
		nextPutAll: (message copyReplaceAll: '->' with: '') trimmed;
		space;
		nextPutAll: 'at ';
		print: aCompleteTextIndex;
		cr.

	self coder
		ifNil: [ ^ SyntaxErrorNotification
				inClass: UndefinedObject
				withCode: aString
				doitFlag: false
				errorMessage: aString
				location: anIndex ].

	self coder
		notifyParseError: message
		at: aCompleteTextIndex
		requesterObject: self requesterObject
]

{ #category : #hack }
GtPharoSourceCoderEvaluationContext >> paragraph [
	"Hack to handle inserting local variables"

	^ self
]

{ #category : #accessing }
GtPharoSourceCoderEvaluationContext >> receiverObject [
	"Return an object that should be bound to `self`"

	^ receiverObject
]

{ #category : #accessing }
GtPharoSourceCoderEvaluationContext >> receiverObject: anObject [
	"Assign an object that should be bound to self"

	receiverObject := anObject
]

{ #category : #accessing }
GtPharoSourceCoderEvaluationContext >> runtimeContext [
	<return: #Context>

	^ runtimeContext
]

{ #category : #accessing }
GtPharoSourceCoderEvaluationContext >> runtimeContext: aContext [
	"Assign an optional pharo runtime Context.
	May be useful when evaluating pharo code in a presence of a running system (live debugger, code snippets in dedbugger) "

	runtimeContext := aContext
]

{ #category : #hack }
GtPharoSourceCoderEvaluationContext >> text [
	"Hack to work with pharo compiler"

	^ sourceString
]

{ #category : #hack }
GtPharoSourceCoderEvaluationContext >> textMorph [
	"Hack to handle inserting local variables"

	^ self
]

{ #category : #binding }
GtPharoSourceCoderEvaluationContext >> variableValueOf: aVariableName ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self bindingStrategy
		bindingValueOf: aVariableName
		ifPresent: aPresentBlock
		ifAbsent: [ self runtimeContext
				ifNotNil: [ :aContext | 
					(aContext hasTemporaryVariableNamed: aVariableName)
						ifTrue: [ aPresentBlock cull: (aContext tempNamed: aVariableName) ]
						ifFalse: anAbsentBlock ]
				ifNil: anAbsentBlock ]
]

{ #category : #binding }
GtPharoSourceCoderEvaluationContext >> withSnippetBindingStrategy [
	bindingStrategy addBindings: GtSharedVariablesBindings new
]
