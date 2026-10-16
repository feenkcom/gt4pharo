"
I rename a temporary variable or an argument of a method or a block in a coder. Only the occurrences that are defined by the same scope are renamed, a variable of a nested scope with the same name is a different variable, see {{gtMethod:GtPharoRenameTemporaryCoderController>>#otherRenameIntervals}}. The new name must not be a reserved name, a variable that is visible in the scope, or a variable of the class, see {{gtMethod:GtPharoRenameTemporaryCoderController>>#forbiddenNames}}.

There are no refactorings, so there is no refactorings preview. Enter replaces the text of all occurrences in the source of the coder, see {{gtMethod:GtPharoRenameTemporaryCoderController>>#acceptRename}}. Escape cancels the rename. Until then the source is not changed. I replace the rename of a temporary variable that is implemented by {{gtClass:GtCoderViewModelRenameAction}}. See {{gtMethod:GtPharoSourceCoder>>#renameNewNode:in:documentId:for:}}.

# Example
{{gtExample:GtPharoRenameVariableModelRustEditorExamples>>#rustScripterEditorWithTempReceiverMethod_enterAppliesRename | codeExpanded=false | previewExpanded | previewHeight=400}}
"
Class {
	#name : #GtPharoRenameTemporaryCoderController,
	#superclass : #GtPharoRenameVariableCoderController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #actions }
GtPharoRenameTemporaryCoderController >> acceptRename [
	"Replace the text of all occurrences. Nothing happens if the new name is not valid."

	| aNewSource |
	variableModel isModified ifFalse: [ ^ self uninstall ].
	variableModel isValid ifFalse: [ ^ self ].

	aNewSource := self sourceAfterRename.
	self uninstall.
	sourceCoderViewModel
		sourceText: aNewSource asRopedText
		from: self
		synchronously: true
]

{ #category : #hooks }
GtPharoRenameTemporaryCoderController >> createRefactoringsStencil [
	"A temporary variable is renamed in the source of the coder, there are no refactorings."

	^ nil
]

{ #category : #hooks }
GtPharoRenameTemporaryCoderController >> forbiddenNames [
	"The new name must not be a reserved name, the name of a variable that is visible in the scope of the variable, or the name of a variable of the class."

	| aDefiner someParents someNames aBehavior |
	aDefiner := originalNode whoDefines.
	someParents := aDefiner allParents.
	someNames := Set withAll: self reservedNames.
	aDefiner
		withAllNodesDo: [ :each | each isVariable ifTrue: [ someNames add: each source ] ].
	originalNode topParent
		withAllNodesDo: [ :each | 
			(each isVariable
				and: [ each whoDefines
						ifNil: [ false ]
						ifNotNil: [ :anOtherDefiner | someParents anySatisfy: [ :eachParent | eachParent == anOtherDefiner ] ] ])
				ifTrue: [ someNames add: each source ] ].
	aBehavior := sourceCoderViewModel behavior.
	aBehavior
		ifNotNil: [ someNames addAll: aBehavior allInstVarNames.
			someNames addAll: (aBehavior instanceSide allClassVarNames collect: #asString) ].
	^ someNames asArray
]

{ #category : #hooks }
GtPharoRenameTemporaryCoderController >> includesRefactoringsPreview [
	^ false
]

{ #category : #'event handling' }
GtPharoRenameTemporaryCoderController >> onGtPharoRenameVariableRefactoringsPreviewRequested: anAnnouncement [
	anAnnouncement variableModel = variableModel ifFalse: [ ^ self ].

	self acceptRename
]

{ #category : #hooks }
GtPharoRenameTemporaryCoderController >> otherRenameIntervals [
	"Only the occurrences that are defined by the same scope are renamed, a variable of a nested scope that has the same name is a different variable."

	| aDefiner someIntervals |
	aDefiner := originalNode whoDefines.
	someIntervals := OrderedCollection new.
	aDefiner
		withAllNodesDo: [ :each | 
			(each ~~ originalNode
				and: [ each isVariable
						and: [ each source = self originalName and: [ each whoDefines == aDefiner ] ] ])
				ifTrue: [ someIntervals add: each name sourceInterval ] ].
	^ someIntervals
]

{ #category : #hooks }
GtPharoRenameTemporaryCoderController >> refactoringName [
	^ 'Rename temporary variable'
]

{ #category : #hooks }
GtPharoRenameTemporaryCoderController >> reservedNames [
	^ #('self' 'super' 'true' 'false' 'nil' 'thisContext')
]

{ #category : #installation }
GtPharoRenameTemporaryCoderController >> safelyInstall [
	super safelyInstall.

	"There are no refactorings to preview, the request to display them applies the rename."
	variableModel announcer
		when: GtPharoRenameVariableRefactoringsPreviewRequested
		send: #onGtPharoRenameVariableRefactoringsPreviewRequested:
		to: self
]

{ #category : #actions }
GtPharoRenameTemporaryCoderController >> sourceAfterRename [
	"Return the source of the coder in which all occurrences are replaced by the new name."

	| aSource aPosition |
	aSource := sourceCoderViewModel sourceText asString.
	aPosition := 1.
	^ String
		streamContents: [ :aStream | 
			(variableModel originalIntervals
				asSortedCollection: [ :a :b | a first <= b first ])
				do: [ :eachInterval | 
					aStream
						nextPutAll: (aSource copyFrom: aPosition to: eachInterval first - 1);
						nextPutAll: variableModel currentName.
					aPosition := eachInterval last + 1 ].
			aStream nextPutAll: (aSource copyFrom: aPosition to: aSource size) ]
]
