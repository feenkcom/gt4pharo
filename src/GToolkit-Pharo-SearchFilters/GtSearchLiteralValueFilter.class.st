Class {
	#name : #GtSearchLiteralValueFilter,
	#superclass : #GtSearchMethodsFilter,
	#instVars : [
		'literalValue'
	],
	#category : #'GToolkit-Pharo-SearchFilters-Filters'
}

{ #category : #'instance creation' }
GtSearchLiteralValueFilter class >> forValue: aLiteralValue [
	^ self new 
		initializeForLiteralValue: aLiteralValue
]

{ #category : #comparing }
GtSearchLiteralValueFilter >> = anObject [
	^ self class = anObject class
		and: [ self literalValue = anObject literalValue ]
]

{ #category : #printing }
GtSearchLiteralValueFilter >> gtDisplayOn: stream [
	stream
		print: self literalValue;
		nextPutAll: ' literalValueMatch'
]

{ #category : #comparing }
GtSearchLiteralValueFilter >> hash [
	^ self class hash 
		bitXor: self literalValue hash
]

{ #category : #testing }
GtSearchLiteralValueFilter >> includesMethod: aCompiledMethod [
	^ aCompiledMethod hasLiteralSuchThat: [ :aLiteralValue |
		aLiteralValue = self literalValue ]
]

{ #category : #initialization }
GtSearchLiteralValueFilter >> initializeForLiteralValue: aLiteralValue [ 
	literalValue := aLiteralValue
]

{ #category : #accessing }
GtSearchLiteralValueFilter >> literalValue [
	^ literalValue
]
