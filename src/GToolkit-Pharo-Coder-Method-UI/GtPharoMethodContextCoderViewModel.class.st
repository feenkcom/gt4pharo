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

{ #category : #accessing }
GtPharoMethodContextCoderViewModel >> context [
	^ self coderModel context
]

{ #category : #'private - evaluation' }
GtPharoMethodContextCoderViewModel >> evaluationContext [
	^ super evaluationContext
		runtimeContext: self context
]

{ #category : #initialization }
GtPharoMethodContextCoderViewModel >> initialize [
	super initialize.
	
	expanded := false
]

{ #category : #'private - event handling' }
GtPharoMethodContextCoderViewModel >> onBehaviorChanged: aBehaviorChangedAnnouncement [
	self announce: ((GtTextualCoderViewModelBehaviorChanged new newBehavior: (aBehaviorChangedAnnouncement newBehavior)))
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
	aSourceCode isModifiedPromise then: [ :isModified |
		isModified ifFalse: [ self updateProgramCounterRange: aSourceCode ] ]
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
		ifNil: [ ProgramCounterTextAttribute := (BlTextDecorationAttribute new underline
					color: BrGlamorousColors errorBackgroundColor;
					thickness: 1.5) beNotOverwritableByStyler ]
]

{ #category : #'api - coder model' }
GtPharoMethodContextCoderViewModel >> subscribeToCoderModel [
	super subscribeToCoderModel.

	self coderModel weak
		when: GtCoderBehaviorChanged
		send: #onBehaviorChanged:
		to: self
]

{ #category : #'private - updating' }
GtPharoMethodContextCoderViewModel >> updateProgramCounterRange [
	self updateProgramCounterRange: self coderModel sourceCode
]

{ #category : #'private - updating' }
GtPharoMethodContextCoderViewModel >> updateProgramCounterRange: aSourceCode [
	aSourceCode currentSourceText
		then: [ :aSourceText | 
			self programCounterRange
				ifNotNil: [ :anInterval | 
					programCounterAttributes
						ifNotNil: [ :theAttributes | self removeCoderTextAttributes: theAttributes ].
					programCounterAttributes := self
							addTextAttribute: self programCounterTextAttribute
							onText: aSourceText text
							from: (anInterval first min: aSourceText text size)
							to: (anInterval last min: aSourceText text size) ] ]
]
