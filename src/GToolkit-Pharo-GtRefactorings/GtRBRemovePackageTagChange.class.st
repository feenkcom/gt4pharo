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

{ #category : #private }
GtRBRemovePackageTagChange >> primitiveExecute [
	self package removeClassTag: tagName
]

{ #category : #accessing }
GtRBRemovePackageTagChange >> tagName [
	^ tagName
]

{ #category : #accessing }
GtRBRemovePackageTagChange >> tagName: aString [
	tagName := aString asSymbol
]
