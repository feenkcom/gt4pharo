Class {
	#name : #GtRemoveExtraPeriodsFixItAction,
	#superclass : #GtMethodAdviceFixItAction,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices-FixIt'
}

{ #category : #'as yet unclassified' }
GtRemoveExtraPeriodsFixItAction class >> removeExtraPeriods [
	<gtExample>
	^ self
		testOriginal: 'a |b| . self foo... ^self printString..'
		generates: 'a |b|  self foo. ^self printString.'
		forNode: [ :method | method body ]
]

{ #category : #'as yet unclassified' }
GtRemoveExtraPeriodsFixItAction >> description [
	^ 'Remove unnecessary periods'
]

{ #category : #'as yet unclassified' }
GtRemoveExtraPeriodsFixItAction >> id [
	^ GtRemoveExtraPeriodsFixItActionElementId
]

{ #category : #'as yet unclassified' }
GtRemoveExtraPeriodsFixItAction >> updateSource [
	| string |
	string := SmaCCString on: node completeSource.
	node extraPeriodsDo: [ :each | string deleteFrom: each to: each ].
	^ string asString
]
