Class {
	#name : #GtRBRemovePackageTagChange,
	#superclass : #GtRBPackageChange,
	#instVars : [
		'tagName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #'instance creation' }
GtRBRemovePackageTagChange class >> packageName: aString tagName: tagName [
	^ (self packageName: aString)
		tagName: tagName;
		yourself
]

{ #category : #converting }
GtRBRemovePackageTagChange >> asUndoOperation [
	^ GtRBAddPackageTagChange packageName: packageName tagName: tagName
]

{ #category : #accessing }
GtRBRemovePackageTagChange >> gtChangeIcon [
	^ Smalltalk ui icons iconNamed: #changeRemove
]

{ #category : #accessing }
GtRBRemovePackageTagChange >> gtChangedObject [
	^ self tag
]

{ #category : #private }
GtRBRemovePackageTagChange >> primitiveExecute [
	self package removeClassTag: tagName
]

{ #category : #accessing }
GtRBRemovePackageTagChange >> tag [
	^ self package
		ifNotNil: [ :pkg | pkg tagNamed: tagName ifAbsent: [  ] ]
]

{ #category : #accessing }
GtRBRemovePackageTagChange >> tagName [
	^ tagName
]

{ #category : #accessing }
GtRBRemovePackageTagChange >> tagName: aString [
	tagName := aString asSymbol
]
