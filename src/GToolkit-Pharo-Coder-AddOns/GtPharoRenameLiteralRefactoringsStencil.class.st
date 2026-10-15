"
I am a {{gtClass:GtPharoRenameVariableRefactoringsStencil}} for literal renames. The coder source is not modified while the user types, so I compile the source with the renamed literals into the refactoring model, see {{gtMethod:GtPharoRenameLiteralRefactoringsStencil>>#createModel}}. The refactoring then applies the modified source together with its own changes.
"
Class {
	#name : #GtPharoRenameLiteralRefactoringsStencil,
	#superclass : #GtPharoRenameVariableRefactoringsStencil,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #accessing }
GtPharoRenameLiteralRefactoringsStencil >> createModel [
	"The coder source is not modified while typing, so the renamed literals are compiled into the model, the refactoring applies them together with its own changes."

	| aModel |
	aModel := super createModel.
	sourceCoderViewModel coderModel isForMethod ifFalse: [ ^ aModel ].
	(aModel classFor: sourceCoderViewModel behavior)
		compile: self sourceAfterRename
		classified: sourceCoderViewModel protocol.
	^ aModel
]

{ #category : #accessing }
GtPharoRenameLiteralRefactoringsStencil >> sourceAfterRename [
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
