Class {
	#name : #GtBehaviorCoderHeaderSlotNotFoundError,
	#superclass : #GtBehaviorCoderHeaderSlotError,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Errors'
}

{ #category : #accessing }
GtBehaviorCoderHeaderSlotNotFoundError >> description [
	^ 'Slot named {1} is not found in the definition' format: { self slotName }
]
