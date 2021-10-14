Class {
	#name : #GtPharoMethodCoderViewModelPromised,
	#superclass : #GtPharoSourceCoderViewModelPromised,
	#instVars : [
		'savePreventors'
	],
	#category : #'GToolkit-Pharo-Coder-Promised'
}

{ #category : #'api - actions' }
GtPharoMethodCoderViewModelPromised >> allowSave [
	"Remove all save prventors and recompute the updated save availability"

	savePreventors removeAll.
	self notifySaveEnabled
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModelPromised >> allowSaveDueTo: aSavePreventor [
	savePreventors
		remove: aSavePreventor
		ifAbsent: [ ^ self ].
		
	savePreventors
		ifNotEmpty: [ ^ self ].
		
	self notifySaveEnabled
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModelPromised >> behavior [
	^ self coderModel behavior
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModelPromised >> compile [
	<return: #Boolean>

	^ self coderModel compileInContext: self evaluationContext
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModelPromised >> compiledMethod [
	<return: #CompiledMethod>

	^ self coderModel compiledMethod
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModelPromised >> discardChanges [
	super discardChanges.
	self allowSave
]

{ #category : #accessing }
GtPharoMethodCoderViewModelPromised >> elementClass [
	^ super elementClass
	"self coders
		ifNil: [ ^ GtExpandableMethodCoderElement ].

	^ self coders isForClass
		ifTrue: [ GtExpandableMethodCoderForBehaviorElement ]
		ifFalse: [ GtExpandableMethodCoderElement ]"
]

{ #category : #'private - evaluation' }
GtPharoMethodCoderViewModelPromised >> evaluationContext [
	^ super evaluationContext
		receiverObject: (self selfObject ifNil: [ self behavior instanceSide ])
]

{ #category : #'gt-extension' }
GtPharoMethodCoderViewModelPromised >> gtInfo [
	^ super gtInfo, (Array streamContents: [ :aStream |
		aStream nextPut: (#saveEnabled -> self isSaveEnabled).
		self isSaveEnabled
			ifFalse: [ aStream nextPut: (#savePreventors -> savePreventors asArray) ] ])
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModelPromised >> hasDeclaredVariableNamed: aVariableName [
	"Return true if a variable with a given name is declared"
	<return: #Boolean>
	
	(super hasDeclaredVariableNamed: aVariableName)
		ifTrue: [ ^ true ].
		
	(self behavior classThatDefinesInstVarNamed: aVariableName)
		 ifNotNil: [ ^ true ].
		
	(self behavior classThatDefinesClassVariable: aVariableName)
		 ifNotNil: [ ^ true ].

	^ false
]

{ #category : #initialization }
GtPharoMethodCoderViewModelPromised >> initialize [
	super initialize.
	
	savePreventors := OrderedCollection new
]

{ #category : #testing }
GtPharoMethodCoderViewModelPromised >> isFromTrait [
	^ self coderModel isFromTrait
]

{ #category : #testing }
GtPharoMethodCoderViewModelPromised >> isMeta [
	"Return true if the method is implemented in a pharo metaclass (~ class side)"
	<return: #Boolean>

	^ self coderModel isMeta
]

{ #category : #testing }
GtPharoMethodCoderViewModelPromised >> isOverridden [
	^ self coderModel isOverridden
]

{ #category : #testing }
GtPharoMethodCoderViewModelPromised >> isOverriding [
	^ self coderModel isOverriding
]

{ #category : #testing }
GtPharoMethodCoderViewModelPromised >> isSaveEnabled [
	^ savePreventors isEmpty
]

{ #category : #'private - notifying' }
GtPharoMethodCoderViewModelPromised >> notifySaveDisabled [
	self announce: (GtMethodCoderSaveDisabled new preventors: savePreventors asArray)
]

{ #category : #'private - notifying' }
GtPharoMethodCoderViewModelPromised >> notifySaveEnabled [
	self announce: (GtMethodCoderSaveEnabled new)
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModelPromised >> playAll [
	"Evaluate the whole source code and inspect the result"

	^ self coder playAllInContext: (self evaluationContext all; receiverObject: self receiverObjectToPlay)
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModelPromised >> playAllAndInspect [
	"Evaluate the whole source code and inspect the result"
	
	^ self coder playAllAndInspectInContext: (self evaluationContext all; receiverObject: self receiverObjectToPlay)
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModelPromised >> preventSaveDueTo: aSavePreventor [
	(savePreventors includes: aSavePreventor)
		ifTrue: [ ^ self ].

	savePreventors add: aSavePreventor.

	savePreventors size > 1
		ifTrue: [ ^ self ].
		
	self notifySaveDisabled
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModelPromised >> protocol [
	<return: #String>

	^ self coderModel protocol
]

{ #category : #private }
GtPharoMethodCoderViewModelPromised >> receiverObjectToPlay [
	self isMeta ifTrue: [ ^ self behavior instanceSide ].
	^ self selfObject
		ifNil: [ self behavior new ]
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModelPromised >> save [
	<return: #Boolean>
	
	self isSaveEnabled
		ifFalse: [ ^ self ].

	^ self coderModel saveInContext: self evaluationContext
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModelPromised >> selector [
	^ self coderModel selector
]
