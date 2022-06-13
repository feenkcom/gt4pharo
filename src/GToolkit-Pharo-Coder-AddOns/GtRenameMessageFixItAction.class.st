Class {
	#name : #GtRenameMessageFixItAction,
	#superclass : #GtCriticFixItAction,
	#instVars : [
		'selector'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics-FixIt'
}

{ #category : #'api - action' }
GtRenameMessageFixItAction >> description [
	^ 'Rename message #' , node selector , ' to #' , selector
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
	node selectorParts
		with: selector keywords
		do: [ :token :each | 
			string
				replaceFrom: token startPosition
				to: token stopPosition
				with: each ].
	^ string asString
]
