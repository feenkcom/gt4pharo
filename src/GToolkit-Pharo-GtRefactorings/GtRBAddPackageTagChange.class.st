Class {
	#name : #GtRBAddPackageTagChange,
	#superclass : #GtRBAddPackageChange,
	#instVars : [
		'tagName'
	],
	#category : #'GToolkit-Pharo-GtRefactorings-Changes'
}

{ #category : #'instance creation' }
GtRBAddPackageTagChange class >> packageName: aString tagName: tagName [
	^ (self packageName: aString)
		tagName: tagName;
		yourself
]

{ #category : #converting }
GtRBAddPackageTagChange >> asUndoOperation [
	^ self package isNil
		ifTrue: [ GtRBRemovePackageChange packageName: packageName ]
		ifFalse: [ GtRBRemovePackageTagChange packageName: packageName tagName: tagName ]
]

{ #category : #private }
GtRBAddPackageTagChange >> primitiveExecute [
	self package isNil
		ifTrue: [ super primitiveExecute ].
	self package addClassTag: tagName
]

{ #category : #accessing }
GtRBAddPackageTagChange >> tag [
	^ self package
		ifNotNil: [ :pkg | pkg tagNamed: tagName ifAbsent: [  ] ]
]

{ #category : #accessing }
GtRBAddPackageTagChange >> tagName [
	^ tagName
]

{ #category : #accessing }
GtRBAddPackageTagChange >> tagName: aString [
	tagName := aString asSymbol
]
