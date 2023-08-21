Class {
	#name : #GtRBRenameProtocolRefactoring,
	#superclass : #RBClassRefactoring,
	#instVars : [
		'class',
		'oldName',
		'newName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Refactorings'
}

{ #category : #'instance creation' }
GtRBRenameProtocolRefactoring class >> renameProtocol: oldName in: aClass to: newName [
	^ self new
		renameProtocol: oldName
		in: aClass
		to: newName
]

{ #category : #preconditions }
GtRBRenameProtocolRefactoring >> preconditions [
	^ RBCondition withBlock: [ class protocols includes: oldName ]
]

{ #category : #initialization }
GtRBRenameProtocolRefactoring >> renameProtocol: anOldName in: aClass to: aNewName [
	className := aClass name.
	class := self model classFor: aClass.
	oldName := anOldName.
	newName := aNewName
]

{ #category : #transforming }
GtRBRenameProtocolRefactoring >> transform [
	class allSelectors
		select: [ :each | (class protocolsFor: each) includes: oldName ]
		thenDo: [ :each | 
			model
				selector: each
				in: class
				classified: newName ]
]
