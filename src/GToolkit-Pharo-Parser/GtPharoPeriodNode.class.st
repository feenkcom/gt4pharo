Class {
	#name : #GtPharoPeriodNode,
	#superclass : #GtPharoProgramNode,
	#instVars : [
		'periods'
	],
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoPeriodNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitPeriod: self
]

{ #category : #generated }
GtPharoPeriodNode >> ignoredCompositeTokenVariables [
	^ #(#periods)
]

{ #category : #'generated-initialize-release' }
GtPharoPeriodNode >> initialize [
	super initialize.
	periods := OrderedCollection new: 2.
]

{ #category : #generated }
GtPharoPeriodNode >> periods [
	^ periods
]

{ #category : #generated }
GtPharoPeriodNode >> periods: anOrderedCollection [
	periods := anOrderedCollection
]
