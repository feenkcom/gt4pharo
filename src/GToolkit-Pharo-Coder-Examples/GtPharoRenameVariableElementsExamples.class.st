"
I contain examples of {{gtClass:GtPharoRenameVariableEditorElement}}, {{gtClass:GtPharoRenameVariableOccurrenceElement}} and {{gtClass:GtPharoRenameVariableRefactoringsPreviewElement}}.
"
Class {
	#name : #GtPharoRenameVariableElementsExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #examples }
GtPharoRenameVariableElementsExamples >> editorElement [
	<gtExample>
	<return: #GtPharoRenameVariableEditorElement>
	| aModel anElement |
	aModel := GtPharoRenameVariableModelExamples new modelWithThreeOccurrences.
	anElement := GtPharoRenameVariableEditorElement new variableModel: aModel.
	self assert: anElement editorElement text asString equals: 'value'.
	^ anElement
]

{ #category : #examples }
GtPharoRenameVariableElementsExamples >> editorElementEnterRequestsPreview [
	<gtExample>
	<return: #GtPharoRenameVariableEditorElement>
	| anElement anAnnouncement |
	anElement := self editorElement.
	anElement variableModel announcer
		weak
		when: GtPharoRenameVariableRefactoringsPreviewRequested
		do: [ :each | anAnnouncement := each ]
		for: self.
	anElement onEnterShortcut: BlShortcutEvent new.
	self assert: anAnnouncement isNotNil.
	self assert: anAnnouncement source equals: anElement.
	^ anElement
]

{ #category : #examples }
GtPharoRenameVariableElementsExamples >> editorElementEscapeRequestsCancel [
	<gtExample>
	<return: #GtPharoRenameVariableEditorElement>
	| anElement anAnnouncement |
	anElement := self editorElement.
	anElement variableModel announcer
		weak
		when: GtPharoRenameVariableCancelRequested
		do: [ :each | anAnnouncement := each ]
		for: self.
	anElement onEscapeShortcut: BlShortcutEvent new.
	self assert: anAnnouncement isNotNil.
	self assert: anAnnouncement source equals: anElement.
	^ anElement
]

{ #category : #examples }
GtPharoRenameVariableElementsExamples >> editorElementFollowsModel [
	<gtExample>
	<return: #GtPharoRenameVariableEditorElement>
	| anElement |
	anElement := self editorElement.
	anElement variableModel updateCurrentName: 'other' source: self.
	self assert: anElement editorElement text asString equals: 'other'.
	^ anElement
]

{ #category : #examples }
GtPharoRenameVariableElementsExamples >> editorElementUpdatesModel [
	<gtExample>
	<return: #GtPharoRenameVariableEditorElement>
	| anElement |
	anElement := self editorElement.
	anElement onBrTextEditorModifiedEvent: (BrTextEditorModifiedEvent new text: 'typed' asRopedText).
	self assert: anElement variableModel currentName equals: 'typed'.
	self assert: anElement variableModel isModified.
	^ anElement
]

{ #category : #examples }
GtPharoRenameVariableElementsExamples >> occurrenceElement [
	<gtExample>
	<return: #GtPharoRenameVariableOccurrenceElement>
	| aModel anElement |
	aModel := GtPharoRenameVariableModelExamples new modelWithThreeOccurrences.
	anElement := GtPharoRenameVariableOccurrenceElement new variableModel: aModel.
	self assert: anElement labelElement text asString equals: 'value'.
	aModel updateCurrentName: 'other' source: self.
	self assert: anElement labelElement text asString equals: 'other'.
	^ anElement
]

{ #category : #examples }
GtPharoRenameVariableElementsExamples >> previewElementConfiguration [
	<gtExample>
	<return: #GtPharoRenameVariableRefactoringsPreviewElement>
	| aModel anElement aCalled |
	aModel := GtPharoRenameVariableModelExamples new modelWithThreeOccurrences.
	anElement := GtPharoRenameVariableRefactoringsPreviewElement new variableModel: aModel.
	anElement
		configureWith: (GtRefactoringsConfiguration new
				refactoringsBlock: [ aCalled := true.
					#() ];
				completionAction: [  ];
				cancelAction: [  ];
				showWhenCreated: false).
	self assert: anElement previewElement isNotNil.
	^ anElement
]

{ #category : #examples }
GtPharoRenameVariableElementsExamples >> previewElementVisibility [
	<gtExample>
	<return: #GtPharoRenameVariableRefactoringsPreviewElement>
	| aModel anElement |
	aModel := GtPharoRenameVariableModelExamples new modelWithThreeOccurrences.
	anElement := GtPharoRenameVariableRefactoringsPreviewElement new variableModel: aModel.
	self assert: anElement visibility isHidden.
	aModel updateCurrentName: 'other' source: self.
	self assert: anElement visibility isVisible.
	aModel updateCurrentName: '1 invalid' source: self.
	self assert: anElement visibility isHidden.
	aModel updateCurrentName: 'value' source: self.
	self assert: anElement visibility isHidden.
	^ anElement
]
