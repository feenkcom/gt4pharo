Class {
	#name : #GtBehaviorCoderHeaderTagNotFoundError,
	#superclass : #GtBehaviorCoderHeaderTagError,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Errors'
}

{ #category : #accessing }
GtBehaviorCoderHeaderTagNotFoundError >> description [
	^ 'Tag named {1} is not found in the definition' format: { self tagName }
]
