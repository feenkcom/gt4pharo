Class {
	#name : #GtBehaviorCoderHeaderPoolNotFoundError,
	#superclass : #GtBehaviorCoderHeaderPoolError,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Errors'
}

{ #category : #accessing }
GtBehaviorCoderHeaderPoolNotFoundError >> description [
	^ 'Pool named {1} is not found in the definition' format: { self poolName }
]
