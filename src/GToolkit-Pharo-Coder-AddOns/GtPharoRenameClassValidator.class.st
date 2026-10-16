"
I validate the new name of a class. Compared to {{gtClass:GtPharoRenameVariableValidator}}, the name must start with an uppercase letter and must not be the name of a global, see {{gtMethod:RBRenameClassRefactoring>>#applicabilityPreconditions}}. The original name is a global, so I do not accept it.

# Example
{{gtExample:GtPharoRenameClassCoderControllerExamples>>#installedController_validation | codeExpanded=false | previewExpanded | previewHeight=200}}
"
Class {
	#name : #GtPharoRenameClassValidator,
	#superclass : #GtPharoRenameVariableValidator,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #validation }
GtPharoRenameClassValidator >> validateVariableName: aString [
	"A class name starts with an uppercase letter and is not the name of a global, see {{gtMethod:RBRenameClassRefactoring>>#applicabilityPreconditions}}."

	(super validateVariableName: aString) ifFalse: [ ^ false ].
	aString first isUppercase ifFalse: [ ^ false ].
	^ (Smalltalk globals includesKey: aString asSymbol) not
]
