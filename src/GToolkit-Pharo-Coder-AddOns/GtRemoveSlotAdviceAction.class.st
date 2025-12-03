Class {
	#name : #GtRemoveSlotAdviceAction,
	#superclass : #GtAdviceAction,
	#instVars : [
		'slot'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #'instace creation' }
GtRemoveSlotAdviceAction class >> remove: aSlot [
	^(self new)
		slot: aSlot;
		yourself
]

{ #category : #accessing }
GtRemoveSlotAdviceAction >> defaultTitle [
	^ ('Remove ' , slot name, ' in ' , slot owningClass name) asRopedText
]

{ #category : #executing }
GtRemoveSlotAdviceAction >> executeOn: anElement [
	(RBRemoveInstanceVariableRefactoring remove: slot name from: slot owningClass)
		execute
]

{ #category : #initialization }
GtRemoveSlotAdviceAction >> slot: aClass [
	slot := aClass
]
