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

{ #category : #transforming }
GtRBRenameProtocolRefactoring >> basicTransform [
	| hasMethod |
	hasMethod := false.
	class selectors
		select: [ :each | (class protocolsFor: each) includes: oldName ]
		thenDo: [ :each | 
			hasMethod := true.
			model
				selector: each
				in: class
				classified: newName ].
	hasMethod
		ifFalse: [ model changes
				addChange: (RBAddProtocolChange addProtocolNamed: newName in: class).
			oldName = Protocol unclassified
				ifFalse: [ model changes
						addChange: (RBRemoveProtocolChange removeProtocolNamed: oldName in: class) ] ]
]

{ #category : #accessing }
GtRBRenameProtocolRefactoring >> gtDescription [
	^ 'Rename protocol ' , oldName , ' to ' , newName
]

{ #category : #preconditions }
GtRBRenameProtocolRefactoring >> preconditions [
	^ RBCondition
		withBlock: [ (class protocols includes: oldName)
			or: [ class realClass
				ifNil: [ false ]
				ifNotNil: [ :cls | 
					cls protocolNames includes: oldName ] ] ]
]

{ #category : #transforming }
GtRBRenameProtocolRefactoring >> privateTransform [
	self basicTransform
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
	self basicTransform
]
