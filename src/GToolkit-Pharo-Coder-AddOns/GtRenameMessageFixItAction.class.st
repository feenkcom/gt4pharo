Class {
	#name : #GtRenameMessageFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#instVars : [
		'selector'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #examples }
GtRenameMessageFixItAction class >> renameCollect [
	<gtExample>
	^ self
		testOriginal: 'a (1 to: 10) collect: [:i | Transcript print: i; cr]'
		generates: 'a (1 to: 10) do: [:i | Transcript print: i; cr]'
		forNode: [ :method | method body statements last message ]
		configure: [ :action | action selector: #do: ]
]

{ #category : #'api - action' }
GtRenameMessageFixItAction >> description [
	^ 'Rename #'
		, (node isMessage 
				ifTrue: [ node selector ] 
				ifFalse: [ node literalValue ])
		, ' to #' , selector
]

{ #category : #'api - action' }
GtRenameMessageFixItAction >> id [
	^ GtRenameMessageFixItActionElementId
]

{ #category : #accessing }
GtRenameMessageFixItAction >> selector [
	^ selector
]

{ #category : #accessing }
GtRenameMessageFixItAction >> selector: aSymbol [
	selector := aSymbol
]

{ #category : #private }
GtRenameMessageFixItAction >> updateSource [
	| string |
	string := SmaCCString on: node topParent completeSource.
	node isMessage
		ifTrue: [ node selectorParts
				with: selector keywords
				do: [ :token :each | 
					string
						replaceFrom: token startPosition
						to: token stopPosition
						with: each ] ]
		ifFalse: [ string
				replaceFrom: node startPosition
				to: node stopPosition
				with: selector storeString ].
	^ string asString
]
