"
I validate the new name of a class variable. Compared to {{gtClass:GtPharoRenameVariableValidator}}, the name must start with an uppercase letter and must not be the name of a global, see {{gtMethod:RBRenameClassVariableRefactoring>>#applicabilityPreconditions}}.

# Example
{{gtExample:GtPharoRenameClassVariableCoderControllerExamples>>#installedController_validation | codeExpanded=false | previewExpanded | previewHeight=200}}
"
Class {
	#name : #GtPharoRenameClassVariableValidator,
	#superclass : #GtPharoRenameVariableValidator,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Method New'
}

{ #category : #validation }
GtPharoRenameClassVariableValidator >> validateVariableName: aString [
	"A class variable name starts with an uppercase letter and is not the name of a global."

	(super validateVariableName: aString) ifFalse: [ ^ false ].
	aString first isUppercase ifFalse: [ ^ false ].
	^ (Smalltalk globals includesKey: aString asSymbol) not
]
