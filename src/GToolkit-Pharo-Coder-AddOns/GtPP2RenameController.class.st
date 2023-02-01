Class {
	#name : #GtPP2RenameController,
	#superclass : #GtRenameVariableController,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Rename'
}

{ #category : #accessing }
GtPP2RenameController class >> renameIn: aSourceCoderViewModel node: aNode [
	<gtRenameMethodController>
	<gtRenameInstanceVariableController>
	(aSourceCoderViewModel behavior includesBehavior: PP2CompositeNode)
		ifFalse: [ ^ nil ].
	aNode isVariable
		ifFalse: [ (aSourceCoderViewModel behavior allInstVarNames includes: aNode selector)
				ifFalse: [ ^ nil ].
			(aNode isMessage
				ifTrue: [ aNode parent receiver ]
				ifFalse: [ aNode isMessageSend ifTrue: [ aNode receiver ] ])
				ifNotNil: [ :receiver | 
					(receiver isVariable and: [ #('self' 'super') includes: receiver source ])
						ifFalse: [ ^ nil ] ] ].
	^ self new
		sourceCoderViewModel: aSourceCoderViewModel;
		originalNode: aNode
]

{ #category : #accessing }
GtPP2RenameController >> refactoringName [
	^ 'Rename production'
]

{ #category : #accessing }
GtPP2RenameController >> rename: anOldName to: aNewName [
	| aModel aClass |

	aModel := self createModel.
	aClass := (aModel classFor: sourceCoderViewModel behavior)
		whoDefinesInstanceVariable: anOldName.

	^ GtPP2RenameRefactoring
		model: aModel
		rename: anOldName
		to: aNewName
		in: aClass
]
