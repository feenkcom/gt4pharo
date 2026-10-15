"
I create text attributes that display a rename of a {{gtClass:GtPharoRenameVariableModel}} in a text editor without changing the text: {{gtClass:GtPharoRenameVariableEditorElement}} replaces the renamed occurrence, {{gtClass:GtPharoRenameVariableOccurrenceElement}} replaces the other occurrences and {{gtClass:GtPharoRenameVariableRefactoringsPreviewElement}} is appended. See {{gtMethod:GtPharoRenameVariableAttributesStencil>>#create}}. I am the counterpart of {{gtClass:GtPharoRenameSelectorAttributesStencil}}.

# Example
{{gtExample:GtPharoRenameVariableModelRustEditorExamples>>#rustScripterEditorWithInstAPlusOneMethod_refactoringsPreview | codeExpanded=false | previewExpanded | previewHeight=400}}
"
Class {
	#name : #GtPharoRenameVariableAttributesStencil,
	#superclass : #Object,
	#instVars : [
		'variableModel',
		'refactoringsConfiguration'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #creation }
GtPharoRenameVariableAttributesStencil >> create [
	"Return an array of triples `{ start. stop. attribute }`."

	^ Array
		streamContents: [ :aStream | 
			self createEditorAttributeInto: aStream.
			self createOccurrenceAttributesInto: aStream.
			self createRefactoringsPreviewAttributeInto: aStream ]
]

{ #category : #creation }
GtPharoRenameVariableAttributesStencil >> createEditorAttributeInto: aStream [
	| anInterval anAttribute |
	anInterval := variableModel primaryInterval.
	anAttribute := self
			replacingAttributeWith: [ :aPiece :anEditorElement | 
				| anElement |
				anElement := GtPharoRenameVariableEditorElement new
						variableModel: variableModel;
						id: #'variable-editor';
						margin: (BlInsets left: -2 right: -2).
				anElement requestFocus.
				anElement ].
	aStream nextPut: {anInterval first. anInterval last. anAttribute}
]

{ #category : #creation }
GtPharoRenameVariableAttributesStencil >> createOccurrenceAttributesInto: aStream [
	variableModel otherIntervals
		withIndexDo: [ :eachInterval :eachIndex | 
			| anAttribute |
			anAttribute := self
					replacingAttributeWith: [ :aPiece :anEditorElement | 
						GtPharoRenameVariableOccurrenceElement new
							variableModel: variableModel;
							id: (#'variable-occurrence' asBlocElementId indexed: eachIndex);
							margin: (BlInsets left: -2 right: -2) ].
			aStream nextPut: {eachInterval first. eachInterval last. anAttribute} ]
]

{ #category : #creation }
GtPharoRenameVariableAttributesStencil >> createRefactoringsPreviewAttributeInto: aStream [
	| anAttribute anInterval |
	anInterval := variableModel primaryInterval.
	anAttribute := BrTextAdornmentDynamicAttribute new
			beAppend;
			beNotOverwritableByStyler;
			stencil: [ :aPiece :anEditorElement | 
				| anElement |
				anElement := GtPharoRenameVariableRefactoringsPreviewElement new
						variableModel: variableModel;
						id: #'variable-refactorings-preview'.
				refactoringsConfiguration
					ifNotNil: [ :aConfiguration | anElement configureWith: aConfiguration ].
				anElement ].
	aStream nextPut: {anInterval last. anInterval last. anAttribute}
]

{ #category : #accessing }
GtPharoRenameVariableAttributesStencil >> refactoringsConfiguration [
	^ refactoringsConfiguration
]

{ #category : #accessing }
GtPharoRenameVariableAttributesStencil >> refactoringsConfiguration: anObject [
	refactoringsConfiguration := anObject
]

{ #category : #private }
GtPharoRenameVariableAttributesStencil >> replacingAttributeWith: aStencilBlock [
	^ BrTextAdornmentDynamicAttribute new
		beReplace;
		beNotOverwritableByStyler;
		stencil: aStencilBlock
]

{ #category : #accessing }
GtPharoRenameVariableAttributesStencil >> variableModel [
	^ variableModel
]

{ #category : #accessing }
GtPharoRenameVariableAttributesStencil >> variableModel: anObject [
	variableModel := anObject
]
