Class {
	#name : 'GtPharoNameNode',
	#superclass : 'GtPharoProgramNode',
	#instVars : [
		'nameParts'
	],
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : 'generated' }
GtPharoNameNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitName: self
]

{ #category : 'converting' }
GtPharoNameNode >> asString [
	^ self source asString
]

{ #category : 'converting' }
GtPharoNameNode >> asSymbol [
	^ self asString asSymbol
]

{ #category : 'generated-initialize-release' }
GtPharoNameNode >> initialize [
	super initialize.
	nameParts := OrderedCollection new: 2.
]

{ #category : 'testing' }
GtPharoNameNode >> isName [
	^ true
]

{ #category : 'generated' }
GtPharoNameNode >> nameParts [
	^ nameParts
]

{ #category : 'generated' }
GtPharoNameNode >> nameParts: anOrderedCollection [
	self setParent: self nameParts to: nil.
	nameParts := anOrderedCollection.
	self setParent: self nameParts to: self
]

{ #category : 'generated' }
GtPharoNameNode >> otherVariables [
	^ #(#nameParts)
]

{ #category : 'converting' }
GtPharoNameNode >> selector [
	^ self asSymbol
]
