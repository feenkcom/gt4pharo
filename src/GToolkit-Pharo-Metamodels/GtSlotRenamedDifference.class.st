Class {
	#name : #GtSlotRenamedDifference,
	#superclass : #GtSlotDifference,
	#instVars : [
		'oldName',
		'newName'
	],
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Differences'
}

{ #category : #accessing }
GtSlotRenamedDifference >> newName [
	^ newName
]

{ #category : #accessing }
GtSlotRenamedDifference >> newName: anObject [
	newName := anObject
]

{ #category : #accessing }
GtSlotRenamedDifference >> oldName [
	^ oldName
]

{ #category : #accessing }
GtSlotRenamedDifference >> oldName: anObject [
	oldName := anObject
]

{ #category : #printing }
GtSlotRenamedDifference >> printOn: aStream [
	aStream
		nextPutAll: 'Renamed ';
		print: self oldName;
		nextPutAll: ' slot to ';
		print: self newName
]
