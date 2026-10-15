Class {
	#name : #GtPharoRenameVariableCoderController,
	#superclass : #Object,
	#instVars : [
		'sourceCoderViewModel',
		'originalNode',
		'documentId',
		'editorElement',
		'variableModel',
		'attributeTags',
		'refactoringsStencil'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #installation }
GtPharoRenameVariableCoderController >> allowSave [
	sourceCoderViewModel allowSaveDueTo: self
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> attributeTags [
	^ attributeTags
]

{ #category : #refactorings }
GtPharoRenameVariableCoderController >> computeRefactorings [
	^ refactoringsStencil create
]

{ #category : #hooks }
GtPharoRenameVariableCoderController >> createRefactoringsStencil [
	"Return a ${class:GtPharoRenameVariableRefactoringsStencil}$ that computes the refactorings from the variable model."

	^ self subclassResponsibility
]

{ #category : #model }
GtPharoRenameVariableCoderController >> createVariableModel [
	| aModel |
	aModel := GtPharoRenameVariableModel
			originalName: self originalName
			intervals: {self primaryRenameInterval} , self otherRenameIntervals.
	aModel validator forbiddenNames: (self forbiddenNames copyWithout: self originalName).
	^ aModel
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> documentId [
	^ documentId
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> documentId: anObject [
	documentId := anObject
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> editorElement [
	^ editorElement
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> editorElement: anObject [
	editorElement := anObject
]

{ #category : #hooks }
GtPharoRenameVariableCoderController >> forbiddenNames [
	"Names that cannot be used as the new name."

	^ #()
]

{ #category : #views }
GtPharoRenameVariableCoderController >> gtVariableModelFor: aView [
	<gtView>
	variableModel ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Variable';
		object: [ variableModel ];
		view: #gtLiveFor:
]

{ #category : #'event handling' }
GtPharoRenameVariableCoderController >> informException: anException [
	editorElement ifNil: [ ^ self ].
	editorElement
		showNotification: (GtObjectNotificationMessage new
				message: ('[{1}] {2}'
						format: {anException class name.
								anException messageText});
				object: anException copy freeze;
				showNotifications)
]

{ #category : #installation }
GtPharoRenameVariableCoderController >> install [
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

{ #category : #installation }
GtPharoRenameVariableCoderController >> installAttributes [
	| aStencil someAttributes |
	aStencil := GtPharoRenameVariableAttributesStencil new
			variableModel: variableModel;
			refactoringsConfiguration: (GtRefactoringsConfiguration new
					refactoringsBlock: [ self computeRefactorings ];
					completionAction: [ self uninstall ];
					cancelAction: [ self uninstall ];
					showWhenCreated: false).
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

{ #category : #'event handling' }
GtPharoRenameVariableCoderController >> onGtPharoRenameVariableCancelRequested: anAnnouncement [
	anAnnouncement variableModel = variableModel ifFalse: [ ^ self ].

	self uninstall
]

{ #category : #hooks }
GtPharoRenameVariableCoderController >> originalName [
	^ originalNode source
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> originalNode [
	^ originalNode
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> originalNode: anObject [
	originalNode := anObject
]

{ #category : #hooks }
GtPharoRenameVariableCoderController >> otherRenameIntervals [
	"Source intervals of other occurrences that are renamed together with the original node."

	| someIntervals |
	someIntervals := OrderedCollection new.
	originalNode topParent
		withAllNodesDo: [ :each | 
			(each ~~ originalNode and: [ each = originalNode ])
				ifTrue: [ someIntervals add: each name sourceInterval ] ].
	^ someIntervals
]

{ #category : #installation }
GtPharoRenameVariableCoderController >> preventSave [
	sourceCoderViewModel preventSaveDueTo: self
]

{ #category : #hooks }
GtPharoRenameVariableCoderController >> primaryRenameInterval [
	"Source interval of the renamed occurrence."

	^ originalNode name sourceInterval
]

{ #category : #hooks }
GtPharoRenameVariableCoderController >> refactoringName [
	"Same in the refactorings stencil, see `${class:GtPharoRenameVariableRefactoringsStencil}$>>#refactoringName`."

	^ self subclassResponsibility
]

{ #category : #installation }
GtPharoRenameVariableCoderController >> removeAttributes [
	attributeTags ifNil: [ ^ self ].

	attributeTags do: [ :eachTag | editorElement removeAttributeTagged: eachTag ].
	attributeTags := nil
]

{ #category : #installation }
GtPharoRenameVariableCoderController >> safelyInstall [
	variableModel := self createVariableModel.
	refactoringsStencil := self createRefactoringsStencil
			variableModel: variableModel;
			sourceCoderViewModel: sourceCoderViewModel;
			yourself.

	self preventSave.
	self installAttributes.

	variableModel announcer
		when: GtPharoRenameVariableCancelRequested
		send: #onGtPharoRenameVariableCancelRequested:
		to: self.

	editorElement userData at: #variableController put: self.
	editorElement userData at: #variableModel put: variableModel
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> sourceCoderViewModel [
	^ sourceCoderViewModel
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> sourceCoderViewModel: anObject [
	sourceCoderViewModel := anObject
]

{ #category : #installation }
GtPharoRenameVariableCoderController >> uninstall [
	self removeAttributes.
	self allowSave.

	editorElement userData removeKey: #variableController ifAbsent: [  "ignore" ].
	editorElement userData removeKey: #variableModel ifAbsent: [  "ignore" ]
]

{ #category : #accessing }
GtPharoRenameVariableCoderController >> variableModel [
	^ variableModel
]
