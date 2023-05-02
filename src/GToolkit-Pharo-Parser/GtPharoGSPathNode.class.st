Class {
	#name : #GtPharoGSPathNode,
	#superclass : #GtPharoValueNode,
	#instVars : [
		'name'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoGSPathNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitGSPath: self
]

{ #category : #generated }
GtPharoGSPathNode >> name [
	^ name
]

{ #category : #generated }
GtPharoGSPathNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
GtPharoGSPathNode >> tokenVariables [
	^ #(#name)
]
