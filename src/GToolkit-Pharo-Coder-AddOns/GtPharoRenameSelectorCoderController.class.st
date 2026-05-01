Class {
	#name : #GtPharoRenameSelectorCoderController,
	#superclass : #Object,
	#instVars : [
		'sourceCoderViewModel',
		'originalNode',
		'documentId',
		'editorElement',
		'selectorModel',
		'attributeTags',
		'refactoringsStencil'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #private }
GtPharoRenameSelectorCoderController >> allowSave [
	sourceCoderViewModel allowSaveDueTo: self
]

{ #category : #private }
GtPharoRenameSelectorCoderController >> computeRefactorings [
	^ refactoringsStencil create
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> documentId [
	^ documentId
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> documentId: anObject [
	documentId := anObject
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> editorElement: anObject [
	editorElement := anObject
]

{ #category : #views }
GtPharoRenameSelectorCoderController >> gtSelectorModelFor: aView [
	<gtView>
	selectorModel ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Selector';
		object: [ selectorModel ];
		view: #gtSelectorViewFor:
]

{ #category : #private }
GtPharoRenameSelectorCoderController >> informException: anException [
	editorElement ifNil: [ ^ self ].
	editorElement
		showNotification: (GtObjectNotificationMessage new
				message: ('[{1}] {2}'
						format: {anException class name.
								anException messageText});
				object: anException copy freeze;
				showNotifications)
]

{ #category : #initialization }
GtPharoRenameSelectorCoderController >> install [
	"Taken from `GtSourceCoderRefactoringController>>#execute`"

	[ self safelyInstall ]
		on: Error
		do: [ :anException | 
			(anException isKindOf: RBRefactoringError)
				ifTrue: [ self inform: self refactoringName , ': ' , anException messageText ]
				ifFalse: [ self informException: anException.
					NonInteractiveTranscript stderr
						nextPutAll: ('[{1}] {2}'
								format: {self class name.
										anException asString});
						cr.

					(anException signalerContext stack first: 20)
						do: [ :eachStackEntry | 
							NonInteractiveTranscript stderr
								nextPutAll: eachStackEntry printString;
								cr ] ].
			self uninstall.
			anException return ]
]

{ #category : #initialization }
GtPharoRenameSelectorCoderController >> installAttributes [
	| aStencil someAttributes |
	aStencil := GtPharoRenameSelectorAttributesStencil new
			refactoringsConfiguration: (GtRefactoringsConfiguration new
					refactoringsBlock: [ self computeRefactorings ];
					completionAction: [ self uninstall ];
					cancelAction: [ self uninstall ];
					showWhenCreated: false).
	aStencil selectorModel: selectorModel.
	someAttributes := aStencil create.

	attributeTags := someAttributes
			collect: [ :eachCol | 
				editorElement
					addAttribute: (eachCol at: 3)
					overRange: (BrTextCharacterRange
							start: (eachCol at: 1)
							end: (eachCol at: 2)
							documentId: documentId) ]
]

{ #category : #'private - event handling' }
GtPharoRenameSelectorCoderController >> onGtPharoRenameSelectorModelRefactoringsCancelRequested: anAnnouncement [
	anAnnouncement selectorModel = selectorModel ifFalse: [ ^ self ].

	self uninstall
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> originalNode [
	^ originalNode
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> originalNode: anObject [
	originalNode := anObject
]

{ #category : #private }
GtPharoRenameSelectorCoderController >> preventSave [
	sourceCoderViewModel preventSaveDueTo: self
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> refactoringName [
	"Same in `GtPharoRenameSelectorRefactoringsStencil>>#refactoringName`."

	^ 'Rename method'
]

{ #category : #initialization }
GtPharoRenameSelectorCoderController >> removeAttributes [
	attributeTags ifNil: [ ^ self ].

	attributeTags do: [ :eachTag | editorElement removeAttributeTagged: eachTag ]
]

{ #category : #private }
GtPharoRenameSelectorCoderController >> safelyInstall [
	selectorModel := GtPharoRenameSelectorModel forAstNode: originalNode.
	refactoringsStencil := GtPharoRenameSelectorCoderRefactoringsStencil new
			selectorModel: selectorModel;
			sourceCoderViewModel: sourceCoderViewModel.

	self preventSave.
	self installAttributes.

	selectorModel announcer
		when: GtPharoRenameSelectorModelRefactoringsCancelRequested
		send: #onGtPharoRenameSelectorModelRefactoringsCancelRequested:
		to: self.

	editorElement userData at: #selectorController put: self.
	editorElement userData at: #selectorModel put: selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> selectorModel [
	^ selectorModel
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> sourceCoderViewModel [
	^ sourceCoderViewModel
]

{ #category : #accessing }
GtPharoRenameSelectorCoderController >> sourceCoderViewModel: anObject [
	sourceCoderViewModel := anObject
]

{ #category : #initialization }
GtPharoRenameSelectorCoderController >> uninstall [
	self removeAttributes.
	self allowSave.

	editorElement userData removeKey: self class ifAbsent: [  "ignore" ]
]
