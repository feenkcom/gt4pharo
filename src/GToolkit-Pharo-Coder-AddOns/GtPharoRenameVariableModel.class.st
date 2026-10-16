"
I hold the state of a rename of a variable (or another named entity): the original name, the current name, the source intervals of all occurrences (the first one is renamed by the user), and a {{gtClass:GtPharoRenameVariableValidator}}. I never change a source text. I announce {{gtClass:GtPharoRenameVariableNameChanged}} when the name changes and requests such as {{gtClass:GtPharoRenameVariableRefactoringsPreviewRequested}} and {{gtClass:GtPharoRenameVariableCancelRequested}}. Elements, such as {{gtClass:GtPharoRenameVariableEditorElement}}, and {{gtClass:GtPharoRenameVariableCoderController}} subscribe to my announcer. I am the counterpart of {{gtClass:GtPharoRenameSelectorModel}}.

# Example
{{gtExample:GtPharoRenameVariableModelExamples>>#modelWithChangedName | codeExpanded=false | previewExpanded | previewHeight=200}}
"
Class {
	#name : #GtPharoRenameVariableModel,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'originalName',
		'originalIntervals',
		'currentName',
		'validator'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #'instance creation' }
GtPharoRenameVariableModel class >> originalName: aString intervals: aCollectionOfIntervals [
	"The first interval is the one of the renamed (primary) occurrence."

	^ self new initializeOriginalName: aString intervals: aCollectionOfIntervals
]

{ #category : #accessing }
GtPharoRenameVariableModel >> announcer [
	^ announcer
]

{ #category : #accessing }
GtPharoRenameVariableModel >> currentName [
	^ currentName
]

{ #category : #initialization }
GtPharoRenameVariableModel >> initialize [
	super initialize.
	announcer := Announcer new.
	validator := GtPharoRenameVariableValidator new
]

{ #category : #initialization }
GtPharoRenameVariableModel >> initializeOriginalName: aString intervals: aCollectionOfIntervals [
	self assert: [ aString notEmpty ].
	self assert: [ aCollectionOfIntervals notEmpty ].
	originalName := aString.
	currentName := aString.
	originalIntervals := aCollectionOfIntervals asArray
]

{ #category : #testing }
GtPharoRenameVariableModel >> isModified [
	^ originalName ~= currentName
]

{ #category : #testing }
GtPharoRenameVariableModel >> isValid [
	^ validator validateVariableName: currentName
]

{ #category : #accessing }
GtPharoRenameVariableModel >> originalIntervals [
	^ originalIntervals
]

{ #category : #accessing }
GtPharoRenameVariableModel >> originalName [
	^ originalName
]

{ #category : #accessing }
GtPharoRenameVariableModel >> otherIntervals [
	^ originalIntervals allButFirst
]

{ #category : #accessing }
GtPharoRenameVariableModel >> primaryInterval [
	^ originalIntervals first
]

{ #category : #printing }
GtPharoRenameVariableModel >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: originalName;
		nextPutAll: ' -> ';
		nextPutAll: currentName;
		nextPut: $)
]

{ #category : #requests }
GtPharoRenameVariableModel >> requestCancelSource: aSource [
	announcer
		announce: (GtPharoRenameVariableCancelRequested new
				variableModel: self;
				source: aSource)
]

{ #category : #requests }
GtPharoRenameVariableModel >> requestRefactoringsPreviewSource: aSource [
	announcer
		announce: (GtPharoRenameVariableRefactoringsPreviewRequested new
				variableModel: self;
				source: aSource)
]

{ #category : #updating }
GtPharoRenameVariableModel >> updateCurrentName: aString source: aSource [
	"The name is accepted even if invalid so that a user can type freely, see {{gtMethod:GtPharoRenameVariableModel>>#isValid}}."

	currentName = aString ifTrue: [ ^ self ].
	currentName := aString.
	announcer
		announce: (GtPharoRenameVariableNameChanged new
				variableModel: self;
				currentName: currentName;
				isModified: self isModified;
				source: aSource)
]

{ #category : #accessing }
GtPharoRenameVariableModel >> validator [
	^ validator
]

{ #category : #accessing }
GtPharoRenameVariableModel >> validator: aValidator [
	validator := aValidator
]
