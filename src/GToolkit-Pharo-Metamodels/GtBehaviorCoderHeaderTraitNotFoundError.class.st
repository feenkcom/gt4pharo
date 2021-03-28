Class {
	#name : #GtBehaviorCoderHeaderTraitNotFoundError,
	#superclass : #GtBehaviorCoderHeaderTraitError,
	#category : #'GToolkit-Pharo-Metamodels-Behavior - Errors'
}

{ #category : #accessing }
GtBehaviorCoderHeaderTraitNotFoundError >> description [
	^ 'Trait named {1} is not found in the definition' format: { self traitName }
]
