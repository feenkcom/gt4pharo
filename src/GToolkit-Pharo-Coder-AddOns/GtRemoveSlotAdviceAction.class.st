Class {
	#name : #GtRemoveSlotAdviceAction,
	#superclass : #GtAdviceAction,
	#instVars : [
		'slot',
		'class'
	],
	#category : #'GToolkit-Pharo-Coder-AddOns-ObjectAdvices'
}

{ #category : #'instace creation' }
GtRemoveSlotAdviceAction class >> remove: aSlot in: aClass [
	^ self new
		slot: aSlot;
		class: aClass;
		yourself
]

{ #category : #'instace creation' }
GtRemoveSlotAdviceAction >> class: aClass [
	class := aClass
]

{ #category : #accessing }
GtRemoveSlotAdviceAction >> defaultTitle [
	^ ('Remove ' , slot name, ' in ' , class name) asRopedText
]

{ #category : #executing }
GtRemoveSlotAdviceAction >> executeOn: anElement [
	(RBRemoveInstanceVariableRefactoring remove:  slot from: class) execute
]

{ #category : #initialization }
GtRemoveSlotAdviceAction >> slot: aClass [
	slot := aClass
]
